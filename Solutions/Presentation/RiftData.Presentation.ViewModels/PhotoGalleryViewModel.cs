namespace RiftData.Presentation.ViewModels
{
    using System.Collections.Generic;

    using RiftData.Presentation.ViewModels.Dto;

    public class PhotoGalleryViewModel
    {
        public bool HasPhotos
        {
            get
            {
                return this.Photos.Count > 0;
            }
        }

        public string Name { get; set; }

        public IList<PhotoDto> Photos { get; set; }
    }
}