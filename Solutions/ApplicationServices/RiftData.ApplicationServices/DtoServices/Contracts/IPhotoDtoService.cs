namespace RiftData.ApplicationServices.DtoServices.Contracts
{
    using System.Collections.Generic;
    using Domain.Entities;
    using Presentation.ViewModels.Dto;

    public interface IPhotoDtoService
    {
        IList<PhotoDto> GetPhotosForSpecies(int speciesId);

        IList<PhotoDto> GetPhotosForLocale(int localeId);

        IList<PhotoDto> GetPhotosForFish(Fish fish);
    }
}