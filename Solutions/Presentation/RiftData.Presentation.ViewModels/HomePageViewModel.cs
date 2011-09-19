namespace RiftData.Presentation.ViewModels
{
    using RiftData.Presentation.ViewModels.Dto;

    public class HomePageViewModel : ViewModelBase, IPanelViewModel
    {
        public GenusPanelViewModel GenusPanelViewModel { get; set; }

        public GenusTypeDto GenusType { get; set; }

        public PhotoGalleryViewModel PhotoGalleryViewModel { get; set; }
    }
}