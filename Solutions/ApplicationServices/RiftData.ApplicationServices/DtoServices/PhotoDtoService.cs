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

        public IList<PhotoDto> GetPhotosForSpecies(int speciesId)
        {
            return this.BuildList(this.photosRepository.GetPhotosForSpecies(speciesId));
        }

        public IList<PhotoDto> GetPhotosForLocale(int localeId)
        {
            var fish = this.fishRepository.GetFishByLocale(localeId);

            var list = new List<Photo>();

            fish.ToList().ForEach(f => 
            { 
                if (f.HasPhotos)
                {
                    f.Photos.ToList().ForEach(list.Add);
                }
            });

            return this.BuildList(list);
        }

        public IList<PhotoDto> GetPhotosForFish(Fish fish)
        {
            return this.BuildList(fish.Photos);
        }

        private IList<PhotoDto> BuildList(IEnumerable<Photo> photos)
        {
            var list = new List<PhotoDto>();

            photos.ToList().ForEach(p => list.Add(this.dtoFactory.Build(p)));
            
            return list;
        }
    }
}