using System;
using System.Collections.Generic;
using System.Linq;
using RiftData.ApplicationServices.DtoServices.Contracts;
using RiftData.Domain.Entities;
using RiftData.Domain.Extensions;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.ApplicationServices.DtoServices
{
    public class GenusTypeDtoService : IGenusTypeDtoService
    {
        private readonly IDtoFactory _dtoFactory;
        private readonly IGenusTypeRepository _genusTypeRepository;

        public GenusTypeDtoService(IDtoFactory dtoFactory, IGenusTypeRepository genusTypeRepository)
        {
            _dtoFactory = dtoFactory;
            _genusTypeRepository = genusTypeRepository;
        }

        public IList<GenusTypeDto> GetGenusTypesThatContainGenus()
        {
            return this.BuildList(this._genusTypeRepository.GetGenusTypesContainingGenus());
        }

        public GenusTypeDto GetGenusTypeByName(string genusTypeName)
        {
            return this._dtoFactory.Build(this._genusTypeRepository.GetGenusTypeByName(genusTypeName));
        }

        public IList<GenusTypeDto> GetAllGenusTypes()
        {
            return this.BuildList(this._genusTypeRepository.GetAll());
        }

        public GenusTypeDto GetGenusTypeDto(int genusTypeId)
        {
            return this._dtoFactory.Build(this._genusTypeRepository.GetGenusType(genusTypeId));
        }

        public IList<GenusTypeDto> GetGenusTypesFromLocale(Locale locale)
        {
            var list = new List<GenusTypeDto>();

            return this.BuildList(locale.Lake.GenusTypes);
        }

        public IList<GenusTypeDto> GetGenusTypesFromLake(Lake lake)
        {
            return this.BuildList(lake.GenusTypes.SortGenusTypes());
        }

        private IList<GenusTypeDto> BuildList(IEnumerable<GenusType> list)
        {
            var newList = new List<GenusTypeDto>();

            list.ToList().ForEach(g => newList.Add(this._dtoFactory.Build(g)));

            return newList;
        }
    }
}