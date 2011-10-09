using RiftData.ApplicationServices.Extensions;
using RiftData.Presentation.Contracts.ViewModelFactories.Admin;
using RiftData.Presentation.ViewModels.Admin.GenusType;
using RiftData.Presentation.ViewModels.Admin.Shared;

namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using System.Linq;
    using RiftData.Domain.Repositories;

    public class GenusTypeIndexPageViewModelFactory : IGenusTypeIndexPageViewModelFactory
    {
        private readonly IGenusTypeRepository genusTypeRepository;
        private readonly INavigationViewModelFactory navigationViewModelFactory;

        public GenusTypeIndexPageViewModelFactory(IGenusTypeRepository genusTypeRepository, INavigationViewModelFactory navigationViewModelFactory)
        {
            this.genusTypeRepository = genusTypeRepository;
            this.navigationViewModelFactory = navigationViewModelFactory;
        }

        public GenusTypeIndexPageViewModel Build()
        {
            var viewModel = new GenusTypeIndexPageViewModel { NavigationViewModel = this.navigationViewModelFactory.Build(SelectedView.GenusTypes), GenusTypes = this.genusTypeRepository.GetAll().ToList().ToDtoList() };

            return viewModel;
        }
    }
}