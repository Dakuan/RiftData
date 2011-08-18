using RiftData.ApplicationServices.DtoServices.Contracts;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts;
using RiftData.Presentation.ViewModels;
using ISpeciesRepository = RiftData.Domain.Repositories.ISpeciesRepository;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    public class SpeciesPageViewModelFactory : ISpeciesPageViewModelFactory
    {
        private readonly ISpeciesRepository _speciesRepository;
        private readonly IGenusPanelViewModelFactory _genusPanelViewModelFactory;
        private readonly ILocaleDtoService _localeDtoService;
        private readonly IPhotoGalleryViewModelFactory _photoGalleryViewModelFactory;
        private readonly IHeaderViewModelFactory _headerViewModelFactory;

        public SpeciesPageViewModelFactory(ISpeciesRepository speciesRepository, IGenusPanelViewModelFactory genusPanelViewModelFactory,
              ILocaleDtoService localeDtoService, IPhotoGalleryViewModelFactory photoGalleryViewModelFactory, IHeaderViewModelFactory headerViewModelFactory)
        {
            _speciesRepository = speciesRepository;
            _genusPanelViewModelFactory = genusPanelViewModelFactory;
            _localeDtoService = localeDtoService;
            _photoGalleryViewModelFactory = photoGalleryViewModelFactory;
            _headerViewModelFactory = headerViewModelFactory;
        }

        public SpeciesPageViewModel Build(string fullName)
        {
            var speciesId = this._speciesRepository.FindSpeciesIdFromFullName(fullName);

            return this.Build(speciesId);
        }

        public SpeciesPageViewModel Build(int speciesId)
        {
            var species = this._speciesRepository.GetSpeciesFromId(speciesId);

            var headerViewModel = this._headerViewModelFactory.BuildFromSpecies(species.Id);

            var genusPanel = this._genusPanelViewModelFactory.Build(species.Genus.GenusType.Id);
     
            var viewModel = new SpeciesPageViewModel
                                {
                                    SpeciesName = species.FullName,
                                    SpeciesId = species.Id,
                                    HeaderViewModel = headerViewModel,
                                    Locales = this._localeDtoService.GetLocaleDtosFromSpecies(speciesId),
                                    PhotoGalleryViewModel = this._photoGalleryViewModelFactory.Build(species),
                                    GenusPanelViewModel = genusPanel
                                };

            return viewModel;
        }
    }
}
