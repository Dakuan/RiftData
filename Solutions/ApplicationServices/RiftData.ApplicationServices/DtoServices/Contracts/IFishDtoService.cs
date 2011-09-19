namespace RiftData.ApplicationServices.DtoServices.Contracts
{
    using System.Collections.Generic;

    using RiftData.Presentation.ViewModels.Dto;

    public interface IFishDtoService
    {
        IEnumerable<FishDto> GetFishAtLocale(int localeId);
    }
}