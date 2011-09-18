using System.Collections.Generic;
using System.Linq;
using RiftData.ApplicationServices.DtoServices.Contracts;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.ApplicationServices.DtoServices
{
    using RiftData.Domain.Entities;

    public class SpeciesDtoService : ISpeciesDtoService
    {
        private readonly ISpeciesRepository _speciesRepository;
        private readonly IDtoFactory _dtoFactory;

        public SpeciesDtoService(ISpeciesRepository speciesRepository, IDtoFactory dtoFactory)
        {
            _speciesRepository = speciesRepository;
            _dtoFactory = dtoFactory;
        }

        public IEnumerable<SpeciesDto> GetSpeciesAtLocale(int localeId)
        {
            var species = this._speciesRepository.GetSpeciesAtLocale(localeId);

            return this.BuildDtoList(species);
        }

        public IEnumerable<SpeciesDto> GetSpeciesWithGenus(int id)
        {
            var species = this._speciesRepository.GetSpeciesWithGenus(id);

            return this.BuildDtoList(species);
        }

        private IEnumerable<SpeciesDto>BuildDtoList(IEnumerable<Species> species)
        {
            var speciesDtoList = new List<SpeciesDto>();

            species.ToList().ForEach(s => speciesDtoList.Add(this._dtoFactory.Build(s)));

            return speciesDtoList;
        }
    }
}