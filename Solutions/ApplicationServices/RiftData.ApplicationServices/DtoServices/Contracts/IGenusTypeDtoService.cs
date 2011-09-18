using System.Collections.Generic;
using RiftData.Domain.Entities;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.ApplicationServices.DtoServices.Contracts
{
    public interface IGenusTypeDtoService
    {
        GenusTypeDto GetGenusTypeByName(string genusTypeName);

        IEnumerable<GenusTypeDto> GetAllGenusTypes();

        GenusTypeDto GetGenusTypeDto(int genusTypeId);

        IEnumerable<GenusTypeDto> GetGenusTypesFromLocale(Locale locale);
        IEnumerable<GenusTypeDto> GetGenusTypesFromLake(Lake lake);
    }
}