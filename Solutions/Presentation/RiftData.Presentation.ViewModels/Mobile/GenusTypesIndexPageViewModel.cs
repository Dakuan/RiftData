using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels.Mobile
{
    public class GenusTypesIndexPageViewModel : Shared.ViewModelBase
    {
        public IDictionary<GenusDto, PhotoDto> Genera { get; set; }
    }
}