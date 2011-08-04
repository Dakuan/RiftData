using System;
using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Factories;
using RiftData.Infrastructure.Data;
using Genus = RiftData.Domain.Entities.Genus;

namespace RiftData.Domain.Repositories
{
    public class GenusRepository : RepositoryBase<Genus, RiftData.Infrastructure.Data.Genus>, IGenusRepository
    {
        private IGenusFactory genusFactory;

        public GenusRepository(IGenusFactory genusFactory, RiftDataDataEntities dataEntities) : base(dataEntities)
        {
            this.genusFactory = genusFactory;
        }

        public IQueryable<Genus> List 
        { 
            get 
            { 
                var list = new List<Genus>();

                this.dataEntities.Genus.OrderBy(g => g.GenusName).ToList()
                                                    .ForEach(g =>
                                                             {
                                                                 try
                                                                 {
                                                                     var genus = this.genusFactory.Build(g);

                                                                     list.Add(genus);
                                                                 }
                                                                 catch (Exception)
                                                                 {
                                                                     //todo, log bad data
                                                                 }
                                                             });

                return list.AsQueryable();
            }
        }

        public IList<Genus> GetGenusOfIdWithFish(int genusTypeId)
        {
            var list = new List<Genus>();

            this.dataEntities.Genus.Where(g => g.GenusType == genusTypeId && g.Species.Count > 0).ToList().ForEach(g => list.Add(this.genusFactory.Build(g)));

            return list;
        }

        protected override IEnumerable<Genus> Sort(IEnumerable<Genus> unsortedList)
        {
            throw new NotImplementedException();
        }

        protected override Genus BuildUp(Infrastructure.Data.Genus dataObject)
        {
            throw new NotImplementedException();
        }
    }
}