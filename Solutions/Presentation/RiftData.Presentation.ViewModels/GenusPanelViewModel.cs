using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels
{
    public class GenusPanelViewModel
    {
        public IEnumerable<GenusDto> GenusEnumerable;

        public int ExpandedGenus { get; set; }

        public int SelectedSpecies { get; set; }
    }
}
