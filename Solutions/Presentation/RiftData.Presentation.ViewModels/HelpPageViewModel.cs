using System.Collections.Generic;
using System.Linq;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels
{
    public class HelpPageViewModel : ViewModelBase, IPanelViewModel
    {
        public GenusPanelViewModel GenusPanelViewModel { get; set; }

        public IEnumerable<IGrouping<int,FishDto>> FishRequiringPhotos { get; set; }

        public IEnumerable<IList<SpeciesDto>> SpeciesRequiringLocales { get; set; } 
    }
}
