using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.ApplicationServices.DtoServices.Contracts
{
    public interface IPhotoDtoService
    {
        IList<PhotoDto> GetPhotosForSpecies(int speciesId);

        IList<PhotoDto> GetPhotosForLocale(int localeId);
    }
}