using RiftData.ApplicationServices.DtoServices.Extensions;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts.Admin;
using RiftData.Presentation.ViewModels.Admin;

namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    public class HomePageViewModelFactory : IHomePageViewModelFactory
    {
        private readonly IUserLogRepository userLogRepository;

        public HomePageViewModelFactory(IUserLogRepository userLogRepository)
        {
            this.userLogRepository = userLogRepository;
        }

        public HomePageViewModel Build()
        {
            var viewModel = new HomePageViewModel
                                {
                                    UserLogs = this.userLogRepository.GetAll().ToDtoList()
                                };

            return viewModel;
        }
    }
}
