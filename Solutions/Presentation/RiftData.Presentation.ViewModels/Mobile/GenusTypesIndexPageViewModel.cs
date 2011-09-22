using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels.Mobile
{
    public class GenusTypesIndexPageViewModel : Shared.ViewModelBase
    {
        public IList<GenusDto> Genera { get; set; }
    }
}