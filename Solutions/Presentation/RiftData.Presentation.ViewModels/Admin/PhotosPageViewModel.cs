namespace RiftData.Presentation.ViewModels.Admin
{
    using System.Collections.Generic;

    using RiftData.Presentation.ViewModels.Dto;

    public class PhotosPageViewModel : ViewModelBase
    {
        public PhotosPageViewModel()
        {
            this.SelectedView = SelectedView.Photos;
        }

        public IEnumerable<PhotoDto> Photos { get; set; }
    }
}