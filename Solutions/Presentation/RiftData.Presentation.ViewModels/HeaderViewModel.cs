using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels
{
    public class HeaderViewModel
    {
        public IEnumerable<LakeDto> Lakes { get; set; }

        public IEnumerable<GenusTypeDto> GenusTypes { get; set; }

        public int? SelectedGenusTypeId { get; set; }

        public int? SelectedLakeId { get; set; }
    }
}