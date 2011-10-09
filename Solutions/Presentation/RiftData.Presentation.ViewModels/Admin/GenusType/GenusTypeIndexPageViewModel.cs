using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Admin.Shared;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels.Admin.GenusType
{
    public class GenusTypeIndexPageViewModel : Shared.ViewModelBase
    {
        public IEnumerable<GenusTypeDto> GenusTypes;
    }
}