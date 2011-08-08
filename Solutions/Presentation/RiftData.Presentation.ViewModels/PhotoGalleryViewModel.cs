using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels
{
    public class PhotoGalleryViewModel
    {
        public string Name { get; set; }

        public IList<PhotoDto> Photos { get; set; }
    }
}
