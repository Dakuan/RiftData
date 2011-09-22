using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels.Mobile
{
    using RiftData.Presentation.ViewModels.Mobile.Shared;

    public class HomeIndexPageViewModel : ViewModelBase
    {
        public IList<LakeDto> Lakes { get; set; }

        public IDictionary<LakeDto, IList<GenusTypeDto>> DataDictionary { get; set; }
    }
}