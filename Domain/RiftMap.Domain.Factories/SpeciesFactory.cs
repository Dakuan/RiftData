using System;
using RiftData.Infrastructure.Data;
using RiftMap.Domain.Factories;
using Genus = RiftData.Domain.Core.Genus;
using Species = RiftData.Domain.Core.Species;

namespace RiftData.Domain.Factories
{
    public class SpeciesFactory : ISpeciesFactory
    {
        public SpeciesFactory(RiftDataDataEntities dataEntities)// : base(dataEntities)
        {
        }

        public Species Build(Infrastructure.Data.Species dataSpecies, Genus genus)
        {
            var species = new Species(dataSpecies.SpeciesID, dataSpecies.SpeciesName, Convert.ToBoolean(dataSpecies.Described)){ Genus = genus };

            return species;
        }
    }
}