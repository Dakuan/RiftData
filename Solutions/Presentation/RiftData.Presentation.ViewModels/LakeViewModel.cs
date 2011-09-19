namespace RiftData.Presentation.ViewModels
{
    using RiftData.Presentation.ViewModels.Dto;

    public class LakeViewModel : ViewModelBase, IPanelViewModel
    {
        public GenusPanelViewModel GenusPanelViewModel { get; set; }

        public LakeDto Lake { get; set; }
    }
}