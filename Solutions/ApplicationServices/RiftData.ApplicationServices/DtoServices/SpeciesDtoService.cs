namespace RiftData.ApplicationServices.DtoServices
{
    using System.Collections.Generic;

    using RiftData.ApplicationServices.DtoServices.Contracts;
    using RiftData.ApplicationServices.DtoServices.Extensions;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.ViewModels.Dto;

    public class SpeciesDtoService : ISpeciesDtoService
    {
        private readonly ISpeciesRepository _speciesRepository;

        public SpeciesDtoService(ISpeciesRepository speciesRepository)
        {
            _speciesRepository = speciesRepository;
        }

        public IEnumerable<SpeciesDto> GetSpeciesAtLocale(int localeId)
        {
            return this._speciesRepository.GetSpeciesAtLocale(localeId).ToDtoList();
        }

        public IEnumerable<SpeciesDto> GetSpeciesWithGenus(int id)
        {
            return this._speciesRepository.GetSpeciesWithGenus(id).ToDtoList();
        }
    }
}