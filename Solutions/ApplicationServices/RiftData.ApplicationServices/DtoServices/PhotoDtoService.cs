namespace RiftData.ApplicationServices.DtoServices
{
    using System.Collections.Generic;

    using RiftData.ApplicationServices.DtoServices.Contracts;
    using RiftData.ApplicationServices.DtoServices.Extensions;
    using RiftData.Domain.Entities;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.ViewModels.Dto;

    public class PhotoDtoService : IPhotoDtoService
    {
        private readonly IPhotosRepository photosRepository;

        public PhotoDtoService(IPhotosRepository photosRepository)
        {
            this.photosRepository = photosRepository;
        }

        public IEnumerable<PhotoDto> GetPhotosForFish(Fish fish)
        {
            return fish.Photos.ToDtoList();
        }

        public IEnumerable<PhotoDto> GetPhotosForLocale(int localeId)
        {
            return this.photosRepository.GetForLocale(localeId).ToDtoList();
        }

        public IEnumerable<PhotoDto> GetPhotosForSpecies(int speciesId)
        {
            return this.photosRepository.GetForSpecies(speciesId).ToDtoList();
        }
    }
}