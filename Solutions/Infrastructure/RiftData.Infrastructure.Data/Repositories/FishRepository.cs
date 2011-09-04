namespace RiftData.Infrastructure.Data.Repositories
{
    using System.Collections.Generic;
    using System.Linq;
    using Domain.Entities;
    using Domain.Extensions;
    using Domain.Repositories;

    public class FishRepository : IFishRepository
    {
        private readonly RiftDataDataContext dataEntities;

        public FishRepository(RiftDataDataContext dataEntities)
        {
            this.dataEntities = dataEntities;
        }

        public IQueryable<Fish> List
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
            return this.dataEntities.Fish.Where(f => f.Locale.Id == localeId).SortFish().ToList();
        }

        public Fish GetFishFromName(string fishName)
        {
            var components = fishName.Split('_');

            var genusName = components[0];

            var speciesName = components[1];

            var localeName = components[2];

            return this.dataEntities.Fish.First(f => f.Genus.Name == genusName && f.Species.Name == speciesName && f.Locale.Name == localeName);
        }
    }
}