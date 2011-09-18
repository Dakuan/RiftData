using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.ApplicationServices.DtoServices.Contracts
{
    public interface ILocaleDtoService
    {
        IEnumerable<LocaleDto> GetLocaleDtosFromSpecies(int speciesId);
        LocaleDto GetLocaleDto(int localeId);

        IEnumerable<LocaleDto> GetLocalesForZoomLevel(int zoomLevel);
    }
}