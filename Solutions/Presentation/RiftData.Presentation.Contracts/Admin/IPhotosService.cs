using System.Web;
using RiftData.Domain.Entities;

namespace RiftData.Presentation.Contracts.Admin
{
    public interface IPhotosService
    {
        Fish GetFish(int id);

        Photo SavePhoto(HttpPostedFileBase attachments, int fishId);

        void DeletePhoto(string id);
    }
}