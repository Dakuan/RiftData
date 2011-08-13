using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.ApplicationServices.DtoServices.Contracts
{
    public interface ISpeciesDtoService
    {
        IList<SpeciesDto> GetSpeciesAtLocale(int localeId);
    }
}