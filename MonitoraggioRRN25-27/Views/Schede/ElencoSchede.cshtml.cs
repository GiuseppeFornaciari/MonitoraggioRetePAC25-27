using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using MonitoraggioPAC25_27.Data;
using MonitoraggioPAC25_27.Models;

namespace MonitoraggioPAC25_27
{
    public class IndexModel : PageModel
    {
        private readonly MonitoraggioPAC25_27.Data.MonitoraggioPAC2527Context _context;

        public IndexModel(MonitoraggioPAC25_27.Data.MonitoraggioPAC2527Context context)
        {
            _context = context;
        }

        public IList<Schede> Schede { get;set; } = default!;

        public async Task OnGetAsync()
        {
            Schede = await _context.Schedes
                .Include(s => s.CodEnteNavigation)
                .Include(s => s.DataMonitoraggioNavigation).ToListAsync();
        }
    }
}
