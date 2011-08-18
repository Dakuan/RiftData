using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels
{
    public class HeaderViewModel
    {
        public IList<LakeDto> Lakes { get; set; }

        public IList<GenusTypeDto> GenusTypes { get; set; }

        public int? SelectedGenusTypeId { get; set; }

        public int? SelectedLakeId { get; set; }
    }
}