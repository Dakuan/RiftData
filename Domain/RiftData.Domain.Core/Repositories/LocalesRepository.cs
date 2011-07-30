using System;
using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Factories;
using RiftData.Infrastructure.Data;
using Locale = RiftData.Domain.Entities.Locale;

namespace RiftData.Domain.Repositories
{
    public class LocalesRepository : RepositoryBase<Locale>
    {
        private IGenusFactory genusFactory;

        private ISpeciesFactory speciesFactory;

        private ILocalesFactory localesFactory;
        public LocalesRepository(IGenusFactory genusFactory, ISpeciesFactory speciesFactory, ILocalesFactory localesFactory, RiftDataDataEntities dataEntities) : base(dataEntities)
        {
            this.genusFactory = genusFactory;

            this.speciesFactory = speciesFactory;

            this.localesFactory = localesFactory;
        }

        public override IQueryable<Locale> List
        {
            get 
            {
                var list = new List<Locale>();

                this.dataEntites.Locale.OrderBy(l => l.LocaleName).ToList().ForEach(l => list.Add(this.localesFactory.Build(l)));

                return list.AsQueryable();
            }
        }
    }
}
