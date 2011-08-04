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

            this.dataEntities.Genus.Where(g => g.GenusType == genusTypeId && dataEntities.Fish.Any(f => f.Genus == g.GenusID)).ToList().ForEach(g => list.Add(this.genusFactory.Build(g)));

            return this.Sort(list).ToList();
        }

        protected override IEnumerable<Genus> Sort(IEnumerable<Genus> unsortedList)
        {
            return unsortedList.OrderBy(g => g.Name);
        }

        protected override Genus BuildUp(Infrastructure.Data.Genus dataObject)
        {
            //genus factory requires no other components, this fuction is redundant.
            throw new NotImplementedException();
        }
    }
}