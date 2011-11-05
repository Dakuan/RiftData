using System;

namespace RiftData.Presentation.Contracts.Mailer
{
    public interface IMailer
    {
        void SendHelpOffer(string message);

        void SendHelpOffer(string message, string name, string email);

        void LogError(Exception exception);
    }
}