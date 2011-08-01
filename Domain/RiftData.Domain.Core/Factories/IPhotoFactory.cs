using RiftData.Domain.Entities;

namespace RiftData.Domain.Factories
{
    public interface IPhotoFactory
    {
        Photo Build(RiftData.Infrastructure.Data.Photos dataPhoto);
    }
}