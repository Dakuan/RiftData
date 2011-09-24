using RiftData.ApplicationServices.Extensions;
using RiftData.Presentation.Contracts.ViewModelFactories.Admin;
using RiftData.Presentation.ViewModels.Admin.Home;

namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using RiftData.Domain.Repositories;

    public class HomePageViewModelFactory : IHomePageViewModelFactory
    {
        private readonly IUserLogRepository userLogRepository;

        public HomePageViewModelFactory(IUserLogRepository userLogRepository)
        {
            this.userLogRepository = userLogRepository;
        }

        public HomePageViewModel Build()
        {
            var viewModel = new HomePageViewModel { UserLogs = this.userLogRepository.GetAll().ToDtoList() };

            return viewModel;
        }
    }
}