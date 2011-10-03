namespace RiftData.Presentation.Contracts.Mailer
{
    public interface IMailer
    {
        void SendToAdmin(string message);
    }
}