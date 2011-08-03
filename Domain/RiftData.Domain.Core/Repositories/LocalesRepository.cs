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

                this.dataEntites.Locale.OrderBy(l => l.LocaleName).ToList()
                                                .ForEach(l =>
                                                        {
                                                            var localeHasPhotos = this.dataEntites.Photos.Where(p => p.LocaleId == l.LocaleID).Count() > 0;
                                                            list.Add(this.localesFactory.Build(l, localeHasPhotos));
                                                        });
                return list.AsQueryable();
            }
        }
    }
}
