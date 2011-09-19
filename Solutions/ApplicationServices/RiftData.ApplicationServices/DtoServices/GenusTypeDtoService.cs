namespace RiftData.ApplicationServices.DtoServices
{
    using System.Collections.Generic;
    using System.Linq;

    using RiftData.ApplicationServices.DtoServices.Contracts;
    using RiftData.ApplicationServices.ViewModelFactories;
    using RiftData.Domain.Entities;
    using RiftData.Domain.Extensions;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.ViewModels.Dto;

    public class GenusTypeDtoService : IGenusTypeDtoService
    {
        private readonly IGenusTypeRepository _genusTypeRepository;

        public GenusTypeDtoService(IGenusTypeRepository genusTypeRepository)
        {
            this._genusTypeRepository = genusTypeRepository;
        }

        public IEnumerable<GenusTypeDto> GetAllGenusTypes()
        {
            return this.BuildList(this._genusTypeRepository.GetAll());
        }

        public GenusTypeDto GetGenusTypeByName(string genusTypeName)
        {
            return DtoFactory.Build(this._genusTypeRepository.GetByName(genusTypeName));
        }

        public GenusTypeDto GetGenusTypeDto(int genusTypeId)
        {
            return DtoFactory.Build(this._genusTypeRepository.Get(genusTypeId));
        }

        public IEnumerable<GenusTypeDto> GetGenusTypesFromLake(Lake lake)
        {
            return this.BuildList(lake.GenusTypes.SortGenusTypes());
        }

        public IEnumerable<GenusTypeDto> GetGenusTypesFromLocale(Locale locale)
        {
            var list = new List<GenusTypeDto>();

            return this.BuildList(locale.Lake.GenusTypes);
        }

        private IEnumerable<GenusTypeDto> BuildList(IEnumerable<GenusType> list)
        {
            var newList = new List<GenusTypeDto>();

            list.ToList().ForEach(g => newList.Add(DtoFactory.Build(g)));

            return newList;
        }
    }
}