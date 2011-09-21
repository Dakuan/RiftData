namespace RiftData.Domain.Extensions
{
    using System.Collections.Generic;
    using System.Linq;

    using RiftData.Domain.Entities;

    public static class FishExtensionMethods
    {
        public static IEnumerable<Fish> SortFish(this IEnumerable<Fish> unsortedList)
        {
            var sortedList = new List<Fish>();

            unsortedList.ToList().OrderBy(f => f.Genus.Name).GroupBy(f => f.Genus.Name).ToList().ForEach(f => f.OrderBy(f2 => f2.Species.Name).ToList().GroupBy(f3 => f3.Species.Name).ToList().ForEach(f4 => f4.OrderBy(f5 => f5.Locale.Name).ToList().ForEach(sortedList.Add)));

            return sortedList;
        }
    }
}