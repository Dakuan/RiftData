using System;
using System.Collections.Generic;
using RiftData.Domain.Entities;

namespace RiftData.Shared.ViewModels
{
    public class SpeciesPageViewModel : PanelViewModelBase
    {
        public string SpeciesName { get; set; }

        public PhotoGalleryViewModel PhotoGalleryViewModel { get; set; }

        public IList<Locale> Locales { get; set; }
    }
}
