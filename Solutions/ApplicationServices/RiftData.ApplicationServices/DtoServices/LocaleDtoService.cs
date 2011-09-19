using System;
using System.Collections.Generic;
using System.Linq;
using RiftData.ApplicationServices.DtoServices.Contracts;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.ApplicationServices.DtoServices
{
    using RiftData.ApplicationServices.ViewModelFactories;

    public class LocaleDtoService : ILocaleDtoService
    {
        private readonly IFishRepository _fishRepository;
        private readonly ILocalesRepository _localesRepository;
        private readonly IMapService _mapService;

        public LocaleDtoService(IFishRepository fishRepository, ILocalesRepository localesRepository, IMapService mapService)
        {
            _fishRepository = fishRepository;
            _localesRepository = localesRepository;
            _mapService = mapService;
        }

        public IEnumerable<LocaleDto> GetLocaleDtosFromSpecies(int speciesId)
        {
            var list = new List<LocaleDto>();

            _fishRepository.GetBySpecies(speciesId).ToList().ForEach(f => list.Add(DtoFactory.Build(f.Locale)));

            return list;
        }

        public LocaleDto GetLocaleDto(int localeId)
        {
            return DtoFactory.Build(this._localesRepository.Get(localeId));
        }

        public IEnumerable<LocaleDto> GetLocalesForZoomLevel(int zoomLevel)
        {
            var list = new List<LocaleDto>();

            this._localesRepository.GetForZoomLevel(this._mapService.GetDataZoomFromMapZoom(zoomLevel)).ToList().ForEach(l => list.Add(DtoFactory.Build(l)));

            return list;
        }
    }
}
