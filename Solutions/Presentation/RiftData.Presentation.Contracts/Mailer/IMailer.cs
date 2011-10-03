namespace RiftData.Presentation.Contracts.Mailer
{
    public interface IMailer
    {
        void SendToAdmin(string message);

        void SendToAdmin(string message, string name, string email);
    }
}