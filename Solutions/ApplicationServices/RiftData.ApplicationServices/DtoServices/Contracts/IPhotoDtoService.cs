namespace RiftData.ApplicationServices.DtoServices.Contracts
{
    using System.Collections.Generic;

    using RiftData.Domain.Entities;
    using RiftData.Presentation.ViewModels.Dto;

    public interface IPhotoDtoService
    {
        IEnumerable<PhotoDto> GetPhotosForFish(Fish fish);

        IEnumerable<PhotoDto> GetPhotosForLocale(int localeId);

        IEnumerable<PhotoDto> GetPhotosForSpecies(int speciesId);
    }
}