using RiftData.ApplicationServices.Extensions;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts.ViewModelFactories.Admin;
using RiftData.Presentation.ViewModels.Admin.Shared;

namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    public class NavigationViewModelFactory : INavigationViewModelFactory
    {
        private readonly ILakeRepository lakeRepository;

        public NavigationViewModelFactory(ILakeRepository lakeRepository)
        {
            this.lakeRepository = lakeRepository;
        }

        public NavigationPartialViewModel Build(SelectedView selectedView)
        {
            var viewModel = new NavigationPartialViewModel
                                {
                                    Lakes = this.lakeRepository.GetAll().ToDtoList(),
                                    SelectedView = selectedView
                                };

            return viewModel;
        }
    }
}