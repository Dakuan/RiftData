using System;
using RiftData.Domain.Enums;

namespace RiftData.ApplicationServices.Mailer
{
    using RiftData.Infrastructure.Mailgun;
    using RiftData.Presentation.Contracts.Mailer;

    public class Mailer : IMailer
    {
        private const string FromAddress = "admin@riftdata.apphb.com";
        
        public Mailer()
        {
            Mailgun.Init("key-2vj6vyus26pk2z5kpiffkl2v$bhcftx5");
        }

        public void SendHelpOffer(string message)
        {
            MailgunMessage.SendText(FromAddress, "dom.barker808@gmail.com", "Someone wants to help!", message);
        }

        public void SendHelpOffer(string message, string name, string email)
        {
            MailgunMessage.SendText(email, "dom.barker808@gmail.com", string.Format("{0} wants to help!", name), message);
        }

        public void LogNotFound(string itemName, ItemType itemType)
        {
            MailgunMessage.SendText(FromAddress, "dom.barker808@gmail.com", "RiftData Error Report", string.Format("{0} {1} not found", itemType, itemName));
        }

        public void LogError(Exception exception)
        {
            MailgunMessage.SendText(FromAddress, "dom.barker808@gmail.com", "RiftData Error Report", string.Format("Error: {0} \nMessage:{1}", exception.GetType().FullName, exception.Message));
        }
    }
}