using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels
{
    public class PanelViewModelBase
    {
        public IList<GenusTypeDto> GenusTypes;

        public GenusPanelViewModel GenusPanelViewModel { get; set; }

        public int? SelectedGenusTypeId { get; set; }
    }
}
