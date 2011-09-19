namespace RiftData.Presentation.ViewModels
{
    using System.Collections.Generic;

    using RiftData.Presentation.ViewModels.Dto;

    public class LocalePageViewModel : ViewModelBase, IPanelViewModel
    {
        public IEnumerable<FishDto> Fish { get; set; }

        public GenusPanelViewModel GenusPanelViewModel { get; set; }

        public LocaleDto Locale { get; set; }

        public PhotoGalleryViewModel PhotoGallery { get; set; }
    }
}