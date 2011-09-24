using RiftData.ApplicationServices.Extensions;
using RiftData.Domain.Repositories;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    using RiftData.Domain.Entities;
    using RiftData.Presentation.Contracts;
    using RiftData.Presentation.ViewModels;

    public class PhotoGalleryViewModelFactory : IPhotoGalleryViewModelFactory
    {
        private readonly IPhotosRepository photosRepository;

        public PhotoGalleryViewModelFactory(IPhotosRepository photosRepository)
        {
            this.photosRepository = photosRepository;
        }

        public PhotoGalleryViewModel Build(Species species)
        {
            var viewModel = new PhotoGalleryViewModel { Name = species.Name, Photos = this.photosRepository.GetForSpecies(species.Id).ToDtoList() };

            return viewModel;
        }

        public PhotoGalleryViewModel Build(Locale locale)
        {
            var viewModel = new PhotoGalleryViewModel { Name = locale.Name, Photos = this.photosRepository.GetForLocale(locale.Id).ToDtoList() };

            return viewModel;
        }

        public PhotoGalleryViewModel Build(Fish fish)
        {
            var viewModel = new PhotoGalleryViewModel { Name = fish.Name, Photos = fish.Photos.ToDtoList() };

            return viewModel;
        }
    }
}