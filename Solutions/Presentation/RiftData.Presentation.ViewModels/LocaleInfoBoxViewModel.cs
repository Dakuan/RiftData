﻿using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels
{
    public class LocaleInfoBoxViewModel
    {
        public string Name { get; set; }

        public string PhotoUrl { get; set; }

        public IEnumerable<SpeciesDto> Species { get; set; }
    }
}
