using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels.Admin
{
    public class GenusTypeIndexPageViewModel : ViewModelBase
    {
        public GenusTypeIndexPageViewModel()
        {
            this.SelectedView = SelectedView.GenusTypes;
        }

        public IEnumerable<GenusTypeDto> GenusTypes;
    }
}