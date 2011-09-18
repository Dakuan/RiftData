using System.Collections.Generic;
using RiftData.Domain.Entities;

namespace RiftData.Presentation.ViewModels.Admin
{
    public class GenusIndexPageViewModel : ViewModelBase
    {
        public GenusIndexPageViewModel()
        {
            this.SelectedView = SelectedView.Genus;
        }

        public List<Genus> Genus { get; set; }
    }
}