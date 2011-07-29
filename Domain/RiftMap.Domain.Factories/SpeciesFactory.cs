using System;
using System.Linq;
using RiftData.Infrastructure.Data;
using RiftMap.Domain.Factories.Exceptions;
using Species = RiftData.Domain.Core.Species;
using Genus = RiftData.Domain.Core.Genus;
using DataSpecies = RiftData.Infrastructure.Data.Species;

namespace RiftMap.Domain.Factories
{
    public class SpeciesFactory : ISpeciesFactory
    {
        public SpeciesFactory(RiftDataDataEntities dataEntities)// : base(dataEntities)
        {
        }

        public Species Build(DataSpecies dataSpecies, Genus genus)
        {
            var species = new Species(dataSpecies.SpeciesID, dataSpecies.SpeciesName, Convert.ToBoolean(dataSpecies.Described)){ Genus = genus };

            return species;
        }
    }
}