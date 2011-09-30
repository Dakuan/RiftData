namespace RiftData.Presentation.ViewModels
{
    using System.Collections.Generic;

    using RiftData.Presentation.ViewModels.Dto;

    public class GenusPanelViewModel
    {
        public IList<GenusDto> GenusList;

        public int ExpandedGenus { get; set; }

        public int SelectedSpecies { get; set; }

        public int LakeId { get; set; }
    }
}