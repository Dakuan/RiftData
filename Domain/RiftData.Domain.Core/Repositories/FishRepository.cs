using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Factories;
using RiftData.Infrastructure.Data;
using Fish = RiftData.Domain.Entities.Fish;

namespace RiftData.Domain.Repositories
{
    public class FishRepository : IRepository<Fish>
    {
        private readonly IFishFactory fishFactory;

        private readonly ILocalesFactory localesFactory;

        private readonly ISpeciesFactory speciesFactory;

        private readonly IGenusFactory genusFactory;

        private RiftDataDataEntities dataEntities;

        public FishRepository(RiftDataDataEntities dataEntites, IFishFactory fishFactory, ILocalesFactory localesFactory, ISpeciesFactory speciesFactory, IGenusFactory genusFactory) 
        {
            this.fishFactory = fishFactory;
            this.localesFactory = localesFactory;
            this.speciesFactory = speciesFactory;
            this.genusFactory = genusFactory;

            this.dataEntities = dataEntites;
        }

        public IQueryable<Fish> List
        {
            get
            {
                var list = new List<Fish>();

                this.dataEntities.Fish.OrderBy(f => f.Genus1.GenusName)
                    .GroupBy(f => f.Genus1.GenusName).ToList()
                    .ForEach(g => g.OrderBy(s => s.Species1.SpeciesName).ToList()
                                      .ForEach(f =>
                                                   {
                                                       if (f.Locale1 != null && f.Genus1 != null && f.Species1 != null)
                                                       {
                                                           var genus = this.genusFactory.Build(f.Genus1);
                                                           var species = this.speciesFactory.Build(f.Species1, genus);
                                                           var locale = this.localesFactory.Build(f.Locale1);
                                                           list.Add(this.fishFactory.Build(f.FishID, species, locale));
                                                       }
                                                       else
                                                       {
                                                           //todo: log bad data
                                                       }
                                                   }));

                return list.AsQueryable();
            }
        }
    }
}
