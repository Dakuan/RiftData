namespace RiftData.Domain.Extensions
{
    using System.Collections.Generic;
    using System.Linq;

    using RiftData.Domain.Entities;

    public static class LocaleExtensionMethods
    {
        public static IEnumerable<Locale> SortLocales(this IEnumerable<Locale> unsortedList)
        {
            var sortedList = unsortedList.OrderBy(l => l.Name);

            return sortedList;
        }
    }
}