using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Entities;
using RiftData.Infrastructure.Data;

namespace RiftData.ApplicationServices.Repositories
{
    public class LocalesRepository :  ILocalesRepository
    {
        private readonly RiftDataDataContext dataEntities;

        public LocalesRepository(RiftDataDataContext dataEntities)
        {
            this.dataEntities = dataEntities;
        }

        public Locale GetById(int id)
        {
            var dataLocale = this.dataEntities.Locales.First(l => l.Id == id);

            if (dataLocale == null) return null;

            return dataLocale;
        }

        public IList<Locale> GetLocalesWithSpecies(int speciesId)
        {
            var list = new List<Locale>();
            
            /*
            dataEntities.Species.First(s => s.Id == speciesId).Fish.ToList().ForEach(f =>
                                                                                                {
                                                                                                    if (f.Locale1 != null) list.Add(this.BuildUp(f.Locale1));
                                                                                                });*/

            return this.Sort(list).ToList();
        }

        private IEnumerable<Locale> Sort(IEnumerable<Locale> unsortedList)
        {
           var sortedList =  unsortedList.OrderBy(l => l.Name);

            return sortedList;
        }
    }
}