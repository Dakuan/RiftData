using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using RiftData.Domain.Entities;

namespace RiftData.Domain.Extensions
{
    public static class SpeciesExtensionMethods
    {
        public static IEnumerable<Species> SortSpecies (this IEnumerable<Species> unsortedList)
        {
            var sortedList = new List<Species>();

            unsortedList.OrderBy(y => y.Genus.Name)
                .GroupBy(z => z.Genus.Name).ToList()
                .ForEach(subG => subG.OrderBy(x => x.Name).ToList()
                .ForEach(sortedList.Add));

            return sortedList;
        }
    }
}
