namespace RiftData.Presentation.ViewModels
{
    using System.Collections.Generic;

    using RiftData.Presentation.ViewModels.Dto;

    public class LakeViewModel : ViewModelBase, IPanelViewModel
    {
        public GenusPanelViewModel GenusPanelViewModel { get; set; }

        public LakeDto Lake { get; set; }

        public IList<LocaleDto> Locales { get; set; }
    }
}