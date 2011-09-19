using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels.Admin
{
    public class PhotosPageViewModel : ViewModelBase 
    {
        public PhotosPageViewModel()
        {
            SelectedView = SelectedView.Photos;
        }

        public IEnumerable<PhotoDto> Photos { get; set; }
    }
}