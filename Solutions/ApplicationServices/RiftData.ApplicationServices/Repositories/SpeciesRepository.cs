﻿using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Entities;
using RiftData.Infrastructure.Data;

namespace RiftData.ApplicationServices.Repositories
{
    using System.Data.Entity;

    public class SpeciesRepository : ISpeciesRepository
    {
        private readonly RiftDataDataContext dataEntities;

        public SpeciesRepository(RiftDataDataContext dataEntities)
        {
            this.dataEntities = dataEntities;
        }

        public int FindSpeciesIdFromFullName(string speciesFullName)
        {
            var components = speciesFullName.Split('_');

            var genusName = components[0].Trim();

            string speciesName;

            var described = !string.Equals(components[1], "sp");

            if (described)
            {
               speciesName = components[1];
            }
            else
            {
                speciesName = components[2].Trim();        
            }

            var fish = this.dataEntities.Fish;
            var matchingFish = fish.Where(s => string.Equals(s.Species.Name.Trim(), speciesName) && string.Equals(s.Genus.Name.Trim(), genusName));
            var firstMatch = matchingFish.First();
            
            return firstMatch.Species.Id;
        }

        public Species GetSpeciesFromId(int speciesId)
        {
            return this.dataEntities.Species.First(s => s.Id == speciesId);
        }

        public IList<Species> GetSpeciesAtLocale(int id)
        {
            var species = new List<Species>();

            this.dataEntities.Fish.Where(f => f.Locale.Id == id).ToList().ForEach(f => species.Add(f.Species));

            return this.Sort(species).ToList();
        }

        private IEnumerable<Species> Sort (IEnumerable<Species> unsortedList)
        {
            var sortedList = new List<Species>();

            sortedList.OrderBy(y => y.Genus.Name)
                .GroupBy(z => z.Genus.Name).ToList()
                .ForEach(subG => subG.OrderBy(x => x.Name).ToList()
                .ForEach(sortedList.Add));

            return sortedList;
        }
    }
}