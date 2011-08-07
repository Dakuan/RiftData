using RiftData.Domain.Repositories;
using RiftData.Presentation.ViewModels;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    public class SpeciesPageViewModelFactory : ISpeciesPageViewModelFactory
    {
        private readonly ISpeciesRepository _speciesRepository;
        private readonly IPhotosRepository _photosRepository;
        private readonly IGenusTypeRepository _genusTypeRepository;
        private readonly ILocalesRepository _localesRepository;
        private readonly IGenusPanelViewModelFactory _genusPanelViewModelFactory;

        public SpeciesPageViewModelFactory(ISpeciesRepository speciesRepository, IPhotosRepository photosRepository, IGenusTypeRepository genusTypeRepository, ILocalesRepository localesRepository, IGenusPanelViewModelFactory genusPanelViewModelFactory)
        {
            _speciesRepository = speciesRepository;
            _photosRepository = photosRepository;
            _genusTypeRepository = genusTypeRepository;
            _localesRepository = localesRepository;
            _genusPanelViewModelFactory = genusPanelViewModelFactory;
        }

        public SpeciesPageViewModel Build(string fullName)
        {
            var speciesId = this._speciesRepository.FindSpeciesIdFromFullName(fullName);

            return this.Build(speciesId);
        }

        public SpeciesPageViewModel Build(int speciesId)
        {
            var species = this._speciesRepository.GetSpeciesFromId(speciesId);

            var locales = this._localesRepository.GetLocalesWithSpecies(speciesId);

            var panelViewModel = this._genusPanelViewModelFactory.Build(species.Genus.GenusType.Id);
     
            var viewModel = new SpeciesPageViewModel
                                {
                                    SpeciesName = species.FullName,
                                    SpeciesId = species.Id,
                                    GenusTypes = this._genusTypeRepository.GetGenusTypesContainingGenus(),
                                    SelectedGenusTypeId = species.Genus.GenusType.Id,
                                    Locales = locales,
                                    GenusPanelViewModel = panelViewModel,
                                    PhotoGalleryViewModel = new PhotoGalleryViewModel
                                                                {
                                                                    Name = species.FullName,
                                                                    Photos = this._photosRepository.GetPhotosForSpecies(speciesId)                                                               
                                                                }
                                };

            return viewModel;
        }
    }
}
