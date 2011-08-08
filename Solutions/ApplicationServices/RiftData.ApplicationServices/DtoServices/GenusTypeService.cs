using System.Collections.Generic;
using System.Linq;
using RiftData.ApplicationServices.DtoServices.Contracts;
using RiftData.ApplicationServices.ViewModelFactories.Contracts;
using RiftData.Domain.Repositories;
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
    }
}