namespace RiftData.Presentation.ViewModels.Admin
{
    using System.Collections.Generic;

    using RiftData.Presentation.ViewModels.Dto;

    public class HomePageViewModel : ViewModelBase
    {
        public HomePageViewModel()
        {
            this.SelectedView = SelectedView.Home;
        }

        public IList<UserLogDto> UserLogs { get; set; }
    }
}