using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels.Admin.Shared
{
    public class PhotosPageViewModel : Shared.ViewModelBase
    {
        public IEnumerable<PhotoDto> Photos { get; set; }
    }
}