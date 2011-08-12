using System;
using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Entities;
using RiftData.Domain.Repositories;

namespace RiftData.Infrastructure.Data.Repositories
{
    public class FishRepository :  IFishRepository
    {
        private readonly RiftDataDataContext dataEntities;

        public FishRepository(RiftDataDataContext dataEntities)
        {
            this.dataEntities = dataEntities;
        }

        public  IQueryable<Fish> List
        {
            get
            {
                var sortedList = Sort(this.dataEntities.Fish);

                return sortedList.AsQueryable();
            }
        }

        public IQueryable<Fish> GetFishBySpecies(int speciesId)
        {
            var list = new List<Fish>();

            this.dataEntities.Fish.Where(f => f.Species.Id == speciesId).ToList().ForEach(f =>
            {
                list.Add(f);
            });

            return Sort(list).AsQueryable();
        }

        public IList<Fish> GetFishByLocale(int localeId)
        {
            return this.dataEntities.Fish.Where(f => f.Locale.Id == localeId).ToList();
        }

        protected IEnumerable<Fish> Sort(IEnumerable<Fish> unsortedList)
        {
            var sortedList = new List<Fish>();

            unsortedList.ToList().OrderBy(f => f.Genus.Name)
                                            .GroupBy(f => f.Genus.Name).ToList()
                                            .ForEach(f => f.OrderBy(f2 => f2.Species.Name).ToList()
                                            .GroupBy(f3 => f3.Species.Name).ToList()
                                            .ForEach(f4 => f4.OrderBy(f5 => f5.Locale.Name).ToList()
                                            .ForEach(sortedList.Add)));

            return sortedList;
        }
    }
}
