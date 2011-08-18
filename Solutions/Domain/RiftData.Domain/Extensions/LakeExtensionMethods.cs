using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using RiftData.Domain.Entities;

namespace RiftData.Domain.Extensions
{
    public static class LakeExtensionMethods
    {
        public static IEnumerable<Lake> SortLakes(this IEnumerable<Lake> unsortedList)
        {
            var sortedList = unsortedList.OrderBy(l => l.Name);

            return sortedList;
        }
    }
}
