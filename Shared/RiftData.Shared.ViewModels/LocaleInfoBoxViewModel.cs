using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using RiftData.Shared.ViewModels.Dto;

namespace RiftData.Shared.ViewModels
{
    public class LocaleInfoBoxViewModel
    {
        public string Name { get; set; }

        public string PhotoUrl { get; set; }

        public IList<SpeciesDto> Species { get; set; }
    }
}
