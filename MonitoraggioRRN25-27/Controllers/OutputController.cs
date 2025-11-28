using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Hosting;
using MonitoraggioPAC25_27.Data;
using MonitoraggioPAC25_27.Models;
using MonitoraggioPAC25_27.Models.DTO;
using MonitoraggioPAC25_27.Services;
using MonitoraggioPAC25_27.Utilities;
using System;
using System.Data;

namespace MonitoraggioPAC25_27.Controllers
{
    public class OutputController : Controller
    {
        private readonly MonitoraggioPAC2527Context _context;
        private readonly RoleService _roleService;
        private readonly IWebHostEnvironment _environment;
        private readonly string _basePath;
        private readonly AllegatiService _allegatiService;

        public OutputController(MonitoraggioPAC2527Context context, RoleService roleService, IWebHostEnvironment environment, IConfiguration configuration, AllegatiService allegatiService)
        {
            _context = context;
            _roleService = roleService;
            _environment = environment;
            _basePath = configuration["PercorsiAllegati:BasePath"]!;
            _allegatiService = allegatiService;
        }

        public async Task<IActionResult> ElencoOutput()
        {

            string ruolo = _roleService.GetRuolo();
            string user = User.Identity?.Name ?? "DefaultUser";

            var output = _context.Outputs
            .Include(s => s.CodTemaNavigation)
            .Include(s => s.IdProgettoNavigation);

            if (ruolo == "responsabile scheda")
            {
                //schedeEstratte = schedeEstratte.Where(s => s.CodResponsabileNavigation.Email == user);
            }

            return View(await output.ToListAsync());
        }

        public async Task<IActionResult> Output(int? id)
        {

            string user = User.Identity?.Name ?? "DefaultUser";

            if (id == null)
            {
                return NotFound();
            }

            var o = await _context.Outputs
                .Include(o => o.IdProgettoNavigation)
                .ThenInclude(o => o.IdSchedaNavigation)
                .Include(o => o.CodTemaNavigation)
                .FirstOrDefaultAsync(o => o.IdOutput == id);

            if (o == null)
            {
                return NotFound();
            }

            // Defensive null check for IdProgettoNavigation before accessing IdSchedaNavigation
            var schedaProgetto = _context.v_SchedeProgettiOutputs
                .Where(x => x.idOutput == o.IdOutput)
                .FirstOrDefault();

            if (schedaProgetto != null)
            {
                var respMail = schedaProgetto.ResponsabiliProgettoMinisteroEmail ?? "";

                bool isResponsabileMinistero = await _context.UtentiProgettoMinisteros
                    .AnyAsync(u => 
                        u.idProgetto == schedaProgetto.IdProgetto &&
                        respMail.Contains(user) 
                );
                
                ViewData["isResponsabileMinistero"] = isResponsabileMinistero;

                ViewData["Tema"] = schedaProgetto.Tema;
                ViewData["ResonsabiliProgettoEnte"] = schedaProgetto.ResponsabiliProgettoEnte;
                ViewData["ResonsabileSchedaEnte"] = schedaProgetto.ResponsabileScheda;
                ViewData["ResponsabiliProgettoMinistero"] = schedaProgetto.ResponsabiliProgettoMinistero;
            }
            ViewData["Monitoraggio"] = "20250630";
            ViewData["CodTema"] = new SelectList(_context.Temis, "CodTema", "Tema", o.CodTema);
            ViewData["CodTipoOutput"] = new SelectList(_context.TipiOutputs, "CodTipoOutput", "TipoOutput", o.CodTipoOutput);

            // 🔹 Recupera gli allegati per questo output tramite AllegatiService
            var allegatiOutput = _allegatiService.GetFileList(o) ?? new List<string>();
            ViewData["AllegatiOutput"] = allegatiOutput;

            return View(o);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Output(int id, Output o)
        {
            if (id != o.IdOutput)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                //registrazione data ultimo aggiornamento
                o.UltimoAggiornamento=DateTime.Now;
                
                try
                {
                    //Data Comunicazione Finale basata su Flag: in ogni caso cancella la data    
                    o.ComunicazioneData = null;
                    if (o.Comunicazione)
                    {
                        o.ComunicazioneData = DateTime.Now;
                    }
                    //Data motivazione se campo è compilato inserisce la data 
                    if (o.ParereResponsabileMinistero!=null)
                    {
                        o.ParereResponsabileMinisteroData = DateTime.Now;
                    }
                    _context.Update(o);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!OutputExists(o.IdOutput))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction("Progetto", "Progetti", new { id = o.IdProgetto });
            }
            ViewData["CodTema"] = new SelectList(_context.Temis, "CodTema", "CodTema", o.CodTema);
            ViewData["CodTipoOutput"] = new SelectList(_context.TipiOutputs, "CodTipoOutput", "CodTipoOutput", o.CodTipoOutput);
            return View(o);
        }

        public IActionResult NuovoOutput()
        {
            ViewData["CodTema"] = new SelectList(_context.Temis, "CodTema", "Tema");
            ViewData["CodTipoOutput"] = new SelectList(_context.TipiOutputs, "CodTipoOutput", "TipoOutput");
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> NuovoOutput(Output o)
        {

            if (ModelState.IsValid)
            {
                _context.Add(o);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(ElencoOutput));
            }
            ViewData["CodTema"] = new SelectList(_context.Temis, "CodTema", "CodTema", o.CodTema);
            ViewData["CodTipoOutput"] = new SelectList(_context.TipiOutputs, "CodTipoOutput", "TipoOutput", o.CodTipoOutput);
            return View(o);
        }

        public async Task<IActionResult> EliminaOutput(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var output = await _context.Outputs
                .FirstOrDefaultAsync(m => m.IdOutput == id);
            if (output == null)
            {
                return NotFound();
            }

            return View(output);
        }

        [HttpPost, ActionName("EliminaOutput")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var o = await _context.Outputs.FindAsync(id);
            if (o != null)
            {
                _context.Outputs.Remove(o);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(ElencoOutput));
        }

        private bool OutputExists(int id)
        {
            return _context.Outputs.Any(e => e.IdOutput == id);
        }

        public IActionResult GetAllegati(int id)
        {
            var output = _allegatiService.GetOutputWithNavigation(id);
            if (output == null)
                return NotFound();

            ViewBag.FileList = _allegatiService.GetFileList(output);
            return PartialView("_Allegati", output);
        }
        public List<string> GetElencoAllegati(int idOutput)
        {
            var output = _allegatiService.GetOutputWithNavigation(idOutput);
            return output == null
                ? new List<string>()
                : _allegatiService.GetFileList(output);
        }

        [HttpPost]
        public async Task<IActionResult> UploadAllegato(int idOutput, IFormFile file)
        {
            var output = _allegatiService.GetOutputWithNavigation(idOutput);
            if (output == null || file == null || file.Length == 0)
                return BadRequest("Output o file non valido");

            await _allegatiService.SaveFileAsync(output, file);
            ViewBag.FileList = _allegatiService.GetFileList(output);

            return PartialView("_Allegati", output);
        }

        public async Task<IActionResult> DownloadAllegato(int idOutput, string fileName)
        {
            var output = _allegatiService.GetOutputWithNavigation(idOutput);
            if (output == null || string.IsNullOrEmpty(fileName))
                return NotFound();

            var fileBytes = _allegatiService.GetFileContent(output, fileName, out _);
            if (fileBytes == null)
                return NotFound();

            return File(fileBytes, "application/octet-stream", fileName);
        }

        [HttpPost]
        public IActionResult DeleteAllegato([FromBody] DeleteAllegatoRequest request)
        {
            var output = _allegatiService.GetOutputWithNavigation(request.IdOutput);
            if (output == null || string.IsNullOrEmpty(request.FileName))
                return NotFound();

            _allegatiService.DeleteFile(output, request.FileName);
            ViewBag.FileList = _allegatiService.GetFileList(output);

            return PartialView("_Allegati", output);
        }
    }
}
