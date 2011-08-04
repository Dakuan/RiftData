using FlickrNet;
using Photo = RiftData.Domain.Entities.Photo;

namespace RiftData.Domain.Factories
{
    public interface IPhotoFactory
    {
        Photo Build(PhotoInfo dataPhoto, int photoId, string caption);
    }
}