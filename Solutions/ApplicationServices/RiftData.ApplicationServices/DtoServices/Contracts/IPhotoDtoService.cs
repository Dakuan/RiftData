namespace RiftData.ApplicationServices.DtoServices.Contracts
{
    using System.Collections.Generic;
    using Domain.Entities;
    using Presentation.ViewModels.Dto;

    public interface IPhotoDtoService
    {
        IEnumerable<PhotoDto> GetPhotosForSpecies(int speciesId);

        IEnumerable<PhotoDto> GetPhotosForLocale(int localeId);

        IEnumerable<PhotoDto> GetPhotosForFish(Fish fish);
    }
}