namespace RiftData.ApplicationServices.DtoServices
{
    using System.Collections.Generic;

    using Contracts;
    using Domain.Entities;
    using Domain.Repositories;

    using Presentation.ViewModels.Dto;

    using RiftData.ApplicationServices.DtoServices.Extensions;

    public class PhotoDtoService : IPhotoDtoService
    {
        private readonly IPhotosRepository photosRepository;

        public PhotoDtoService(IPhotosRepository photosRepository)
        {
            this.photosRepository = photosRepository;
        }

        public IEnumerable<PhotoDto> GetPhotosForSpecies(int speciesId)
        {
            return this.photosRepository.GetForSpecies(speciesId).ToDtoList();
        }

        public IEnumerable<PhotoDto> GetPhotosForLocale(int localeId)
        {
            return this.photosRepository.GetForLocale(localeId).ToDtoList();
        }

        public IEnumerable<PhotoDto> GetPhotosForFish(Fish fish)
        {
            return fish.Photos.ToDtoList();
        }
    }
}