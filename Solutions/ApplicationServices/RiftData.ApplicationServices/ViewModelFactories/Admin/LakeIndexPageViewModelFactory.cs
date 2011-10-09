using RiftData.ApplicationServices.Extensions;
using RiftData.Presentation.Contracts.ViewModelFactories.Admin;
using RiftData.Presentation.ViewModels.Admin.Shared;

namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.ViewModels.Admin.Lake;

    public class LakeIndexPageViewModelFactory : ILakeIndexPageViewModelFactory
    {
        private readonly ILakeRepository lakeRepository;
        private readonly INavigationViewModelFactory navigationViewModelFactory;

        public LakeIndexPageViewModelFactory(ILakeRepository lakeRepository, INavigationViewModelFactory navigationViewModelFactory)
        {
            this.lakeRepository = lakeRepository;
            this.navigationViewModelFactory = navigationViewModelFactory;
        }

        public LakeIndexPageViewModel Build()
        {
            var viewModel = new LakeIndexPageViewModel { NavigationViewModel = this.navigationViewModelFactory.Build(SelectedView.Lake), Lakes = this.lakeRepository.GetAll().ToDtoList() };

            return viewModel;
        }
    }
}