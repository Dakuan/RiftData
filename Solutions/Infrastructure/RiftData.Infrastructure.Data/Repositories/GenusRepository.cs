using System;
using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Entities;
using RiftData.Domain.Extensions;
using RiftData.Domain.Repositories;

namespace RiftData.Infrastructure.Data.Repositories
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
            var list = dataEntities.Genus.Where(g => g.GenusType.Id == genusTypeId && dataEntities.Fish.Any(f => f.Genus.Id == g.Id));

            return list.SortGenus().ToList();
        }
    }
}