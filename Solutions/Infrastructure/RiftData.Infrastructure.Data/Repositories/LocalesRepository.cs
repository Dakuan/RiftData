﻿using System;
using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Entities;
using RiftData.Domain.Repositories;

namespace RiftData.Infrastructure.Data.Repositories
{
    public class LocalesRepository :  ILocalesRepository
    {
        private readonly RiftDataDataContext dataEntities;

        public LocalesRepository(RiftDataDataContext dataEntities)
        {
            this.dataEntities = dataEntities;
        }

        public Locale GetById(int id)
        {
            var dataLocale = this.dataEntities.Locales.First(l => l.Id == id);

            if (dataLocale == null) return null;

            return dataLocale;
        }

        public IList<Locale> GetLocalesWithSpecies(int speciesId)
        {
            var list = new List<Locale>();
            
            dataEntities.Fish.Where(f => f.Species.Id == speciesId).ToList().ForEach(f => list.Add(f.Locale));

            return this.Sort(list).ToList();
        }

        public Locale GetByFullName(string fullName)
        {
            return this.dataEntities.Locales.First(f => f.Name == fullName);
        }

        private IEnumerable<Locale> Sort(IEnumerable<Locale> unsortedList)
        {
           var sortedList =  unsortedList.OrderBy(l => l.Name);

            return sortedList;
        }
    }
}