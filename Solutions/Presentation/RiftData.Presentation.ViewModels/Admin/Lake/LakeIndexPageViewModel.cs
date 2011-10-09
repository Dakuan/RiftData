using RiftData.Presentation.ViewModels.Admin.Shared;

namespace RiftData.Presentation.ViewModels.Admin.Lake
{
    using System.Collections.Generic;

    using RiftData.Presentation.ViewModels.Dto;

    public class LakeIndexPageViewModel : Shared.ViewModelBase
    {
        public IList<LakeDto> Lakes { get; set; }
    }
}