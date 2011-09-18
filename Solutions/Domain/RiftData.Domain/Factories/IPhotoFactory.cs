using FlickrNet;

namespace RiftData.Domain.Factories
{
    public interface IPhotoFactory
    {
        Domain.Entities.Photo CreatePhoto(int id);

        Domain.Entities.Photo CreatePhoto(PhotoInfo photoInfo);
    }
}