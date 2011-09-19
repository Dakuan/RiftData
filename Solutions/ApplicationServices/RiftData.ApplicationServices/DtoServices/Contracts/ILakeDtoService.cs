namespace RiftData.ApplicationServices.DtoServices.Contracts
{
    using System.Collections.Generic;

    using RiftData.Presentation.ViewModels.Dto;

    public interface ILakeDtoService
    {
        IEnumerable<LakeDto> GetAllLakes();

        LakeDto GetLakeFromName(string lakeName);
    }
}