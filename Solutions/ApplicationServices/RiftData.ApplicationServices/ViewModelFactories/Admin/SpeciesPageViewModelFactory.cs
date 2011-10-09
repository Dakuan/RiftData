using RiftData.ApplicationServices.Extensions;
using RiftData.Presentation.Contracts.ViewModelFactories.Admin;
using RiftData.Presentation.ViewModels.Admin.Shared;
using RiftData.Presentation.ViewModels.Admin.Species;

namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using System.Linq;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.ViewModels.Admin;

    public class SpeciesPageViewModelFactory : ISpeciesPageViewModelFactory
    {
        private readonly ISpeciesRepository speciesRepository;
        private readonly INavigationViewModelFactory navigationViewModelFactory;

        public SpeciesPageViewModelFactory(ISpeciesRepository speciesRepository, INavigationViewModelFactory navigationViewModelFactory)
        {
            this.speciesRepository = speciesRepository;
            this.navigationViewModelFactory = navigationViewModelFactory;
        }

        public SpeciesPageViewModel Build()
        {
            var viewModel = new SpeciesPageViewModel { NavigationViewModel = this.navigationViewModelFactory.Build(SelectedView.Fish), Species = this.speciesRepository.GetAll().ToList().ToDtoList(), };

            return viewModel;
        }
    }
}