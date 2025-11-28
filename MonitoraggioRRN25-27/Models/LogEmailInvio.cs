namespace MonitoraggioPAC25_27.Models
{
    public class LogEmailInvio
    {
        public int Id { get; set; }

        public string UserId { get; set; } = null!;

        public string Email { get; set; } = null!;

        public string? Oggetto { get; set; }

        public DateTime DataInvio { get; set; }

        public string? Esito { get; set; }

        public string? Messaggio { get; set; }
    }
}
