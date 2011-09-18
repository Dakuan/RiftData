using System.Collections.Generic;
using System.Web.Mvc;
using RiftData.Domain.Entities;

namespace RiftData.Presentation.ViewModels.Admin
{
    public class FishIndexPageViewModel : ViewModelBase
    {
        public FishIndexPageViewModel()
        {
            SelectedView = SelectedView.Fish;
        }

        public SelectList GenusList { get; set; }

        public IEnumerable<Fish> Fish { get; set; }

        public GenusType Type { get; set; }

        public IEnumerable<GenusType> GenusTypes { get; set; }
    }
}