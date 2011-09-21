namespace RiftData.Presentation.ViewModels.Admin
{
    using System.Collections.Generic;

    using RiftData.Presentation.ViewModels.Dto;

    public class GenusTypeIndexPageViewModel : ViewModelBase
    {
        public IEnumerable<GenusTypeDto> GenusTypes;

        public GenusTypeIndexPageViewModel()
        {
            this.SelectedView = SelectedView.GenusTypes;
        }
    }
}