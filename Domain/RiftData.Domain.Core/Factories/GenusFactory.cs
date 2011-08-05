using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Exceptions;
using RiftData.Domain.Services;
using RiftData.Infrastructure.Data;
using Genus = RiftData.Domain.Entities.Genus;
using Species = RiftData.Domain.Entities.Species;

namespace RiftData.Domain.Factories
{
    public class GenusFactory : IGenusFactory
    {
        private readonly ISpeciesFactory speciesFactory;

        private IGenusTypeFactory genusTypeFactory;

        private readonly RiftDataDataEntities _dataEntities;

        public GenusFactory(ISpeciesFactory speciesFactory, IGenusTypeFactory genusTypeFactory, RiftDataDataEntities dataEntities)
        {
            this.speciesFactory = speciesFactory;

            this.genusTypeFactory = genusTypeFactory;
            _dataEntities = dataEntities;
        }

        public Genus Build(Infrastructure.Data.Genus dataGenus)
        {
            var speciesList = new List<Species>();

            var genus = new Genus(dataGenus.GenusID) { Name = dataGenus.GenusName.Trim(), GenusType = this.genusTypeFactory.Build(dataGenus.Type)};
            
            dataGenus.Species.ToList().Where(s => s.Genus == dataGenus.GenusID).ToList()
                                                    .ForEach(s => speciesList.Add(this.speciesFactory.Build(s, genus, SpeciesService.SpeciesHasPhoto(this._dataEntities, s.SpeciesID))));

            if (speciesList.Count < 1)
            {
                throw new EmptySpeciesListException();
            }

            genus.HasFish = dataGenus.Fish.Count > 0;

            genus.Species = speciesList.OrderBy(s => s.Name).ToList();

            return genus;
        }
    }
}