using System;
using System.Linq;
using RiftData.Infrastructure.Data;
using RiftMap.Domain.Factories.Exceptions;
using Species = RiftData.Domain.Core.Species;
using Genus = RiftData.Domain.Core.Genus;

namespace RiftMap.Domain.Factories
{
    public class SpeciesFactory : FactoryBase, IFactory<Species>
    {
        private IFactory<Genus> genusFactory;

        public SpeciesFactory(RiftDataDataEntities dataEntities, IFactory<Genus> genusFactory) : base(dataEntities)
        {
            this.genusFactory = genusFactory;
        }

        public Species Build(int id)
        {
            var dataObject = this.dataEntities.Species.FirstOrDefault(s => s.SpeciesID == id);

            if (dataObject == null)
            {
                throw new NullDataObjectException();
            }

            var species = new Species(dataObject.SpeciesID, dataObject.SpeciesName, Convert.ToBoolean(dataObject.Described)){Genus = this.genusFactory.Build(dataObject.Genus)};

            return species;
        }
    }
}