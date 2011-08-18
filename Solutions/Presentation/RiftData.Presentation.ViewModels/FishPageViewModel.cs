using System;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels
{
    public class FishPageViewModel : ViewModelBase, IPanelViewModel
    {
        public FishDto Fish { get; set; }

        public PhotoGalleryViewModel PhotoGalleryViewModel { get; set; }

        public GenusPanelViewModel GenusPanelViewModel { get; set; }
    }
}