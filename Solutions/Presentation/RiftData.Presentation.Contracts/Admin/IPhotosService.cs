namespace RiftData.Presentation.Contracts.Admin
{
    using System.Web;

    using RiftData.Domain.Entities;

    public interface IPhotosService
    {
        void DeletePhoto(string id);

        Fish GetFish(int id);

        Photo SavePhoto(HttpPostedFileBase attachments, int fishId);
    }
}