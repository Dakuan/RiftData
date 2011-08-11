using System;
using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Entities;
using RiftData.Domain.Repositories;
using RiftData.Infrastructure.Data;

namespace RiftData.ApplicationServices.Repositories
{
    public class GenusRepository : IGenusRepository
    {

        private readonly RiftDataDataContext dataEntities;

        public GenusRepository(RiftDataDataContext dataEntities)
        {
            this.dataEntities = dataEntities;
        }

        public IQueryable<Genus> List 
        { 
            get 
            { 
                var list = new List<Genus>();

                this.dataEntities.Genus.OrderBy(g => g.Name).ToList()
                                                    .ForEach(g =>
                                                             {
                                                                 try
                                                                 {
                                                                     list.Add(g);
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

            var fishList = this.dataEntities.Fish.ToList();

          
            var list = new List<Genus>();

            var genus = this.dataEntities.Genus.ToList();

            list.AddRange(genus.Where(g => g.GenusType.Id == genusTypeId && dataEntities.Fish.Any(f => f.Genus.Id == g.Id)));

            return Sort(list).ToList();
        }

        private static IEnumerable<Genus> Sort(IEnumerable<Genus> unsortedList)
        {
            return unsortedList.OrderBy(g => g.Name);
        }
    }
}