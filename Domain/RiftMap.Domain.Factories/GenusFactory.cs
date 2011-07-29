using System;
using System.Collections.Generic;
using System.Linq;
using RiftData.Infrastructure.Data;
using RiftMap.Domain.Factories.Exceptions;
using Genus = RiftData.Domain.Core.Genus;
using Species = RiftData.Domain.Core.Species;

namespace RiftMap.Domain.Factories
{
    public class GenusFactory : FactoryBase, IFactory<Genus>
    {

        public GenusFactory(RiftDataDataEntities dataEntities) : base(dataEntities)
        {
        }

        public Genus Build(int id)
        {
            var dataObject = this.dataEntities.Genus.FirstOrDefault(g => g.GenusID == id);

            if (dataObject == null)
            {
                throw new NullDataObjectException();
            }

            var speciesList = new List<Species>();

            var genus = new Genus(dataObject.GenusID, dataObject.GenusName);

            this.dataEntities.Species.ToList().Where(s => s.Genus == dataObject.GenusID).ToList()
                                                        .ForEach(s => speciesList.Add(new Species(s.SpeciesID, s.SpeciesName, Convert.ToBoolean(s.Described)){ Genus = genus }));

            if (speciesList.Count < 1)
            {
                throw new EmptySpeciesListException();
            }

            return genus;
        }
    }
}