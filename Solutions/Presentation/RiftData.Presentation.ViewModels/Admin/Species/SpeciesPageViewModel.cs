using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Admin.Shared;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels.Admin.Species
{
    public class SpeciesPageViewModel : Shared.ViewModelBase
    {
        public IEnumerable<SpeciesDto> Species { get; set; }
    }
}