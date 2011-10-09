using RiftData.Domain.Extensions;
using RiftData.Presentation.Contracts.ViewModelFactories.Admin;
using RiftData.Presentation.ViewModels.Admin.Shared;

namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.ViewModels.Admin;
    using RiftData.Presentation.ViewModels.Admin.GenusType;

    public class GenusTypeCreatePageViewModelFactory : IGenusTypeCreatePageViewModelFactory
    {
        private readonly ILakeRepository lakeRepository;
        private readonly INavigationViewModelFactory navigationViewModelFactory;

        public GenusTypeCreatePageViewModelFactory(ILakeRepository lakeRepository, INavigationViewModelFactory navigationViewModelFactory)
        {
            this.lakeRepository = lakeRepository;
            this.navigationViewModelFactory = navigationViewModelFactory;
        }

        public GenusTypeCreatePageViewModel Build()
        {
            var lakes = this.lakeRepository.GetAll();

            var viewModel = new GenusTypeCreatePageViewModel { NavigationViewModel = this.navigationViewModelFactory.Build(SelectedView.GenusTypes), Lakes = lakes.ToSelectList("select a lake") };

            return viewModel;
        }
    }
}