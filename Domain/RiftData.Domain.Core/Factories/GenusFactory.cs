using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Entities;
using RiftData.Domain.Exceptions;

namespace RiftData.Domain.Factories
{
    public class GenusFactory : IGenusFactory
    {
        private readonly ISpeciesFactory speciesFactory;

        private IGenusTypeFactory genusTypeFactory;

        public GenusFactory(ISpeciesFactory speciesFactory, IGenusTypeFactory genusTypeFactory)
        {
            this.speciesFactory = speciesFactory;

            this.genusTypeFactory = genusTypeFactory;
        }

        public Genus Build(Infrastructure.Data.Genus dataGenus)
        {
            var speciesList = new List<Species>();

            var genus = new Genus(dataGenus.GenusID) { Name = dataGenus.GenusName, GenusType = this.genusTypeFactory.Build(dataGenus.Type)};

            dataGenus.Species.ToList().Where(s => s.Genus == dataGenus.GenusID).ToList()
                                                    .ForEach(s => speciesList.Add(this.speciesFactory.Build(s, genus)));

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