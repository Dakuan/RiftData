using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Admin.Shared;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels.Admin.Genus
{
    public class GenusIndexPageViewModel : Shared.ViewModelBase
    {
        public GenusIndexPageViewModel()
        {
            this.SelectedView = SelectedView.Genus;
        }

        public IList<GenusDto> Genus { get; set; }
    }
}