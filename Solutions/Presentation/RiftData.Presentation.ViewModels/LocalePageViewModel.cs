using System;
using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels
{
    public class LocalePageViewModel : ViewModelBase, IPanelViewModel
    {
        public LocaleDto Locale { get; set; }

        public IList<FishDto> Fish { get; set; }

        public PhotoGalleryViewModel PhotoGallery { get; set; }

        public GenusPanelViewModel GenusPanelViewModel { get; set; }
    }
}