using System.Collections.Generic;

using RiftData.ApplicationServices.DtoServices.Contracts;
using RiftData.Domain.Repositories;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.ApplicationServices.DtoServices
{
    using RiftData.ApplicationServices.DtoServices.Extensions;
    using RiftData.ApplicationServices.ViewModelFactories;

    public class LakeDtoService : ILakeDtoService
    {
        private readonly ILakeRepository _lakeRepository;

        public LakeDtoService(ILakeRepository lakeRepository)
        {
            _lakeRepository = lakeRepository;
        }

        public IEnumerable<LakeDto>GetAllLakes()
        {
            return this._lakeRepository.GetAll().ToDtoList();
        }

        public LakeDto GetLakeFromName(string lakeName)
        {
            return DtoFactory.Build(this._lakeRepository.GetFromName(lakeName));
        }
    }
}