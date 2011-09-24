using RiftData.ApplicationServices.Extensions;
using RiftData.Presentation.Contracts.ViewModelFactories.Admin;
using RiftData.Presentation.ViewModels.Admin.Species;

namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using System.Linq;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.ViewModels.Admin;

    public class SpeciesPageViewModelFactory : ISpeciesPageViewModelFactory
    {
        private readonly ISpeciesRepository speciesRepository;

        public SpeciesPageViewModelFactory(ISpeciesRepository speciesRepository)
        {
            this.speciesRepository = speciesRepository;
        }

        public SpeciesPageViewModel Build()
        {
            var viewModel = new SpeciesPageViewModel { Species = this.speciesRepository.GetAll().ToList().ToDtoList(), };

            return viewModel;
        }
    }
}