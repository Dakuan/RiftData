using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.ApplicationServices.DtoServices.Contracts
{
    public interface ILakeDtoService
    {
        IEnumerable<LakeDto>GetAllLakes();

        LakeDto GetLakeFromName(string lakeName);
    }
}