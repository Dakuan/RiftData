using System.Collections.Generic;
using System.Linq;
using RiftData.ApplicationServices.DtoServices.Contracts;
using RiftData.Domain.Entities;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.ApplicationServices.DtoServices
{
    public class PhotoDtoService : IPhotoDtoService
    {
        private readonly IPhotosRepository _photosRepository;
        private readonly IDtoFactory _dtoFactory;
        private readonly IFishRepository _fishRepository;

        public PhotoDtoService(IPhotosRepository photosRepository, IDtoFactory dtoFactory, IFishRepository fishRepository)
        {
            _photosRepository = photosRepository;
            _dtoFactory = dtoFactory;
            _fishRepository = fishRepository;
        }

        public IList<PhotoDto> GetPhotosForSpecies(int speciesId)
        {
            return this.BuildList(this._photosRepository.GetPhotosForSpecies(speciesId));
        }

        public IList<PhotoDto> GetPhotosForLocale(int localeId)
        {
            var fish = this._fishRepository.GetFishByLocale(localeId);

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

        private IList<PhotoDto> BuildList(IEnumerable<Photo> photos)
        {
            var list = new List<PhotoDto>();

            photos.ToList().ForEach(p => list.Add(this._dtoFactory.Build(p)));
            
            return list;
        }
    }
}