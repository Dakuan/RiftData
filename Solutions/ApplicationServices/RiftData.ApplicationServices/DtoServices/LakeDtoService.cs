using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using RiftData.ApplicationServices.DtoServices.Contracts;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.ApplicationServices.DtoServices
{
    public class LakeDtoService : ILakeDtoService
    {
        private readonly IDtoFactory _dtoFactory;
        private readonly ILakeRepository _lakeRepository;

        public LakeDtoService(IDtoFactory dtoFactory, ILakeRepository lakeRepository)
        {
            _dtoFactory = dtoFactory;
            _lakeRepository = lakeRepository;
        }

        public IList<LakeDto>GetAllLakes()
        {
            var list = new List<LakeDto>();

            this._lakeRepository.GetAll().ToList().ForEach(l => list.Add(this._dtoFactory.Build(l)));

            return list;
        }

        public LakeDto GetLakeFromName(string lakeName)
        {
            return this._dtoFactory.Build(this._lakeRepository.GetLakeFromName(lakeName));
        }
    }
}
