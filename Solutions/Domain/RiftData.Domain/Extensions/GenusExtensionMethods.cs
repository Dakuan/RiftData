namespace RiftData.Domain.Extensions
{
    using System.Collections.Generic;
    using System.Linq;

    using RiftData.Domain.Entities;

    public static class GenusExtensionMethods
    {
        public static IEnumerable<Genus> SortGenus(this IEnumerable<Genus> unsortedList)
        {
            return unsortedList.OrderBy(g => g.Name);
        }
    }
}