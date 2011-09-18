using System.Collections.Generic;
using System.Linq;
using RiftData.ApplicationServices.DtoServices.Contracts;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.ApplicationServices.DtoServices
{
    public class FishDtoService : IFishDtoService
    {
        private readonly IFishRepository _fishRepository;
        private readonly IDtoFactory _dtoFactory;

        public FishDtoService(IFishRepository fishRepository, IDtoFactory dtoFactory)
        {
            _fishRepository = fishRepository;
            _dtoFactory = dtoFactory;
        }

        public IEnumerable<FishDto> GetFishAtLocale(int localeId)
        {
            var fish = new List<FishDto>();

            this._fishRepository.GetByLocale(localeId).ToList().ForEach(f => fish.Add(this._dtoFactory.Build(f)));

            return fish;
        }
    }
}