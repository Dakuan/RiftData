namespace RiftData.Presentation.ViewModels.Admin
{
    using System.Collections.Generic;
    using System.Web.Mvc;

    using RiftData.Presentation.ViewModels.Dto;

    public class FishIndexPageViewModel : ViewModelBase
    {
        public FishIndexPageViewModel()
        {
            this.SelectedView = SelectedView.Fish;
        }

        public IEnumerable<FishDto> Fish { get; set; }

        public SelectList GenusList { get; set; }

        public IEnumerable<GenusTypeDto> GenusTypes { get; set; }

        public GenusTypeDto Type { get; set; }
    }
}