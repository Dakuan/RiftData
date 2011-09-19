namespace RiftData.ApplicationServices.DtoServices.Contracts
{
    using System.Collections.Generic;

    using RiftData.Presentation.ViewModels.Dto;

    public interface ISpeciesDtoService
    {
        IEnumerable<SpeciesDto> GetSpeciesAtLocale(int localeId);

        IEnumerable<SpeciesDto> GetSpeciesWithGenus(int id);
    }
}