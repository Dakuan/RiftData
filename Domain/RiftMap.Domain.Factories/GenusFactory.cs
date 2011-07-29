using System.Collections.Generic;
using System.Linq;
using RiftData.Infrastructure.Data;
using RiftMap.Domain.Factories.Exceptions;
using Genus = RiftData.Domain.Core.Genus;
using Species = RiftData.Domain.Core.Species;

namespace RiftMap.Domain.Factories
{
    public class GenusFactory : FactoryBase, IGenusFactory
    {
        private readonly ISpeciesFactory speciesFactory;

        public GenusFactory(RiftDataDataEntities dataEntities, ISpeciesFactory speciesFactory) : base(dataEntities)
        {
            this.speciesFactory = speciesFactory;
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
                                                            .ForEach(s => speciesList.Add(this.speciesFactory.Build(s.SpeciesID, genus)));

            if (speciesList.Count < 1)
            {
                throw new EmptySpeciesListException();
            }

            genus.Species = speciesList.OrderBy(s => s.Name).ToList();

            return genus;
        }
    }
}