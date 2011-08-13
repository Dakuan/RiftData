using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.ApplicationServices.DtoServices.Contracts
{
    public interface IFishDtoService
    {
        IList<FishDto> GetFishAtLocale(int localeId);
    }
}