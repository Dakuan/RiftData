using System.Collections.Generic;
using RiftData.Domain.Entities;

namespace RiftData.Presentation.ViewModels.Admin
{
    public class GenusTypeIndexPageViewModel : ViewModelBase
    {
        public GenusTypeIndexPageViewModel()
        {
            this.SelectedView = SelectedView.GenusTypes;
        }

        public IEnumerable<GenusType> GenusTypes;
    }
}