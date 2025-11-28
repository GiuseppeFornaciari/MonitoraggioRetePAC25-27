using ClosedXML.Excel;
using DocumentFormat.OpenXml.Spreadsheet;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using MonitoraggioPAC25_27.Data;
using MonitoraggioPAC25_27.Models;
using MonitoraggioPAC25_27.Services;
using System.Data;
using System.Reflection;

namespace MonitoraggioPAC25_27.Controllers
{
    public class ProgettiController : Controller
    {
        private readonly MonitoraggioPAC2527Context _context;
        private readonly RoleService _roleService;
        private readonly AllegatiService _allegatiService;

        public ProgettiController(MonitoraggioPAC2527Context context, RoleService roleService, AllegatiService allegatiService)
        {
            _context = context;
            _roleService = roleService;
            _allegatiService = allegatiService;
        }

        public async Task<IActionResult> ElencoProgetti()
        {

            string ruolo = _roleService.GetRuolo();
            string user = User.Identity.Name;

            var schede = _context.Progettis
                .Include(s => s.IdSchedaNavigation);

            if (ruolo == "responsabile scheda")
            {
                //schedeEstratte = schedeEstratte.Where(s => s.CodResponsabileNavigation.Email == user);
            }

            return View(await schede.ToListAsync());
        }

        public IActionResult NuovoProgetto()
        {
            ViewData["IdScheda"] = new SelectList(_context.Schedes, "IdScheda", "CodScheda");
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> NuovoProgetto(Progetti p)
        {
            if (ModelState.IsValid)
            {
                _context.Add(p);
                await _context.SaveChangesAsync();
                return RedirectToAction("ElencoSchedeProgetto", "Schede");
            }
            ViewData["IdScheda"] = new SelectList(_context.Schedes, "IdScheda", "CodScheda", p.IdScheda);
            return View(p);
        }


        public async Task<IActionResult> Progetto(int? id, int? idOutputDaEspandere)
        {
            if (id == null)
            {
                return NotFound();
            }

            string user = User.Identity?.Name ?? "DefaultUser";

            var progetto = await _context.Progettis
                .Include(p => p.IdSchedaNavigation)
                .Include(p => p.Outputs)
                    .ThenInclude(o => o.CodTipoOutputNavigation)
                .FirstOrDefaultAsync(p => p.idProgetto == id);

            if (progetto == null)
            {
                return NotFound();
            }

            // Verifica attivazione modifica progetto
            var emailUtente = User.Identity?.Name;

            bool responsabileProgetto = await _context.UtentiProgettoEntes
                .Include(upe => upe.idUtenteNavigation)
                .AnyAsync(upe =>
                    upe.idProgetto == id &&
                    upe.idUtenteNavigation.Email == emailUtente
                );
            ViewBag.ResponsabileProgetto = responsabileProgetto;

            bool responsabileMinistero = await _context.UtentiProgettoMinisteros
                .Include(upe => upe.idUtenteNavigation)
                .AnyAsync(upe =>
                    upe.idProgetto == id &&
                    upe.idUtenteNavigation.Email == emailUtente
                );
            ViewBag.ResponsabileMinistero = responsabileMinistero;

            // Estrai coppie CodTema + Descrizione
            var temi = await _context.Outputs
                .Where(o => o.IdProgetto == id && !string.IsNullOrWhiteSpace(o.CodTema))
                .Include(o => o.CodTemaNavigation)
                .Select(o => new { Codice = o.CodTema, Descrizione = o.CodTemaNavigation.Tema })
                .Distinct()
                .OrderBy(t => t.Codice)
                .ToListAsync();

            // Passa la lista alla view
            ViewData["Temi"] = temi;

            var schedaProgetto = _context.v_SchedeProgettiOutputs
                .Where(x => x.CodProgetto == progetto.CodProgetto)
                .FirstOrDefault();

            // Recupera gli allegati per ogni output tramite AllegatiService
            var allegatiPerOutput = progetto.Outputs.ToDictionary(
                o => o.IdOutput,
                o => _allegatiService.GetFileList(o)
            );
            ViewData["AllegatiPerOutput"] = allegatiPerOutput;

            if (schedaProgetto != null)
            {
                bool isResponsabileMinistero = await _context.UtentiProgettoMinisteros
                    .AnyAsync(u => u.idProgetto == schedaProgetto.IdProgetto && user == schedaProgetto.ResponsabiliProgettoMinisteroEmail);
                ViewData["isResponsabileMinistero"] = isResponsabileMinistero;

                ViewData["Monitoraggio"] = "20250630";
                ViewData["ResonsabiliProgettoEnte"] = schedaProgetto.ResponsabiliProgettoEnte;
                ViewData["ResonsabileSchedaEnte"] = schedaProgetto.ResponsabileScheda;
                ViewData["ResponsabiliProgettoMinistero"] = schedaProgetto.ResponsabiliProgettoMinistero;
            }
            return View(progetto);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Progetto(Progetti p)
        {
            var emailUtente = User.Identity?.Name;

            //Controllo Reponsabili PROGETTO e MINISTETO per singolo progetto
            bool isResponsabileProgetto = await _context.UtentiProgettoEntes
                   .AnyAsync(u => u.idProgetto == p.idProgetto && u.idUtenteNavigation.Email == emailUtente);

            bool isResponsabileMinistero = await _context.UtentiProgettoMinisteros
                .AnyAsync(u => u.idProgetto == p.idProgetto && u.idUtenteNavigation.Email == emailUtente);

            if (!isResponsabileProgetto && !isResponsabileMinistero)
                return Forbid();

            var tipoResponsabile = Request.Form["TipoResponsabile"];

            if (tipoResponsabile == "PROGETTO" && isResponsabileProgetto)
            {
                p.DataInserimentoResponsabileProgettoEnte = null;
                if (p.CheckInserimentoResponsabileProgettoEnte) 
                { 
                    p.DataInserimentoResponsabileProgettoEnte = DateTime.Now;
                }
            }
            else if (tipoResponsabile == "MINISTERO" && isResponsabileMinistero)
            {
                p.DataInserimentoResponsabileProgettoMinistero = null;
                if (p.CheckInserimentoResponsabileProgettoMinistero)
                {
                    p.DataInserimentoResponsabileProgettoMinistero = DateTime.Now;
                }
            }

            if (ModelState.IsValid)
            {
                _context.Update(p);
                await _context.SaveChangesAsync();
                return RedirectToAction("Progetto", new { id = p.idProgetto });
            }
            return View(p);
        }

        public async Task<IActionResult> EliminaProgetto(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var p = await _context.Progettis
                .Include(p => p.IdSchedaNavigation)
                .FirstOrDefaultAsync(m => m.idProgetto == id);
            if (p == null)
            {
                return NotFound();
            }

            return View(p);
        }

        [HttpPost, ActionName("EliminaProgetto")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var p = await _context.Progettis.FindAsync(id);
            if (p != null)
            {
                _context.Progettis.Remove(p);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction("ElencoProgetti", "Progetti");
        }
    }
}
