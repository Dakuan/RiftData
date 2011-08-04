using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Factories;
using RiftData.Infrastructure.Data;
using Fish = RiftData.Domain.Entities.Fish;

namespace RiftData.Domain.Repositories
{
    public class FishRepository : IFishRepository
    {
        private readonly RiftDataDataEntities dataEntites;

        private readonly IFishFactory fishFactory;

        private readonly ILocalesFactory localesFactory;

        private readonly ISpeciesFactory speciesFactory;

        private readonly IGenusFactory genusFactory;

        public FishRepository(RiftDataDataEntities dataEntites, IFishFactory fishFactory, ILocalesFactory localesFactory, ISpeciesFactory speciesFactory, IGenusFactory genusFactory)
        {
            this.dataEntites = dataEntites;
            this.fishFactory = fishFactory;
            this.localesFactory = localesFactory;
            this.speciesFactory = speciesFactory;
            this.genusFactory = genusFactory;
        }

        public  IQueryable<Fish> List
        {
            get
            {
                var list = new List<Fish>();

                this.dataEntites.Fish.ToList()
                                      .ForEach(f =>
                                                   {
                                                       var fish = this.Build(f);

                                                       if (fish != null) list.Add(fish);
                                                   });

                var sortedList = Sort(list);

                return sortedList.AsQueryable();
            }
        }

        public IQueryable<Fish> GetFishBySpecies(int speciesId)
        {
            var list = new List<Fish>();

            this.dataEntites.Fish.Where(f => f.Species == speciesId).ToList().ForEach(f =>
            {
                var fish = this.Build(f);

                if (fish != null) list.Add(fish);
            });

            return Sort(list).AsQueryable();
        }

        private Fish Build(RiftData.Infrastructure.Data.Fish dataFish)
        {
            if (dataFish.Locale1 == null || dataFish.Genus1 == null || dataFish.Species1 == null)
            {
                //todo: log bad data

                return null;
            }
            else
            {
                var genus = this.genusFactory.Build(dataFish.Genus1);
                var species = this.speciesFactory.Build(dataFish.Species1, genus);
                var localeHasPhotos = this.dataEntites.Photos.Where(p => p.LocaleId == dataFish.Locale).Count() > 0;
                var fishHasPhotos = this.dataEntites.Photos.Where(p => p.FishId == dataFish.FishID).Count() > 0;
                var locale = this.localesFactory.Build(dataFish.Locale1, localeHasPhotos);
                var fish = this.fishFactory.Build(dataFish.FishID, species, locale, fishHasPhotos);
                return fish;
            }
        }

        private static IEnumerable<Fish> Sort(IEnumerable<Fish> unsortedList)
        {
            var sortedList = new List<Fish>();

            unsortedList.ToList().OrderBy(f => f.Genus.Name)
                                            .GroupBy(f => f.Genus.Name).ToList()
                                            .ForEach(f => f.OrderBy(f2 => f2.Species.Name).ToList()
                                            .ForEach(sortedList.Add));

            return sortedList;
        }
    }
}
