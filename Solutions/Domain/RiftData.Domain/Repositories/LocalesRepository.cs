using System;
using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Factories;
using RiftData.Infrastructure.Data;
using Locale = RiftData.Domain.Entities.Locale;

namespace RiftData.Domain.Repositories
{
    public class LocalesRepository : RepositoryBase<Locale,RiftData.Infrastructure.Data.Locale>, ILocalesRepository
    {
        private readonly ILocalesFactory localesFactory;

        public LocalesRepository(ILocalesFactory localesFactory, RiftDataDataEntities dataEntities) : base(dataEntities)
        {
            this.localesFactory = localesFactory;
        }

        public IQueryable<Locale> List
        {
            get 
            {
                var list = new List<Locale>();

                this.dataEntities.Locale.ToList().ForEach(l => list.Add(this.BuildUp(l)));

                return this.Sort(list).AsQueryable();
            }
        }

        public Locale GetById(int id)
        {
            var dataLocale = this.dataEntities.Locale.First(l => l.LocaleID == id);

            if (dataLocale == null) return null;

            return this.BuildUp(dataLocale);
        }

        public IList<Locale> GetLocalesWithSpecies(int speciesId)
        {
            var list = new List<Locale>();

            dataEntities.Species.First(s => s.SpeciesID == speciesId).Fish.ToList().ForEach(f =>
                                                                                                {
                                                                                                    if (f.Locale1 != null) list.Add(this.BuildUp(f.Locale1));
                                                                                                });

            return this.Sort(list).ToList();
        }

        protected override IEnumerable<Locale> Sort(IEnumerable<Locale> unsortedList)
        {
           var sortedList =  unsortedList.OrderBy(l => l.Name);

            return sortedList;
        }

        protected override Locale BuildUp (RiftData.Infrastructure.Data.Locale dataLocale)
        {
            var localeHasPhotos = this.dataEntities.Photos.Where(p => p.LocaleId == dataLocale.LocaleID).Count() > 0;

            return this.localesFactory.Build(dataLocale, localeHasPhotos);
        }
    }
}