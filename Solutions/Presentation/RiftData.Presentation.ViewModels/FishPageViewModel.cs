namespace RiftData.Presentation.ViewModels
{
    using RiftData.Presentation.ViewModels.Dto;

    public class FishPageViewModel : ViewModelBase, IPanelViewModel
    {
        public FishDto Fish { get; set; }

        public GenusPanelViewModel GenusPanelViewModel { get; set; }

        public PhotoGalleryViewModel PhotoGalleryViewModel { get; set; }
    }
}