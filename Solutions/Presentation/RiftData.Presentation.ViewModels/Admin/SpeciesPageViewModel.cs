using System.Collections.Generic;
using RiftData.Domain.Entities;

namespace RiftData.Presentation.ViewModels.Admin
{
    public class SpeciesPageViewModel : ViewModelBase
    {
        public SpeciesPageViewModel()
        {
            this.SelectedView = SelectedView.Species;
        }

        public IList<Species> Species { get; set; }
    }
}