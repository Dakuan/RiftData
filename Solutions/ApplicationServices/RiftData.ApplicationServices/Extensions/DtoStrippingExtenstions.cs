using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using RiftData.ApplicationServices.ViewModelFactories;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.ApplicationServices.Extensions
{
    public static class DtoStrippingExtenstions
    {
        public static IList<LocaleDto> StripToBasic(this IEnumerable<LocaleDto> domainList)
        {
            domainList.ToList().ForEach(x => x.Lake.GenusTypes.Clear());

            return domainList.ToList();
        }
    }
}
