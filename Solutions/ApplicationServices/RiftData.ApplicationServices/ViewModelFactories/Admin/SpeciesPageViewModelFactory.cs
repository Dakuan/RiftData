using System.Linq;
using RiftData.ApplicationServices.DtoServices.Extensions;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts.Admin;
using RiftData.Presentation.ViewModels.Admin;

namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    public class SpeciesPageViewModelFactory : ISpeciesPageViewModelFactory
    {
        private readonly ISpeciesRepository _speciesRepository;

        public SpeciesPageViewModelFactory(ISpeciesRepository speciesRepository)
        {
            _speciesRepository = speciesRepository;
        }

        public SpeciesPageViewModel Build()
        {
            var viewModel = new SpeciesPageViewModel
                                {
                                    Species = this._speciesRepository.GetAll().ToList().ToDtoList(),
                                };

            return viewModel;
        }
    }
}