using System;
using System.Collections.Generic;
using System.Linq;
using RiftData.ApplicationServices.ViewModelFactories.Contracts;
using RiftData.Domain.Entities;
using RiftData.Domain.Repositories;
using RiftData.Presentation.ViewModels;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    public class PhotoGalleryViewModelFactory : IPhotoGalleryViewModelFactory
    {
        private readonly IPhotosRepository _photosRepository;
        private readonly IDtoFactory _dtoFactory;

        public PhotoGalleryViewModelFactory(IPhotosRepository photosRepository, IDtoFactory dtoFactory)
        {
            _photosRepository = photosRepository;
            _dtoFactory = dtoFactory;
        }

        public PhotoGalleryViewModel Build(Species species)
        {
            var photos = new List<PhotoDto>();

            this._photosRepository.GetPhotosForSpecies(species.Id).ToList().ForEach(p => photos.Add(this._dtoFactory.Build(p)));

            var viewModel = new PhotoGalleryViewModel
                                {
                                    Name = species.Name,
                                    Photos = photos
                                };

            return viewModel;
        }
    }
}
