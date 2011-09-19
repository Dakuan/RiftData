namespace RiftData.ApplicationServices.DtoServices
{
    using System.Collections.Generic;
    using System.Linq;

    using RiftData.ApplicationServices.DtoServices.Contracts;
    using RiftData.ApplicationServices.ViewModelFactories;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.ViewModels.Dto;

    public class LocaleDtoService : ILocaleDtoService
    {
        private readonly IFishRepository _fishRepository;

        private readonly ILocalesRepository _localesRepository;

        private readonly IMapService _mapService;

        public LocaleDtoService(
            IFishRepository fishRepository, ILocalesRepository localesRepository, IMapService mapService)
        {
            this._fishRepository = fishRepository;
            this._localesRepository = localesRepository;
            this._mapService = mapService;
        }

        public LocaleDto GetLocaleDto(int localeId)
        {
            return DtoFactory.Build(this._localesRepository.Get(localeId));
        }

        public IEnumerable<LocaleDto> GetLocaleDtosFromSpecies(int speciesId)
        {
            var list = new List<LocaleDto>();

            this._fishRepository.GetBySpecies(speciesId).ToList().ForEach(f => list.Add(DtoFactory.Build(f.Locale)));

            return list;
        }

        public IEnumerable<LocaleDto> GetLocalesForZoomLevel(int zoomLevel)
        {
            var list = new List<LocaleDto>();

            this._localesRepository.GetForZoomLevel(this._mapService.GetDataZoomFromMapZoom(zoomLevel)).ToList().ForEach
                (l => list.Add(DtoFactory.Build(l)));

            return list;
        }
    }
}