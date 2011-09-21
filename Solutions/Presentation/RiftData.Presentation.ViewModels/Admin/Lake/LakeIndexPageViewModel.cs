namespace RiftData.Presentation.ViewModels.Admin.Lake
{
    using System.Collections.Generic;

    using RiftData.Presentation.ViewModels.Dto;

    public class LakeIndexPageViewModel : ViewModelBase
    {
        public LakeIndexPageViewModel()
        {
            this.SelectedView = SelectedView.Lake;
        }

        public IList<LakeDto> Lakes { get; set; }
    }
}