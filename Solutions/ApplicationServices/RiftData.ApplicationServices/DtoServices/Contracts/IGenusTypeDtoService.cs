namespace RiftData.ApplicationServices.DtoServices.Contracts
{
    using System.Collections.Generic;

    using RiftData.Domain.Entities;
    using RiftData.Presentation.ViewModels.Dto;

    public interface IGenusTypeDtoService
    {
        IEnumerable<GenusTypeDto> GetAllGenusTypes();

        GenusTypeDto GetGenusTypeByName(string genusTypeName);

        GenusTypeDto GetGenusTypeDto(int genusTypeId);

        IEnumerable<GenusTypeDto> GetGenusTypesFromLake(Lake lake);

        IEnumerable<GenusTypeDto> GetGenusTypesFromLocale(Locale locale);
    }
}