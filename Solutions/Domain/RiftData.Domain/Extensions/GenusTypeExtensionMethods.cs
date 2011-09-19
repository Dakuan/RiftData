namespace RiftData.Domain.Extensions
{
    using System.Collections.Generic;
    using System.Linq;

    using RiftData.Domain.Entities;

    public static class GenusTypeExtensionMethods
    {
        public static IEnumerable<GenusType> SortGenusTypes(this IEnumerable<GenusType> unsortedList)
        {
            var sortedList = unsortedList.OrderBy(l => l.Name);

            return sortedList;
        }
    }
}