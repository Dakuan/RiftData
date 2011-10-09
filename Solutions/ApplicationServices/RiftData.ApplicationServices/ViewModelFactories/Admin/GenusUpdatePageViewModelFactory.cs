using RiftData.Presentation.Contracts.ViewModelFactories.Admin;
using RiftData.Presentation.ViewModels.Admin.Genus;
using RiftData.Presentation.ViewModels.Admin.Shared;

namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using RiftData.Domain.Repositories;

    public class GenusUpdatePageViewModelFactory : IGenusUpdatePageViewModelFactory
    {
        private readonly IGenusRepository genusRepository;

        private readonly ILakeRepository lakeRepository;
        private readonly INavigationViewModelFactory navigationViewModelFactory;

        public GenusUpdatePageViewModelFactory(IGenusRepository genusRepository, ILakeRepository lakeRepository, INavigationViewModelFactory navigationViewModelFactory)
        {
            this.genusRepository = genusRepository;
            this.lakeRepository = lakeRepository;
            this.navigationViewModelFactory = navigationViewModelFactory;
        }

        public GenusUpdatePageViewModel Build(int genusId)
        {
            var genus = this.genusRepository.Get(genusId);

            var viewModel = new GenusUpdatePageViewModel { NavigationViewModel = this.navigationViewModelFactory.Build(SelectedView.Genus), Id = genusId, Name = genus.Name, };

            return viewModel;
        }
    }
}