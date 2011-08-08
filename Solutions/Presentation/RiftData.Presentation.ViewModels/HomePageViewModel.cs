using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels
{
    public class HomePageViewModel : PanelViewModelBase
    {
        public GenusTypeDto GenusType { get; set; }

        public PhotoGalleryViewModel PhotoGalleryViewModel { get; set; }
    }
}
