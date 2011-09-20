using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels.Admin
{
    public class HomePageViewModel : ViewModelBase
    {
        public HomePageViewModel()
        {
            this.SelectedView = SelectedView.Home;
        }

        public IList<UserLogDto> UserLogs { get; set; }
    }
}