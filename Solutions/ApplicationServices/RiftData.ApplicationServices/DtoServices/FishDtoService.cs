using System.Collections.Generic;
using System.Linq;
using RiftData.ApplicationServices.DtoServices.Contracts;
using RiftData.ApplicationServices.DtoServices.Extensions;
using RiftData.Domain.Repositories;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.ApplicationServices.DtoServices
{
    public class FishDtoService : IFishDtoService
    {
        private readonly IFishRepository _fishRepository;

        public FishDtoService(IFishRepository fishRepository)
        {
            _fishRepository = fishRepository;
        }

        public IEnumerable<FishDto> GetFishAtLocale(int localeId)
        {
            return this._fishRepository.GetByLocale(localeId).ToList().ToDtoList();
        }
    }
}