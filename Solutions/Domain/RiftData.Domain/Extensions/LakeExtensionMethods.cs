namespace RiftData.Domain.Extensions
{
    using System.Collections.Generic;
    using System.Linq;

    using RiftData.Domain.Entities;

    public static class LakeExtensionMethods
    {
        public static IEnumerable<Lake> SortLakes(this IEnumerable<Lake> unsortedList)
        {
            var sortedList = unsortedList.OrderBy(l => l.Name);

            return sortedList;
        }
    }
}