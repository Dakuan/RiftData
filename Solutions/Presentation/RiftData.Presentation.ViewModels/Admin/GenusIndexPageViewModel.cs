using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels.Admin
{
    public class GenusIndexPageViewModel : ViewModelBase
    {
        public GenusIndexPageViewModel()
        {
            this.SelectedView = SelectedView.Genus;
        }

        public IList<GenusDto> Genus { get; set; }
    }
}