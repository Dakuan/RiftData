using System;
using RiftData.Domain.Entities;

namespace RiftData.Domain.Factories
{
    public class SpeciesFactory : ISpeciesFactory
    {
        public Species Build(Infrastructure.Data.Species dataSpecies, Genus genus)
        {
            var species = new Species(dataSpecies.SpeciesID)
                              {
                                  Genus = genus,
                                  Described = Convert.ToBoolean(dataSpecies.Described),
                                  Name = dataSpecies.SpeciesName
                              };

            return species;
        }
    }
}