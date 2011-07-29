using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Factories;
using RiftData.Infrastructure.Data;
using Locale = RiftData.Domain.Entities.Locale;

namespace RiftData.Domain.Repositories
{
    public class LocalesRepository : IRepository<Locale>
    {
        private IGenusFactory genusFactory;

        private ISpeciesFactory speciesFactory;

        private ILocalesFactory localesFactory;

        private RiftDataDataEntities dataEntities;

        public LocalesRepository(IGenusFactory genusFactory, ISpeciesFactory speciesFactory, ILocalesFactory localesFactory, RiftDataDataEntities dataEntities)
        {
            this.genusFactory = genusFactory;

            this.speciesFactory = speciesFactory;

            this.dataEntities = dataEntities;

            this.localesFactory = localesFactory;
        }

        public IQueryable<Locale> List
        {
            get 
            {
                var list = new List<Locale>();

                this.dataEntities.Locale.OrderBy(l => l.LocaleName).ToList().ForEach(l => list.Add(this.localesFactory.Build(l)));

                return list.AsQueryable();
            }
        }
    }
}
