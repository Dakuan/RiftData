using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.ApplicationServices.DtoServices.Contracts
{
    public interface IGenusTypeDtoService
    {
        IList<GenusTypeDto> GetGenusTypesThatContainGenus();

        GenusTypeDto GetGenusTypeByName(string genusTypeName);

        IList<GenusTypeDto> GetAllGenusTypes();

        GenusTypeDto GetGenusTypeDto(int genusTypeId);
    }
}