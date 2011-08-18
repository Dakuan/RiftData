using System;
using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels
{
    public class SpeciesPageViewModel : ViewModelBase, IPanelViewModel
    {
        public string SpeciesName { get; set; }

        public int SpeciesId { get; set; }

        public PhotoGalleryViewModel PhotoGalleryViewModel { get; set; }

        public IList<LocaleDto> Locales { get; set; }

        public GenusPanelViewModel GenusPanelViewModel { get; set; }
    }
}
