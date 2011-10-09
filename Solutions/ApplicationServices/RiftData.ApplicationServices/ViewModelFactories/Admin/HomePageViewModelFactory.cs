using RiftData.ApplicationServices.Extensions;
using RiftData.Presentation.Contracts.ViewModelFactories.Admin;
using RiftData.Presentation.ViewModels.Admin.Home;
using RiftData.Presentation.ViewModels.Admin.Shared;

namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using RiftData.Domain.Repositories;

    public class HomePageViewModelFactory : IHomePageViewModelFactory
    {
        private readonly IUserLogRepository userLogRepository;
        private readonly INavigationViewModelFactory navigationViewModelFactory;

        public HomePageViewModelFactory(IUserLogRepository userLogRepository, INavigationViewModelFactory navigationViewModelFactory)
        {
            this.userLogRepository = userLogRepository;
            this.navigationViewModelFactory = navigationViewModelFactory;
        }

        public HomePageViewModel Build()
        {
            var viewModel = new HomePageViewModel { NavigationViewModel = this.navigationViewModelFactory.Build(SelectedView.Home), UserLogs = this.userLogRepository.GetAll().ToDtoList() };

            return viewModel;
        }
    }
}