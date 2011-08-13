using System;
using System.Collections.Generic;
using System.Linq;
using RiftData.ApplicationServices.DtoServices.Contracts;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.ApplicationServices.DtoServices
{
    public class LocaleDtoService : ILocaleDtoService
    {
        private readonly IFishRepository _fishRepository;
        private readonly IDtoFactory _dtoFactory;
        private readonly ILocalesRepository _localesRepository;

        public LocaleDtoService(IFishRepository fishRepository, IDtoFactory dtoFactory, ILocalesRepository localesRepository)
        {
            _fishRepository = fishRepository;
            _dtoFactory = dtoFactory;
            _localesRepository = localesRepository;
        }

        public IList<LocaleDto> GetLocaleDtosFromSpecies(int speciesId)
        {
            var list = new List<LocaleDto>();

            _fishRepository.GetFishBySpecies(speciesId).ToList().ForEach(f => list.Add(this._dtoFactory.Build(f.Locale)));

            return list;
        }

        public LocaleDto GetLocaleDto(int localeId)
        {
            return this._dtoFactory.Build(this._localesRepository.GetById(localeId));
        }
    }
}
