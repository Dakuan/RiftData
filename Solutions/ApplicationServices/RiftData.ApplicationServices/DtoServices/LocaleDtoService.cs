using System.Collections.Generic;
using System.Linq;
using RiftData.ApplicationServices.DtoServices.Contracts;
using RiftData.ApplicationServices.ViewModelFactories.Contracts;
using RiftData.Domain.Repositories;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.ApplicationServices.DtoServices
{
    public class LocaleDtoService : ILocaleDtoService
    {
        private readonly IFishRepository _fishRepository;
        private readonly IDtoFactory _dtoFactory;

        public LocaleDtoService(IFishRepository fishRepository, IDtoFactory dtoFactory)
        {
            _fishRepository = fishRepository;
            _dtoFactory = dtoFactory;
        }

        public IList<LocaleDto> GetLocaleDtosFromSpecies(int speciesId)
        {
            var list = new List<LocaleDto>();

            _fishRepository.GetFishBySpecies(speciesId).ToList().ForEach(f => list.Add(this._dtoFactory.Build(f.Locale)));

            return list;
        }
    }
}
