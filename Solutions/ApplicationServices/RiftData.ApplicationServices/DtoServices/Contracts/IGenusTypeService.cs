using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.ApplicationServices.DtoServices.Contracts
{
    public interface IGenusTypeService
    {
        IList<GenusTypeDto> GetGenusTypesThatContainGenus();
    }
}