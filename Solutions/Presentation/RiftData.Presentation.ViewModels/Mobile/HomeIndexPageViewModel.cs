namespace RiftData.Presentation.ViewModels.Mobile
{
    using System.Collections.Generic;

    using RiftData.Presentation.ViewModels.Dto;
    using RiftData.Presentation.ViewModels.Mobile.Shared;

    public class HomeIndexPageViewModel : ViewModelBase
    {
        public IDictionary<LakeDto, IDictionary<GenusTypeDto, PhotoDto>> DataDictionary { get; set; }
    }
}