using System.Collections.Generic;
using System.Web.Mvc;
using RiftData.Presentation.ViewModels.Admin.Shared;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels.Admin.Fish
{
    public class FishIndexPageViewModel : Shared.ViewModelBase
    {
        public IEnumerable<FishDto> Fish { get; set; }

        public SelectList GenusList { get; set; }

        public GenusTypeDto Type { get; set; }
    }
}