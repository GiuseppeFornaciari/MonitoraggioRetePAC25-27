namespace MonitoraggioPAC25_27.Models
{
    public class AdminEmailSendOneViewModel
    {
        // Form
        public string Destinatario { get; set; }
        public string Oggetto { get; set; }
        public string MessaggioHtml { get; set; }

        // Log
        public List<LogEmailInvio> Log { get; set; } = new();
    }
}
