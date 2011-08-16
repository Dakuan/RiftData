using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels
{
    public class FishPageViewModel : PanelViewModelBase
    {
        public FishDto Fish { get; set; }

        public PhotoGalleryViewModel PhotoGalleryViewModel { get; set; }
    }
}