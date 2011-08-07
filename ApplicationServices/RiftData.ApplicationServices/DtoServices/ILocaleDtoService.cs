using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.ApplicationServices.DtoServices
{
    public interface ILocaleDtoService
    {
        IList<LocaleDto> GetLocaleDtosFromSpecies(int speciesId);
    }
}