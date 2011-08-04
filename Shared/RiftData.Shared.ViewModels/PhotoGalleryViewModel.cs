using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using RiftData.Domain.Entities;

namespace RiftData.Shared.ViewModels
{
    public class PhotoGalleryViewModel
    {
        public string Name { get; set; }

        public IList<Photo> Photos { get; set; }
    }
}
