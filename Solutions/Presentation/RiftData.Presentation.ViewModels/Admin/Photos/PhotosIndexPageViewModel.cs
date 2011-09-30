using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels.Admin.Photos
{
    public class PhotosIndexPageViewModel : Shared.ViewModelBase
    {
        public PhotosIndexPageViewModel()
        {
            //this.SelectedView = SelectedView.Photos;
        }

        public IList<PhotoDto> Photos { get; set; }
    }
}