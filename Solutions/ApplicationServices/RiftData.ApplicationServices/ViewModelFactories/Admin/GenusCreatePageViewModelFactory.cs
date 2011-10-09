using RiftData.Domain.Extensions;
using RiftData.Presentation.Contracts.ViewModelFactories.Admin;
using RiftData.Presentation.ViewModels.Admin.Shared;

namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.ViewModels.Admin.Genus;

    public class GenusCreatePageViewModelFactory : IGenusCreatePageViewModelFactory
    {
        private readonly ILakeRepository lakeRepository;
        private readonly INavigationViewModelFactory navigationViewModelFactory;

        public GenusCreatePageViewModelFactory(ILakeRepository lakeRepository, INavigationViewModelFactory navigationViewModelFactory)
        {
            this.lakeRepository = lakeRepository;
            this.navigationViewModelFactory = navigationViewModelFactory;
        }

        public GenusCreatePageViewModel Build()
        {
            var viewModel = new GenusCreatePageViewModel { NavigationViewModel = this.navigationViewModelFactory.Build(SelectedView.Genus), Lakes = this.lakeRepository.GetAllWithGenusTypes().ToSelectList("Select a lake") };

            return viewModel;
        }
    }
}