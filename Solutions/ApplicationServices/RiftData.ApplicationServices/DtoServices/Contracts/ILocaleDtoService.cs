namespace RiftData.ApplicationServices.DtoServices.Contracts
{
    using System.Collections.Generic;

    using RiftData.Presentation.ViewModels.Dto;

    public interface ILocaleDtoService
    {
        LocaleDto GetLocaleDto(int localeId);

        IEnumerable<LocaleDto> GetLocaleDtosFromSpecies(int speciesId);

        IEnumerable<LocaleDto> GetLocalesForZoomLevel(int zoomLevel);
    }
}