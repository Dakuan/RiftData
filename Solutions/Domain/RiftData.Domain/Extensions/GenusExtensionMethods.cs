using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Entities;

namespace RiftData.Domain.Extensions
{
    public static class GenusExtensionMethods
    {
        public static IEnumerable<Genus> SortGenus (this IEnumerable<Genus> unsortedList)
        {
            return unsortedList.OrderBy(g => g.Name);
        }
    }
}
