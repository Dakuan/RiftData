using System;
using RiftData.Domain.Enums;

namespace RiftData.Presentation.Contracts.Mailer
{
    public interface IMailer
    {
        void SendHelpOffer(string message);

        void SendHelpOffer(string message, string name, string email);

        void LogNotFound(string itemName, ItemType itemType);

        void LogError(Exception exception);
    }
}