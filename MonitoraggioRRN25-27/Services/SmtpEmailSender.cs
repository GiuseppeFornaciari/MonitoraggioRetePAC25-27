using Microsoft.AspNetCore.Identity.UI.Services;
using Microsoft.Extensions.Options;
using MonitoraggioPAC25_27.Models;
using System.Net;
using System.Net.Mail;

public class SmtpEmailSender : IEmailSender
{
    private readonly SmtpSettings _settings;

    public SmtpEmailSender(IOptions<SmtpSettings> settings)
    {
        _settings = settings.Value;
    }

    public async Task SendEmailAsync(string email, string subject, string htmlMessage)
    {
        using var client = new SmtpClient(_settings.Host, _settings.Port)
        {
            EnableSsl = false,                     // NO SSL su porta 25 (relay anonimo M365)
            UseDefaultCredentials = true,          // NESSUNA autenticazione
            DeliveryMethod = SmtpDeliveryMethod.Network
        };

        var mail = new MailMessage
        {
            From = new MailAddress(_settings.SenderEmail, _settings.SenderName),
            Subject = subject,
            Body = htmlMessage,
            IsBodyHtml = true
        };

        mail.To.Add(email);

        await client.SendMailAsync(mail);
    }
}