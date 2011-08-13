using System;
using RiftData.ApplicationServices.DtoServices.Contracts;
using RiftData.Domain.Entities;
using RiftData.Presentation.Contracts;
using RiftData.Presentation.ViewModels;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    public class PhotoGalleryViewModelFactory : IPhotoGalleryViewModelFactory
    {
        private readonly IPhotoDtoService _photoDtoService;

        public PhotoGalleryViewModelFactory(IPhotoDtoService photoDtoService)
        {
            _photoDtoService = photoDtoService;
        }

        public PhotoGalleryViewModel Build(Species species)
        {
            var viewModel = new PhotoGalleryViewModel
                                {
                                    Name = species.Name,
                                    Photos = this._photoDtoService.GetPhotosForSpecies(species.Id)
                                };

            return viewModel;
        }

        public PhotoGalleryViewModel Build(Locale locale)
        {
            var viewModel = new PhotoGalleryViewModel
                                {
                                    Name = locale.Name,
                                    Photos = this._photoDtoService.GetPhotosForLocale(locale.Id)
                                };

            return viewModel;
        }
    }
}