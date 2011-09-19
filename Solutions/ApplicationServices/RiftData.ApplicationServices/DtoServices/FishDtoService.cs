namespace RiftData.ApplicationServices.DtoServices
{
    using System.Collections.Generic;
    using System.Linq;

    using RiftData.ApplicationServices.DtoServices.Contracts;
    using RiftData.ApplicationServices.DtoServices.Extensions;
    using RiftData.ApplicationServices.ViewModelFactories;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.ViewModels.Dto;

    public class FishDtoService : IFishDtoService
    {
        private readonly IFishRepository fishRepository;

        public FishDtoService(IFishRepository fishRepository)
        {
            this.fishRepository = fishRepository;
        }

        public IEnumerable<FishDto> GetFishAtLocale(int localeId)
        {
            return this.fishRepository.GetByLocale(localeId).ToList().ToDtoList();
        }

        public IList<FishDto> GetFishForSpecies(int speciesId)
        {
            var list = new List<FishDto>();

            this.fishRepository.GetBySpecies(speciesId).ToList().ForEach(f => list.Add(DtoFactory.Build(f)));

            return list;
        }
    }
}