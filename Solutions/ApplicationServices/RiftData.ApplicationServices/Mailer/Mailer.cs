using System;

namespace RiftData.ApplicationServices.Mailer
{
    using RiftData.Infrastructure.Mailgun;
    using RiftData.Presentation.Contracts.Mailer;

    public class Mailer : IMailer
    {
        public Mailer()
        {
            Mailgun.Init("key-2vj6vyus26pk2z5kpiffkl2v$bhcftx5");
        }

        public void SendHelpOffer(string message)
        {
            MailgunMessage.SendText("admin@riftdata.apphb.com", "dom.barker808@gmail.com", "Someone wants to help!", message);
        }

        public void SendHelpOffer(string message, string name, string email)
        {
            MailgunMessage.SendText(email, "dom.barker808@gmail.com", string.Format("{0} wants to help!", name), message);
        }

        public void LogError(Exception exception)
        {
            MailgunMessage.SendText("admin@riftdata.apphb.com", "dom.barker808@gmail.com", "RiftData Error Report", string.Format("Error: {0} \n Message:{1}", exception.GetType().FullName, exception.Message));
        }
    }
}