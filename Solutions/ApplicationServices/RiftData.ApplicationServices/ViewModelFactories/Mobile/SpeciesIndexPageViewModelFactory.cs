using RiftData.ApplicationServices.Extensions;

namespace RiftData.ApplicationServices.ViewModelFactories.Mobile
{
    using System.Linq;

    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts.ViewModelFactories.Mobile;
    using RiftData.Presentation.ViewModels.Mobile;
    using RiftData.Presentation.ViewModels.Shared;

    public class SpeciesIndexPageViewModelFactory : ISpeciesIndexPageViewModelFactory
    {
        private readonly ISpeciesRepository speciesRepository;
        private readonly ILocalesRepository localesRepository;
        private readonly IPhotosRepository photosRepository;

        public SpeciesIndexPageViewModelFactory(ISpeciesRepository speciesRepository, ILocalesRepository localesRepository, IPhotosRepository photosRepository)
        {
            this.speciesRepository = speciesRepository;
            this.localesRepository = localesRepository;
            this.photosRepository = photosRepository;
        }

        public SpeciesIndexPageViewModel Build(string speciesName)
        {
            var species = this.speciesRepository.GetSpeciesFromFullName(speciesName);

            var locales = this.localesRepository.GetWithSpecies(species.Id);

            var photos = this.photosRepository.GetForSpecies(species.Id);

            var viewModel = new SpeciesIndexPageViewModel
                                {
                                    Header = species.FullName,
                                    MetaData = MetaData.Build(string.Join(", ", species.Genus.Species.Select(x => x.FullName)), species.FullName, string.Format("Information about {0}", species.FullName)),
                                    Species = DtoFactory.Build(species),
                                    Locales = locales.ToDtoList(),
                                    Photos = photos.ToDtoList()
                                };

            return viewModel;
        }
    }
}