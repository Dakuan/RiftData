﻿namespace RiftData.Presentation.ViewModels
{
    using System.Collections.Generic;

    using RiftData.Presentation.ViewModels.Dto;

    public class LocaleInfoBoxViewModel
    {
        public string Name { get; set; }

        public string PhotoUrl { get; set; }

        public IList<SpeciesDto> Species { get; set; }
    }
}