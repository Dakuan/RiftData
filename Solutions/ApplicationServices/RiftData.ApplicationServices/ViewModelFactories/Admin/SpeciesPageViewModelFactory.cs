namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using System.Linq;

    using RiftData.ApplicationServices.DtoServices.Extensions;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts.Admin.SpeciesPages;
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
            var viewModel = new SpeciesPageViewModel
                {
                   Species = this.speciesRepository.GetAll().ToList().ToDtoList(), 
                };

            return viewModel;
        }
    }
}