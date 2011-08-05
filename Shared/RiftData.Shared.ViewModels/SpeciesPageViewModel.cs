using System;

namespace RiftData.Shared.ViewModels
{
    public class SpeciesPageViewModel : PanelViewModelBase
    {
        public string SpeciesName { get; set; }

        public PhotoGalleryViewModel PhotoGalleryViewModel { get; set; }
    }
}
