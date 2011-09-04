using System;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels
{
    public class LakeViewModel : ViewModelBase, IPanelViewModel
    {
        public LakeDto Lake { get; set; }

        public GenusPanelViewModel GenusPanelViewModel { get; set; }
    }
}
