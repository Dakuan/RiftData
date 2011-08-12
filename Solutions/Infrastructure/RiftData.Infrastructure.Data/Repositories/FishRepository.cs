using System;
using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Entities;
using RiftData.Domain.Extensions;
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
            get { return this.dataEntities.Fish.SortFish().AsQueryable(); }
        }

        public IQueryable<Fish> GetFishBySpecies(int speciesId)
        {
            var list = new List<Fish>();

            this.dataEntities.Fish.Where(f => f.Species.Id == speciesId).ToList().ForEach(list.Add);

            return list.SortFish().AsQueryable();
        }

        public IList<Fish> GetFishByLocale(int localeId)
        {
            return this.dataEntities.Fish.Where(f => f.Locale.Id == localeId).ToList();
        }
    }
}
