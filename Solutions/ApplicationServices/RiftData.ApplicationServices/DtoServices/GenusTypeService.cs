using System.Collections.Generic;
using System.Linq;
using RiftData.ApplicationServices.DtoServices.Contracts;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.ApplicationServices.DtoServices
{
    public class GenusTypeService : IGenusTypeService
    {
        private readonly IDtoFactory _dtoFactory;
        private readonly IGenusTypeRepository _genusTypeRepository;

        public GenusTypeService(IDtoFactory dtoFactory, IGenusTypeRepository genusTypeRepository)
        {
            _dtoFactory = dtoFactory;
            _genusTypeRepository = genusTypeRepository;
        }

        public IList<GenusTypeDto> GetGenusTypesThatContainGenus()
        {
            var list = new List<GenusTypeDto>();

            this._genusTypeRepository.GetGenusTypesContainingGenus().ToList().ForEach(t => list.Add(this._dtoFactory.Build(t)));

            return list;
        }

        public GenusTypeDto GetGenusTypeByName(string genusTypeName)
        {
            return this._dtoFactory.Build(this._genusTypeRepository.GetGenusTypeByName(genusTypeName));
        }
    }
}