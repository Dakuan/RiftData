using System.Collections.Generic;
using System.Web.Mvc;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels.Admin
{
    public class FishIndexPageViewModel : ViewModelBase
    {
        public FishIndexPageViewModel()
        {
            SelectedView = SelectedView.Fish;
        }

        public SelectList GenusList { get; set; }

        public IEnumerable<FishDto> Fish { get; set; }

        public GenusTypeDto Type { get; set; }

        public IEnumerable<GenusTypeDto> GenusTypes { get; set; }
    }
}