using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels.Admin
{
    public class SpeciesPageViewModel : ViewModelBase
    {
        public SpeciesPageViewModel()
        {
            this.SelectedView = SelectedView.Species;
        }

        public IEnumerable<SpeciesDto> Species { get; set; }
    }
}