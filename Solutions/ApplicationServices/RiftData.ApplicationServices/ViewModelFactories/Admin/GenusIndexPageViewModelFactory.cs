using RiftData.ApplicationServices.Extensions;
using RiftData.Presentation.Contracts.ViewModelFactories.Admin;
using RiftData.Presentation.ViewModels.Admin.Genus;
using RiftData.Presentation.ViewModels.Admin.Shared;

namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using System.Linq;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.ViewModels.Admin;

    public class GenusIndexPageViewModelFactory : IGenusIndexPageViewModelFactory
    {
        private readonly IGenusRepository genusRepository;
        private readonly INavigationViewModelFactory navigationViewModelFactory;

        public GenusIndexPageViewModelFactory(IGenusRepository genusRepository, INavigationViewModelFactory navigationViewModelFactory)
        {
            this.genusRepository = genusRepository;
            this.navigationViewModelFactory = navigationViewModelFactory;
        }

        public GenusIndexPageViewModel Builld()
        {
            var viewModel = new GenusIndexPageViewModel { NavigationViewModel = this.navigationViewModelFactory.Build(SelectedView.Genus), Genus = this.genusRepository.GetAll().ToList().ToDtoList() };

            return viewModel;
        }
    }
}