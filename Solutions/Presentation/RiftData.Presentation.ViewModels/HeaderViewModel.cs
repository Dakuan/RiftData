namespace RiftData.Presentation.ViewModels
{
    using System.Collections.Generic;

    using RiftData.Presentation.ViewModels.Dto;

    public class HeaderViewModel
    {
        public IEnumerable<GenusTypeDto> GenusTypes { get; set; }

        public IEnumerable<LakeDto> Lakes { get; set; }

        public int? SelectedGenusTypeId { get; set; }

        public int? SelectedLakeId { get; set; }
    }
}