﻿using System;
using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Factories;
using RiftData.Infrastructure.Data;
using RiftMap.Domain.Repositories;
using Genus = RiftData.Domain.Core.Genus;

namespace RiftData.Domain.Repositories
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
    }
}