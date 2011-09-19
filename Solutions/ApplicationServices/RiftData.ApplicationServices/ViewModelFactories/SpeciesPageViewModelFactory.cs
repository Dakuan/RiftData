namespace RiftData.ApplicationServices.ViewModelFactories
{
    using RiftData.ApplicationServices.DtoServices.Contracts;
    using RiftData.Domain.Entities;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts;
    using RiftData.Presentation.ViewModels;

    public class SpeciesPageViewModelFactory : ISpeciesPageViewModelFactory
    {
        private readonly IGenusPanelViewModelFactory genusPanelViewModelFactory;

        private readonly IHeaderViewModelFactory headerViewModelFactory;

        private readonly ILocaleDtoService localeDtoService;

        private readonly IPhotoGalleryViewModelFactory photoGalleryViewModelFactory;

        private readonly ISpeciesRepository speciesRepository;

        public SpeciesPageViewModelFactory(
            ISpeciesRepository speciesRepository, 
            IGenusPanelViewModelFactory genusPanelViewModelFactory, 
            ILocaleDtoService localeDtoService, 
            IPhotoGalleryViewModelFactory photoGalleryViewModelFactory, 
            IHeaderViewModelFactory headerViewModelFactory)
        {
            this.speciesRepository = speciesRepository;
            this.genusPanelViewModelFactory = genusPanelViewModelFactory;
            this.localeDtoService = localeDtoService;
            this.photoGalleryViewModelFactory = photoGalleryViewModelFactory;
            this.headerViewModelFactory = headerViewModelFactory;
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
                    Species = DtoFactory.Build(species), 
                    HeaderViewModel = headerViewModel, 
                    Locales = this.localeDtoService.GetLocaleDtosFromSpecies(species.Id), 
                    PhotoGalleryViewModel = this.photoGalleryViewModelFactory.Build(species), 
                    GenusPanelViewModel = genusPanel
                };

            return viewModel;
        }
    }
}