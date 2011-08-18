using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels
{
    public class HomePageViewModel : ViewModelBase, IPanelViewModel
    {
        public GenusTypeDto GenusType { get; set; }

        public GenusPanelViewModel GenusPanelViewModel { get; set; }

        public PhotoGalleryViewModel PhotoGalleryViewModel { get; set; }
    }
}
