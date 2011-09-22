using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels.Mobile
{
    public class SpeciesPhotosPageViewModel : Shared.ViewModelBase
    {
        public IList<PhotoDto> Photos { get; set; }
    }
}