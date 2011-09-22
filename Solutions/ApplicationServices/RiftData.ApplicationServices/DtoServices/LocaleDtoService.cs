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
        private readonly IFishRepository fishRepository;

        private readonly ILocalesRepository localesRepository;

        private readonly IMapService mapService;

        public LocaleDtoService(IFishRepository fishRepository, ILocalesRepository localesRepository, IMapService mapService)
        {
            this.fishRepository = fishRepository;
            this.localesRepository = localesRepository;
            this.mapService = mapService;
        }

        public LocaleDto GetLocaleDto(int localeId)
        {
            return DtoFactory.Build(this.localesRepository.Get(localeId));
        }

        public IEnumerable<LocaleDto> GetLocaleDtosFromSpecies(int speciesId)
        {
            var list = new List<LocaleDto>();

            this.fishRepository.GetBySpecies(speciesId).ToList().ForEach(f => list.Add(DtoFactory.Build(f.Locale)));

            return list;
        }

        public IEnumerable<LocaleDto> GetLocalesForZoomLevel(int zoomLevel)
        {
            var list = new List<LocaleDto>();

            this.localesRepository.GetForZoomLevel(this.mapService.GetDataZoomFromMapZoom(zoomLevel)).ToList().ForEach(l => list.Add(DtoFactory.Build(l)));

            return list;
        }
    }
}