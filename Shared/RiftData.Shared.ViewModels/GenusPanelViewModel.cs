using System.Collections.Generic;
using RiftData.Domain.Entities;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels
{
    public class GenusPanelViewModel
    {
        public IList<GenusDto> GenusList;

        public GenusTypeDto GenusType;

        public int ExpandedGenus { get; set; }

        public int SelectedSpecies { get; set; }
    }
}
