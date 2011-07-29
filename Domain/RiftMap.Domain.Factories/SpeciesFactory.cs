using System;
using System.Linq;
using RiftData.Infrastructure.Data;
using RiftMap.Domain.Factories.Exceptions;
using Species = RiftData.Domain.Core.Species;
using Genus = RiftData.Domain.Core.Genus;

namespace RiftMap.Domain.Factories
{
    public class SpeciesFactory : FactoryBase, ISpeciesFactory
    {
        public SpeciesFactory(RiftDataDataEntities dataEntities) : base(dataEntities)
        {
        }

        public Species Build(int id, Genus genus)
        {
            var dataObject = this.dataEntities.Species.FirstOrDefault(s => s.SpeciesID == id);

            if (dataObject == null)
            {
                throw new NullDataObjectException();
            }

            var species = new Species(dataObject.SpeciesID, dataObject.SpeciesName, Convert.ToBoolean(dataObject.Described)){ Genus = genus };

            return species;
        }
    }
}