using RiftData.Domain.Entities;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    using Domain.Repositories;
    using DtoServices.Contracts;
    using Presentation.Contracts;
    using Presentation.ViewModels;


    public class SpeciesPageViewModelFactory : ISpeciesPageViewModelFactory
    {
        private readonly ISpeciesRepository speciesRepository;
        private readonly IGenusPanelViewModelFactory genusPanelViewModelFactory;
        private readonly ILocaleDtoService localeDtoService;
        private readonly IPhotoGalleryViewModelFactory photoGalleryViewModelFactory;
        private readonly IHeaderViewModelFactory headerViewModelFactory;

        private readonly IDtoFactory dtoFactory;

        public SpeciesPageViewModelFactory(ISpeciesRepository speciesRepository, IGenusPanelViewModelFactory genusPanelViewModelFactory,
                                           ILocaleDtoService localeDtoService, IPhotoGalleryViewModelFactory photoGalleryViewModelFactory, IHeaderViewModelFactory headerViewModelFactory, IDtoFactory dtoFactory)
        {
            this.speciesRepository = speciesRepository;
            this.genusPanelViewModelFactory = genusPanelViewModelFactory;
            this.localeDtoService = localeDtoService;
            this.photoGalleryViewModelFactory = photoGalleryViewModelFactory;
            this.headerViewModelFactory = headerViewModelFactory;
            this.dtoFactory = dtoFactory;
        }

        public SpeciesPageViewModel Build(string fullName)
        {
            var species = this.speciesRepository.GetSpeciesFromFullName(fullName);

            return this.Build(species);
        }

        public SpeciesPageViewModel Build(Species species)
        {
            var headerViewModel = this.headerViewModelFactory.BuildFromSpecies(species.Id);

            var genusPanel = this.genusPanelViewModelFactory.Build(species.Genus.GenusType.Id);
     
            var viewModel = new SpeciesPageViewModel
                                {
                                    Species = this.dtoFactory.Build(species),
                                    HeaderViewModel = headerViewModel,
                                    Locales = this.localeDtoService.GetLocaleDtosFromSpecies(species.Id),
                                    PhotoGalleryViewModel = this.photoGalleryViewModelFactory.Build(species),
                                    GenusPanelViewModel = genusPanel
                                };

            return viewModel;
        }
    }
}
