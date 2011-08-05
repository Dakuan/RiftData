using System;
using System.Linq;
using RiftData.Domain.Entities;

namespace RiftData.Domain.Factories
{
    public class SpeciesFactory : ISpeciesFactory
    {
        public Species Build(Infrastructure.Data.Species dataSpecies, Genus genus, bool hasPhotos)
        {
            var hasFish = dataSpecies.Fish.Count > 0;

            var species = new Species(dataSpecies.SpeciesID)
                              {
                                  Genus = genus,
                                  Described = Convert.ToBoolean(dataSpecies.Described),
                                  Name = dataSpecies.SpeciesName.Trim(),
                                  HaveFish = hasFish,
                                  HasPhotos = hasPhotos
                              };

            return species;
        }
    }
}