namespace RiftData.Domain.Factories
{
    using FlickrNet;

    using Photo = RiftData.Domain.Entities.Photo;

    public interface IPhotoFactory
    {
        Photo CreatePhoto(int id);

        Photo CreatePhoto(PhotoInfo photoInfo);
    }
}