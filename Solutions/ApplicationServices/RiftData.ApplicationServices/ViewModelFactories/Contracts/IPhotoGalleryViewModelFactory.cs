using RiftData.Domain.Entities;
using RiftData.Presentation.ViewModels;

namespace RiftData.ApplicationServices.ViewModelFactories.Contracts
{
    public interface IPhotoGalleryViewModelFactory
    {
        PhotoGalleryViewModel Build(Species species);
    }
}