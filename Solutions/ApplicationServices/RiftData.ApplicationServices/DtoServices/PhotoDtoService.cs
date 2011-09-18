namespace RiftData.ApplicationServices.DtoServices
{
    using System.Collections.Generic;
    using System.Linq;
    using Contracts;
    using Domain.Entities;
    using Domain.Repositories;
    using Presentation.Contracts;
    using Presentation.ViewModels.Dto;

    public class PhotoDtoService : IPhotoDtoService
    {
        private readonly IPhotosRepository photosRepository;
        private readonly IDtoFactory dtoFactory;
        private readonly IFishRepository fishRepository;

        public PhotoDtoService(IPhotosRepository photosRepository, IDtoFactory dtoFactory, IFishRepository fishRepository)
        {
            this.photosRepository = photosRepository;
            this.dtoFactory = dtoFactory;
            this.fishRepository = fishRepository;
        }

        public IEnumerable<PhotoDto> GetPhotosForSpecies(int speciesId)
        {
            return this.BuildList(this.photosRepository.GetForSpecies(speciesId));
        }

        public IEnumerable<PhotoDto> GetPhotosForLocale(int localeId)
        {
            return this.BuildList(this.photosRepository.GetForLocale(localeId));
        }

        public IEnumerable<PhotoDto> GetPhotosForFish(Fish fish)
        {
            return this.BuildList(fish.Photos);
        }

        private IEnumerable<PhotoDto> BuildList(IEnumerable<Photo> photos)
        {
            var list = new List<PhotoDto>();

            photos.ToList().ForEach(p => list.Add(this.dtoFactory.Build(p)));
            
            return list;
        }
    }
}