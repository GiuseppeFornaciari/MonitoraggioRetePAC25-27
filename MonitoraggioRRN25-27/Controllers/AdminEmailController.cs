using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Identity.UI.Services;
using MonitoraggioPAC25_27.Data;
using MonitoraggioPAC25_27.Models;
using System.Linq;

[Authorize(Roles = "administrator")]
public class AdminEmailController : Controller
{
    private readonly ApplicationDbContext _identityContext;
    private readonly MonitoraggioPAC2527Context _context;
    private readonly UserManager<IdentityUser> _userManager;
    private readonly IEmailSender _emailSender;

    public AdminEmailController(
        ApplicationDbContext identityContext,
        MonitoraggioPAC2527Context context,
        UserManager<IdentityUser> userManager,
        IEmailSender emailSender)
    {
        _identityContext = identityContext;
        _context = context;
        _userManager = userManager;
        _emailSender = emailSender;
    }

    //========================================================
    // INVIO MULTIPLO (pagina Index)
    //========================================================
    public IActionResult Index()
    {
        var utenti = _userManager.Users.ToList();
        return View(utenti);
    }

    [HttpPost]
    public async Task<IActionResult> InviaEmail(string subject, string message, List<string> selectedUsers)
    {
        if (string.IsNullOrWhiteSpace(subject) ||
            string.IsNullOrWhiteSpace(message))
        {
            ModelState.AddModelError("", "Oggetto e messaggio sono obbligatori.");
            return RedirectToAction(nameof(Index));
        }

        if (selectedUsers == null || !selectedUsers.Any())
        {
            ModelState.AddModelError("", "Selezionare almeno un utente.");
            return RedirectToAction(nameof(Index));
        }

        foreach (var userId in selectedUsers)
        {
            var user = await _userManager.FindByIdAsync(userId);
            if (user == null)
                continue;

            // INVIO EMAIL
            await _emailSender.SendEmailAsync(user.Email, subject, message);

            // LOG
            _context.LogEmailInvios.Add(new LogEmailInvio
            {
                UserId = user.Id,
                Email = user.Email,
                Oggetto = subject,
                Messaggio = message,
                Esito = "OK",
                DataInvio = DateTime.Now
            });
        }

        await _context.SaveChangesAsync();

        return RedirectToAction(nameof(Index));
    }

    //========================================================
    // INVIO SINGOLO + VISUALIZZAZIONE LOG (pagina SendOne)
    //========================================================
    [HttpGet]
    public IActionResult SendOne()
    {
        var vm = new AdminEmailSendOneViewModel
        {
            Oggetto = $"Credenziali Monitoraggio PAC",

            MessaggioHtml =
@"Gentile {UTENTE},
La password per accedere all'applicativo con la sua email è la seguente:

<p style=""padding:10px; background:#f2f2f2; border-left:4px solid #0d6efd;"">
[scrivere qui il testo del messaggio]
</p>

Cordiali saluti,
Monitoraggio PAC 25-27",

            //@"Gentile {UTENTE},
            //La password per accedere all'applicativo con la sua email è la seguente:
            //{TESTO}

            //Cordiali saluti,
            //Monitoraggio PAC 25-27",


            Log = _context.LogEmailInvios
                      .OrderByDescending(x => x.DataInvio)
                      .Take(50)
                      .ToList()
        };

        return View(vm);
    }

    [HttpPost]
    public async Task<IActionResult> SendOne(AdminEmailSendOneViewModel model)
    {
        if (!ModelState.IsValid)
        {
            model.Log = _context.LogEmailInvios
                .OrderByDescending(x => x.DataInvio)
                .Take(50)
                .ToList();

            return View(model);
        }

        // Trovo l'utente Identity
        var identityUser = await _userManager.FindByEmailAsync(model.Destinatario);
        string userId = identityUser?.Id ?? "N/A";

        // Recupero il codice utente reale dalla tabella Utenti
        string codUtente = null;
        if (identityUser != null)
        {
            codUtente = _context.Utentis
                .Where(u => u.idAspNetUser == identityUser.Id)
                .Select(u => u.Utente)
                .FirstOrDefault();
        }

        string userName = codUtente ?? model.Destinatario;

        // Sostituzione placeholder
        string finalBody = model.MessaggioHtml
            .Replace("{UTENTE}", userName)
            .Replace("{EMAIL}", model.Destinatario)
            .Replace("{DATA}", DateTime.Now.ToString("dd/MM/yyyy"))
            .Replace("{TESTO}", "(testo da specificare)");

        string finalSubject = model.Oggetto
            .Replace("{UTENTE}", userName)
            .Replace("{EMAIL}", model.Destinatario)
            .Replace("{DATA}", DateTime.Now.ToString("dd/MM/yyyy"));

        try
        {
            await _emailSender.SendEmailAsync(model.Destinatario, finalSubject, finalBody);

            _context.LogEmailInvios.Add(new LogEmailInvio
            {
                UserId = userId,
                Email = model.Destinatario,
                Oggetto = finalSubject,
                Messaggio = finalBody,
                Esito = "OK",
                DataInvio = DateTime.Now
            });

            await _context.SaveChangesAsync();
        }
        catch (Exception ex)
        {
            _context.LogEmailInvios.Add(new LogEmailInvio
            {
                UserId = userId,
                Email = model.Destinatario,
                Oggetto = finalSubject,
                Messaggio = finalBody,
                Esito = "Errore: " + ex.Message,
                DataInvio = DateTime.Now
            });

            await _context.SaveChangesAsync();

            ModelState.AddModelError("", "Errore durante l'invio: " + ex.Message);
        }

        // Ricarico il log (per la vista)
        model.Log = _context.LogEmailInvios
            .OrderByDescending(x => x.DataInvio)
            .Take(50)
            .ToList();

        return View(model);
    }
}