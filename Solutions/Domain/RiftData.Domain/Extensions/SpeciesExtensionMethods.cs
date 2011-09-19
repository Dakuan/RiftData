namespace RiftData.Domain.Extensions
{
    using System.Collections.Generic;
    using System.Linq;

    using RiftData.Domain.Entities;

    public static class SpeciesExtensionMethods
    {
        public static IEnumerable<Species> SortSpecies(this IEnumerable<Species> unsortedList)
        {
            var sortedList = new List<Species>();

            unsortedList.OrderBy(y => y.Genus.Name).GroupBy(z => z.Genus.Name).ToList().ForEach(
                subG => subG.OrderBy(x => x.Name).ToList().ForEach(sortedList.Add));

            return sortedList;
        }
    }
}