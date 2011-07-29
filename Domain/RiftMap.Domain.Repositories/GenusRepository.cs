using System;
using System.Collections.Generic;
using System.Linq;
using RiftData.Infrastructure.Data;
using RiftMap.Domain.Factories;
using Genus = RiftData.Domain.Core.Genus;

namespace RiftMap.Domain.Repositories
{
    public class GenusRepository : IRepository<Genus>
    {
        private IGenusFactory genusFactory;

        private RiftDataDataEntities dataEntities;

        public GenusRepository(IGenusFactory genusFactory, RiftDataDataEntities riftDataDataEntities)
        {
            this.genusFactory = genusFactory;

            this.dataEntities = riftDataDataEntities;
        }

        public IQueryable<Genus> List 
        { 
            get 
            { 
                var list = new List<Genus>();

                this.dataEntities.Genus.ToList().ForEach(g =>
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
    }
}