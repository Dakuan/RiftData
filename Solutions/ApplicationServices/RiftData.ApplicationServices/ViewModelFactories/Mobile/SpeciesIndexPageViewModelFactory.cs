using RiftData.ApplicationServices.DtoServices.Extensions;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts.ViewModelFactories.Mobile;
using RiftData.Presentation.ViewModels.Mobile;
using RiftData.Presentation.ViewModels.Shared;

namespace RiftData.ApplicationServices.ViewModelFactories.Mobile
{
    public class SpeciesIndexPageViewModelFactory : ISpeciesIndexPageViewModelFactory
    {
        private readonly ISpeciesRepository speciesRepository;
        private readonly ILocalesRepository localesRepository;

        public SpeciesIndexPageViewModelFactory(ISpeciesRepository speciesRepository, ILocalesRepository localesRepository)
        {
            this.speciesRepository = speciesRepository;
            this.localesRepository = localesRepository;
        }

        public SpeciesIndexPageViewModel Build(string speciesName)
        {
            var species =  this.speciesRepository.GetSpeciesFromFullName(speciesName);

            var locales = this.localesRepository.GetWithSpecies(species.Id);

            var viewModel = new SpeciesIndexPageViewModel
                                {
                                    Header = string.Format("RiftData | {0}", species.FullName),
                                    MetaData = MetaData.Build(string.Empty, string.Empty, string.Empty),
                                    Species = DtoFactory.Build(species),
                                    Locales = locales.ToDtoList()
                                };

            return viewModel;
        }
    }
}