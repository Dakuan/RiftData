using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Admin.Shared;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels.Admin.Home
{
    public class HomePageViewModel : Shared.ViewModelBase
    {
        public HomePageViewModel()
        {
            this.SelectedView = SelectedView.Home;
        }

        public IList<UserLogDto> UserLogs { get; set; }
    }
}