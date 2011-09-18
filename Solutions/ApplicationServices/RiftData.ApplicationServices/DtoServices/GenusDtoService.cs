using System.Collections.Generic;
using System.Linq;
using RiftData.ApplicationServices.DtoServices.Contracts;
using RiftData.Domain.Entities;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.ApplicationServices.DtoServices
{
    public class GenusDtoService : IGenusDtoService
    {
        private readonly IGenusRepository _genusRepository;
        private readonly IDtoFactory _dtoFactory;

        public GenusDtoService(IGenusRepository genusRepository, IDtoFactory dtoFactory)
        {
            _genusRepository = genusRepository;
            _dtoFactory = dtoFactory;
        }

        public IEnumerable<GenusDto> GetGenusDtos(int genusTypeId)
        {
            return this.BuildList(this._genusRepository.GetOfIdWithFish(genusTypeId));
        }

        public IList<GenusDto> GetGenusDtos()
        {
            return this.BuildList(this._genusRepository.GetAll());
        }

        private IList<GenusDto> BuildList(IEnumerable<Genus> list)
        {
            var genusDtoList = new List<GenusDto>();

            list.ToList().ForEach(g => genusDtoList.Add(this._dtoFactory.Build(g)));

            return genusDtoList;   
        }
    }
}