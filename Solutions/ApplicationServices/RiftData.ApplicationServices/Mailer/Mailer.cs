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

        public void SendToAdmin(string message)
        {
            MailgunMessage.SendText("admin@riftdata.apphb.com", "dom.barker808@gmail.com", "Someone wants to help!", message);
        }

        public void SendToAdmin(string message, string name, string email)
        {
            MailgunMessage.SendText(email, "dom.barker808@gmail.com", string.Format("{0} wants to help!", name), message);
        }
    }
}