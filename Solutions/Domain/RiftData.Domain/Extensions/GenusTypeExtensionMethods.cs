using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Entities;

namespace RiftData.Domain.Extensions
{
    public static class GenusTypeExtensionMethods
    {
        public static IEnumerable<GenusType> SortGenusTypes(this IEnumerable<GenusType> unsortedList)
        {
            var sortedList = unsortedList.OrderBy(l => l.Name);

            return sortedList;
        }
    }
}
