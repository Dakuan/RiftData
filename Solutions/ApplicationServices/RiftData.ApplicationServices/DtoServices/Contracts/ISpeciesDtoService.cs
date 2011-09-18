using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.ApplicationServices.DtoServices.Contracts
{
    public interface ISpeciesDtoService
    {
        IEnumerable<SpeciesDto> GetSpeciesAtLocale(int localeId);

        IEnumerable<SpeciesDto> GetSpeciesWithGenus(int id);
    }
}