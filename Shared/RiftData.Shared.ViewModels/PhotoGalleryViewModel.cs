using System.Collections.Generic;
using RiftData.Domain.Entities;

namespace RiftData.Presentation.ViewModels
{
    public class PhotoGalleryViewModel
    {
        public string Name { get; set; }

        public IList<PhotoDto> Photos { get; set; }
    }
}
