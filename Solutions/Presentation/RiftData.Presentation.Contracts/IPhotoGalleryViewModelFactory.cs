namespace RiftData.Presentation.Contracts
{
    using RiftData.Domain.Entities;
    using RiftData.Presentation.ViewModels;

    public interface IPhotoGalleryViewModelFactory
    {
        PhotoGalleryViewModel Build(Species species);

        PhotoGalleryViewModel Build(Locale locale);

        PhotoGalleryViewModel Build(Fish fish);
    }
}