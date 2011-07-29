using System.Collections.Generic;
using System.Linq;
using RiftData.Infrastructure.Data;
using RiftMap.Domain.Factories.Exceptions;
using Genus = RiftData.Domain.Core.Genus;
using Species = RiftData.Domain.Core.Species;

namespace RiftData.Domain.Factories
{
    public class GenusFactory : IGenusFactory
    {
        private readonly ISpeciesFactory speciesFactory;

        public GenusFactory(ISpeciesFactory speciesFactory)
        {
            this.speciesFactory = speciesFactory;
        }

        public Genus Build(Infrastructure.Data.Genus dataGenus)
        {
            var speciesList = new List<Species>();

            var genus = new Genus(dataGenus.GenusID, dataGenus.GenusName);

            dataGenus.Species.ToList().Where(s => s.Genus == dataGenus.GenusID).ToList()
                                                            .ForEach(s => speciesList.Add(this.speciesFactory.Build(s, genus)));

            if (speciesList.Count < 1)
            {
                throw new EmptySpeciesListException();
            }

            genus.Species = speciesList.OrderBy(s => s.Name).ToList();

            return genus;
        }
    }
}