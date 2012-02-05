namespace RiftData.Domain.Extensions
{
    using System.Collections.Generic;
    using System.Linq;

    using RiftData.Domain.Entities;

    public static class LocaleExtensionMethods
    {
        public static IEnumerable<Locale> SortLocales(this IEnumerable<Locale> unsortedList)
        {
            var sortedList = new List<Locale>();

            unsortedList.OrderBy(x => x.Name).GroupBy(x => x.Lake.Name).ToList().ForEach(x => x.ToList().ForEach(sortedList.Add));

            return sortedList;
        }
    }
}