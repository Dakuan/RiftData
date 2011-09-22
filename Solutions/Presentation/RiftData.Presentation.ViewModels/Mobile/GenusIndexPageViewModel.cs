using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels.Mobile
{
    public class GenusIndexPageViewModel : Shared.ViewModelBase
    {
        public IList<SpeciesDto> SpeciesList { get; set; }
    }
}