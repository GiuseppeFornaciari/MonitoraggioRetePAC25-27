using ClosedXML.Excel;
using DocumentFormat.OpenXml.Spreadsheet;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using MonitoraggioPAC25_27.Data;
using MonitoraggioPAC25_27.Models;
using MonitoraggioPAC25_27.Services;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Reflection;

namespace MonitoraggioPAC25_27.Controllers
{
    public class SchedeController : Controller
    {
        private readonly MonitoraggioPAC2527Context _context;
        private readonly RoleService _roleService;
        private readonly AllegatiService _allegatiService; // o IAllegatiService se esiste l'interfaccia

        public SchedeController(MonitoraggioPAC2527Context context, RoleService roleService, AllegatiService allegatiService)
        {
            _context = context;
            _roleService = roleService;
            _allegatiService = allegatiService;
        }

        //Visualizzazione Schermata comune
        //SCHEDA + PROGETTO
        [HttpGet, HttpPost]
        public async Task<IActionResult> ElencoSchedeProgetto(string? search)
        {

            string ruolo = _roleService.GetRuolo();
            string user = User.Identity.Name;


            //Elenco completo
            //var schedeEstratte = _context.v_SchedeProgettiOutputs
            //    .AsQueryable();
            var schedeQuery = _context.v_SchedeProgettiOutputs.AsQueryable();


            //TODO gestire registrazione incleta: se utente assegnato ma senza ruolo non deve fare vedre i dati.
            if (user == null )
            {
                return NotFound();
            }

            //Ruoli:
            //1 segretariato: nessun filtro vede tutto
            //5 adminitor: nessun filtro vede tutto
            //2 responsabile scheda: dove presente come responsabile scheda o progetto 
            if (ruolo == "responsabile scheda")
            {
                schedeQuery = schedeQuery.Where(s =>
                    s.ResponsabileSchedaEmail.Contains(user) ||
                    s.ResponsabiliProgettoEnteEmail.Contains(user));
            }
            //2 responsabile scheda: solo dove presente come responsabile scheda O progetto 
            //3 referente ministero: solo dove responsabile
            if (ruolo == "referente ministero")
            {
                schedeQuery = schedeQuery.Where(s =>
                    s.ResponsabiliProgettoMinisteroEmail.Contains(user));
            }
            //4 responsabile progetto


            if (!string.IsNullOrEmpty(search))
            {
                schedeQuery = schedeQuery.Where(s =>
                    (s.Scheda != null && s.Scheda.Contains(search)) ||
                    (s.ResponsabileScheda != null && s.ResponsabileScheda.Contains(search)) ||
                    (s.Progetto != null && s.Progetto.Contains(search)) ||
                    (s.CodProgetto != null && s.CodProgetto.Contains(search)) ||
                    (s.ResponsabiliProgettoEnte != null && s.ResponsabiliProgettoEnte.Contains(search)) ||
                    (s.ResponsabiliProgettoMinistero != null && s.ResponsabiliProgettoMinistero.Contains(search))
                );
            }

            // Proiezione dei campi desiderati e rimozione dei duplicati
            var result = await schedeQuery
                .Select(s => new SchedaProgettoDTO
                {
                    CodScheda = s.CodScheda,
                    Scheda = s.Scheda,
                    ResponsabileScheda = s.ResponsabileScheda,
                    ResponsabileSchedaEmail = s.ResponsabileSchedaEmail,
                    IdProgetto = s.IdProgetto,
                    CodProgetto = s.CodProgetto,
                    Progetto = s.Progetto,
                    ResponsabiliProgettoMinistero = s.ResponsabiliProgettoMinistero,
                    ResponsabiliProgettoMinisteroEmail = s.ResponsabiliProgettoMinisteroEmail,
                    ResponsabiliProgettoEnte = s.ResponsabiliProgettoEnte,
                    ResponsabiliProgettoEnteEmail = s.ResponsabiliProgettoEnteEmail
                })
                .Distinct()
                .ToListAsync();

            ViewData["Monitoraggio"] = "20250630";
            ViewData["Ruolo"] = ruolo;
            ViewData["Utente"] = user;
            ViewData["Casi"] = result.Count();
            //return View(await schedeEstratte.ToListAsync());
            return View(result);
        }

        //Gestione SCHEDE
        public async Task<IActionResult> ElencoSchede()
        {

            string ruolo = _roleService.GetRuolo();
            string user = User.Identity.Name;

            var schede = _context.Schedes
                .Include(s => s.CodEnteNavigation)
                .Include(s => s.DataMonitoraggioNavigation);

            if (ruolo == "responsabile scheda")
            {
                //schedeEstratte = schedeEstratte.Where(s => s.CodResponsabileNavigation.Email == user);
            }

            return View(await schede.ToListAsync());
        }

        public IActionResult NuovaScheda()
        {
            ViewData["CodEnte"] = new SelectList(_context.Entis, "CodEnte", "DescrizioneEnte");
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> NuovaScheda(Schede schede)
        {

            if (ModelState.IsValid)
            {
                //data monitoraggio attiva
                schede.DataMonitoraggio = DateOnly.ParseExact("20250630", "yyyyMMdd");

                _context.Add(schede);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(ElencoSchedeProgetto));
            }
            ViewData["CodEnte"] = new SelectList(_context.Entis, "CodEnte", "CodEnte", schede.CodEnte);
            return View(schede);
        }

        public async Task<IActionResult> Scheda(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var schede = await _context.Schedes.FindAsync(id);
            if (schede == null)
            {
                return NotFound();
            }

            ViewData["CodEnte"] = new SelectList(_context.Entis, "CodEnte", "DescrizioneEnte", schede.CodEnte);
            return View(schede);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Scheda(int id, Schede schede)
        {
            if (id != schede.IdScheda)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(schede);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!SchedeExists(schede.IdScheda))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(ElencoSchede));
            }
            ViewData["CodEnte"] = new SelectList(_context.Entis, "CodEnte", "CodEnte", schede.CodEnte);
            return View(schede);
        }

        public async Task<IActionResult> EliminaScheda(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var schede = await _context.Schedes
                .Include(s => s.CodEnteNavigation)
                .FirstOrDefaultAsync(m => m.IdScheda == id);
            if (schede == null)
            {
                return NotFound();
            }

            return View(schede);
        }

        [HttpPost, ActionName("EliminaScheda")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var schede = await _context.Schedes.FindAsync(id);
            if (schede != null)
            {
                _context.Schedes.Remove(schede);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(ElencoSchede));
        }

        private bool SchedeExists(int id)
        {
            return _context.Schedes.Any(e => e.IdScheda == id);
        }

        //EXPORT
        public IActionResult ExportScheda(string monitoraggio, string ruolo, string utente)
        {

            IQueryable<v_ElencoSchede> query = _context.v_ElencoSchedes
                .AsNoTracking();

            //1 segretariato: nessun filtro 
            //2 responsabile scheda
            if (ruolo == "responsabile scheda")
            {
                query = query.Where(s => s.ResponsabileSchedaEmail.Contains(utente));
            }

            var e = query.ToList();
            string format = "yyyyMMdd-HHmmss";
            string _filename = String.Format("{0}_schede.xlsx", DateTime.Now.ToString(format));
            using (XLWorkbook wb = new XLWorkbook())
            {
                wb.Worksheets.Add(Common.ToDataTable(e.ToList()));
                using (MemoryStream stream = new MemoryStream())
                {
                    wb.SaveAs(stream);

                    return File(stream.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", _filename);
                }
            }
        }


        public IActionResult ExportCompleto(string monitoraggio, string ruolo, string utente)
        {
            IQueryable<v_SchedeProgettiOutput> query = _context.v_SchedeProgettiOutputs
                .AsNoTracking();

            // Filtri in base al ruolo
            if (ruolo == "responsabile scheda")
            {
                query = query.Where(s =>
                    s.ResponsabileSchedaEmail.Contains(utente) ||
                    s.ResponsabiliProgettoEnteEmail.Contains(utente));
            }
            else if (ruolo == "referente ministero")
            {
                query = query.Where(s =>
                    s.ResponsabiliProgettoMinisteroEmail.Contains(utente));
            }

            // Recupera gli ID degli output
            var outputIds = query.Select(s => s.idOutput).Distinct().ToList();

            // Recupera gli output per poter usare il servizio allegati
            var outputs = _context.Outputs
                    .Include(o => o.CodTipoOutputNavigation)
                    .Include(o => o.IdProgettoNavigation)
                    .ThenInclude(p => p.IdSchedaNavigation)
                    .Where(o => outputIds.Contains(o.IdOutput)).ToList();

            // Ottiene gli allegati per ciascun output
            var allegatiDict = outputs.ToDictionary(
                o => o.IdOutput,
                o => _allegatiService.GetFileList(o)
            );

            var righe = query.ToList();

            var e = righe
                .Select(s => new v_SchedeProgettiOutputExport
                {
                    CodScheda = s.CodScheda,
                    Ente = s.Ente,
                    Scheda = s.Scheda,
                    ResponsabileScheda = s.ResponsabileScheda,
                    ResponsabileSchedaEmail = s.ResponsabileSchedaEmail,
                    CodProgetto = s.CodProgetto,
                    Progetto = s.Progetto,
                    ResponsabiliProgettoMinistero = s.ResponsabiliProgettoMinistero,
                    ResponsabiliProgettoMinisteroEmail = s.ResponsabiliProgettoMinisteroEmail,
                    ResponsabiliProgettoEnte = s.ResponsabiliProgettoEnte,
                    ResponsabiliProgettoEnteEmail = s.ResponsabiliProgettoEnteEmail,
                    CodPriorita = s.CodPriorita,
                    ObiettivoRete = s.ObiettivoRete,
                    RisultatiAttesi = s.RisultatiAttesi,
                    CodTema = s.CodTema,
                    Tema = s.Tema,
                    CodTipoOutput = s.CodTipoOutput,
                    OutputDescrizione = s.OutputDescrizione,
                    CodOutputCompleto = s.CodOutputCompleto,
                    OutputProgrammato = s.OutputProgrammato,
                    OutputNonProgrammato = s.OutputNonProgrammato,
                    NumOutputProgrammato = s.NumOutputProgrammato,
                    NumOutputRealizzato = s.NumOutputRealizzato,
                    NumOutputNonProgrammato = s.NumOutputNonProgrammato,
                    OutputRealizzato = s.OutputRealizzato,
                    //OutputAllegato = s.OutputAllegato,
                    OutputAllegato = s.idOutput.HasValue &&
                        allegatiDict.TryGetValue(s.idOutput.Value, out var files) && files != null
                        ? string.Join(", ", files)
    :                     string.Empty,
                    OutputLink = s.OutputLink,
                    CheckInserimentoResponsabileProgettoEnte = s.CheckInserimentoResponsabileProgettoEnte,
                    CheckInserimentoResponsabileProgettoMinistero = s.CheckInserimentoResponsabileProgettoMinistero,
                    NoteProgettoResponsabileProgettoEnte = s.NoteProgettoResponsabileProgettoEnte,
                    DataInserimentoResponsabileProgettoEnte = s.DataInserimentoResponsabileProgettoEnte,
                    NoteProgettoResponsabileProgettoMinistero = s.NoteProgettoResponsabileProgettoMinistero,
                    NoteOutputResponsabileEnte = s.NoteOutputResponsabileEnte,
                    ParereResponsabileMinistero = s.ParereResponsabileMinistero switch
                    {
                        1 => "Conforme",
                        2 => "Parzialmente conforme (incompleto)",
                        3 => "Non conforme",
                        _ => "Nessun parere"
                    },
                    ParereResponsabileMinisteroData = s.ParereResponsabileMinisteroData,
                    MotivazioneResponsabileMinistero = s.MotivazioneResponsabileMinistero,
                    Comunicazione = s.Comunicazione,
                    ComunicazioneData = s.ComunicazioneData,
                    UltimoAggiornamento = s.UltimoAggiornamento,
                    DataMonitoraggio = s.DataMonitoraggio
                })
                .ToList();

            string _filename = $"Export_{DateTime.Now:yyyyMMdd-HHmmss}.xlsx";

            using (XLWorkbook wb = new XLWorkbook())
            {
                var dt = ToDataTableWithDisplayName(e);
                var ws = wb.Worksheets.Add(dt);

                var customWidths = new Dictionary<string, double>(StringComparer.OrdinalIgnoreCase)
                {
                    { "Codice scheda", 7 },
                    { "Ente", 7 },
                    { "Titolo scheda", 30 },
                    { "Responsabile Scheda Ente", 20 },
                    { "Responsabile Scheda Ente email", 20 },
                    { "Codice Progetto", 7 }, //allargare ok
                    { "Titolo Progetto", 30 },
                    { "Responsabile Progetto Ministero", 20 },
                    { "Responsabile Progetto Ente", 20 },
                    { "Responsabile Progetto Ente email", 20 },
                    { "Responsabile Progetto Ministero email", 20 },
                    { "Priorità", 7 },
                    { "Obiettivo Rete", 7 },
                    { "Risultati attesi", 50 },
                    { "Tema ", 7 },
                    { "Descrizione Tema", 30 },
                    { "Tipo output", 7 }, // controllare e uniformare a codice progetto. 
                    { "Descrizione output", 20 },
                    { "Output comunicazione", 10 }, //controllare scheda 6 dovrebbe risultare false
                    { "Codice output", 15 },
                    { "Output programmato", 30 },
                    { "Output realizzato", 30 },
                    { "n. output programmato", 10 },
                    { "n. output realizzato", 10 },
                    { "Output allegati", 30 },
                    { "Output link", 30 },
                    { "n. output non programmato realizzato", 10 },
                    { "Informaz. inserite dal Respons. Progetto Ente", 15 },
                    { "Data ultimo aggiorn. output", 15 }, //uniformare tutte le date
                    { "Note sull'output del Resp. Ente", 20 },
                    { "Note sul Progetto del Resp. Ente", 20 },
                    { "Parere inserito sul Progetto del Resp. Ministero", 15 },
                    { "Data parere sull'output del Resp. Ministero", 15 },
                    { "Parere sull'output del Resp. Ministero", 15 },
                    { "Motivazione non conformità/parziale conformità output del Resp. Ministero", 30 }, //invertire con il precedente ok
                    { "Note sul Progetto del Resp. Ministero", 30 }, //invertire con il successivo ok
                    { "Data monitoraggio", 10 },
                };

                // Imposta wrap solo sulla prima riga(intestazioni)
                ws.Row(1).Style.Alignment.WrapText = true;
                ws.Row(1).Style.Font.Bold = true;
                ws.Row(1).Height = 45; // Imposta altezza sufficiente per 3 righe da 15

                // Imposta wrap a false su tutte le altre righe
                for (int r = 2; r <= ws.LastRowUsed().RowNumber(); r++)
                {
                    ws.Row(r).Style.Alignment.WrapText = false;
                }

                // Ottieni mapping proprietà -> display name
                var displayNames = typeof(v_SchedeProgettiOutputExport)
                    .GetProperties()
                    .ToDictionary(
                        prop => prop.Name,
                        prop =>
                        {
                            var attr = prop.GetCustomAttribute<DisplayAttribute>();
                            return attr?.Name ?? prop.Name;
                        });

                for (int i = 1; i <= dt.Columns.Count; i++)
                {
                    var columnName = dt.Columns[i - 1].ColumnName;

                    var displayName = displayNames.TryGetValue(columnName, out var name)
                        ? name
                        : columnName;

                    if (customWidths.TryGetValue(displayName, out double customWidth))
                    {
                        ws.Column(i).Width = customWidth;
                    }
                    else
                    {
                        ws.Column(i).Width = displayName.Length + 2; // fallback
                    }
                }
                //ws.CellsUsed().Style.Alignment.WrapText = false;

                using (MemoryStream stream = new MemoryStream())
                {
                    wb.SaveAs(stream);

                    return File(stream.ToArray(),
                        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                        _filename);
                }
            }
        }

        public static class ExportColumnSettings
        {
            public static readonly Dictionary<string, double> Larghezze = new()
            {
                { "Codice scheda", 5 },
                { "Ente", 6 }
                // ...
            };
        }

        public static class Common
        {
            public static DataTable ToDataTable<T>(List<T> items)
            {
                DataTable dataTable = new DataTable(typeof(T).Name);
                //Get all the properties
                PropertyInfo[] Props = typeof(T).GetProperties(BindingFlags.Public | BindingFlags.Instance);
                foreach (PropertyInfo prop in Props)
                {
                    //Setting column names as Property names
                    dataTable.Columns.Add(prop.Name);
                }
                foreach (T item in items)
                {
                    var values = new object[Props.Length];
                    for (int i = 0; i < Props.Length; i++)
                    {
                        //inserting property values to datatable rows
                        values[i] = Props[i].GetValue(item, null);
                    }
                    dataTable.Rows.Add(values);
                }
                //put a breakpoint here and check datatable
                return dataTable;
            }
        }

        public static DataTable ToDataTableWithDisplayName<T>(List<T> items)
        {
            var dataTable = new DataTable(typeof(T).Name);

            var props = typeof(T).GetProperties()
                                 .Where(p => p.GetCustomAttributes(typeof(DisplayAttribute), false).Any())
                                 .ToList();

            foreach (var prop in props)
            {
                var displayAttr = prop.GetCustomAttributes(typeof(DisplayAttribute), false)
                                      .FirstOrDefault() as DisplayAttribute;
                string columnName = displayAttr?.Name ?? prop.Name;

                dataTable.Columns.Add(columnName, Nullable.GetUnderlyingType(prop.PropertyType) ?? prop.PropertyType);
            }

            foreach (var item in items)
            {
                var values = new object[props.Count];
                for (int i = 0; i < props.Count; i++)
                {
                    values[i] = props[i].GetValue(item, null);
                }
                dataTable.Rows.Add(values);
            }

            return dataTable;
        }
    }
}
