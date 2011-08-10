using RiftData.ApplicationServices.DtoServices;
using RiftData.ApplicationServices.DtoServices.Contracts;
using RiftData.ApplicationServices.ViewModelFactories.Contracts;
using RiftData.Domain.Repositories;
using RiftData.Presentation.ViewModels;
using ISpeciesRepository = RiftData.ApplicationServices.Repositories.ISpeciesRepository;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    public class SpeciesPageViewModelFactory : ISpeciesPageViewModelFactory
    {
        private readonly ISpeciesRepository _speciesRepository;
        private readonly IGenusTypeService _genusTypeService;
        private readonly IGenusPanelViewModelFactory _genusPanelViewModelFactory;
        private readonly ILocaleDtoService _localeDtoService;
        private readonly IPhotoGalleryViewModelFactory _photoGalleryViewModelFactory;

        public SpeciesPageViewModelFactory(ISpeciesRepository speciesRepository, IGenusTypeService genusTypeService,
             IGenusPanelViewModelFactory genusPanelViewModelFactory, ILocaleDtoService localeDtoService, IPhotoGalleryViewModelFactory photoGalleryViewModelFactory)
        {
            _speciesRepository = speciesRepository;
            _genusTypeService = genusTypeService;

            _genusPanelViewModelFactory = genusPanelViewModelFactory;
            _localeDtoService = localeDtoService;
            _photoGalleryViewModelFactory = photoGalleryViewModelFactory;
        }

        public SpeciesPageViewModel Build(string fullName)
        {
            var speciesId = this._speciesRepository.FindSpeciesIdFromFullName(fullName);

            return this.Build(speciesId);
        }

        public SpeciesPageViewModel Build(int speciesId)
        {
            var species = this._speciesRepository.GetSpeciesFromId(speciesId);
     
            var viewModel = new SpeciesPageViewModel
                                {
                                    SpeciesName = species.FullName,
                                    SpeciesId = species.Id,
                                    GenusTypes = this._genusTypeService.GetGenusTypesThatContainGenus(),
                                    SelectedGenusTypeId = species.Genus.GenusType.Id,
                                    Locales = this._localeDtoService.GetLocaleDtosFromSpecies(speciesId),
                                    GenusPanelViewModel = this._genusPanelViewModelFactory.Build(species.Genus.GenusType.Id, species.Genus.Id, species.Id),
                                    PhotoGalleryViewModel = this._photoGalleryViewModelFactory.Build(species)
                                };

            return viewModel;
        }
    }
}
