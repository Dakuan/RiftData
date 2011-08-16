using RiftData.Domain.Entities;
using RiftData.Presentation.ViewModels;

namespace RiftData.Presentation.Contracts
{
    public interface IPhotoGalleryViewModelFactory
    {
        PhotoGalleryViewModel Build(Species species);

        PhotoGalleryViewModel Build(Locale locale);

        PhotoGalleryViewModel Build(Fish fish);
    }
}