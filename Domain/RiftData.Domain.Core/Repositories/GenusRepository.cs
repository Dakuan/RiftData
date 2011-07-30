using System;
using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Factories;
using RiftData.Infrastructure.Data;
using Genus = RiftData.Domain.Entities.Genus;

namespace RiftData.Domain.Repositories
{
    public class GenusRepository : RepositoryBase<Genus>
    {
        private IGenusFactory genusFactory;

        public GenusRepository(IGenusFactory genusFactory, RiftDataDataEntities dataEntities) : base(dataEntities)
        {
            this.genusFactory = genusFactory;
        }

        public override IQueryable<Genus> List 
        { 
            get 
            { 
                var list = new List<Genus>();

                this.dataEntites.Genus.OrderBy(g => g.GenusName).ToList()
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
    }
}