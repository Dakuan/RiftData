﻿using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.ApplicationServices.DtoServices.Contracts
{
    public interface ILocaleDtoService
    {
        IList<LocaleDto> GetLocaleDtosFromSpecies(int speciesId);
        LocaleDto GetLocaleDto(int localeId);

        IList<LocaleDto> GetLocalesForZoomLevel(int zoomLevel);
    }
}