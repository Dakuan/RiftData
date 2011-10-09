using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels.Admin.Shared
{
    public class NavigationPartialViewModel : Shared.ViewModelBase
    {
        public SelectedView SelectedView { get; set; }

        public IList<LakeDto> Lakes { get; set; }
    }
}