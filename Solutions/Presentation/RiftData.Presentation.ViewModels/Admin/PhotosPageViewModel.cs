using System.Collections.Generic;
using RiftData.Domain.Entities;

namespace RiftData.Presentation.ViewModels.Admin
{
    public class PhotosPageViewModel : ViewModelBase 
    {
        public PhotosPageViewModel()
        {
            SelectedView = SelectedView.Photos;
        }

        public IEnumerable<Photo> Photos { get; set; }
    }
}