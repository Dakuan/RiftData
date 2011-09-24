using RiftData.ApplicationServices.Extensions;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    using System.Linq;

    using RiftData.Domain.Entities;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts;
    using RiftData.Presentation.ViewModels;

    public class SpeciesPageViewModelFactory : ISpeciesPageViewModelFactory
    {
        private readonly IGenusPanelViewModelFactory genusPanelViewModelFactory;

        private readonly IHeaderViewModelFactory headerViewModelFactory;


        private readonly IPhotoGalleryViewModelFactory photoGalleryViewModelFactory;

        private readonly ILocalesRepository localesRepository;
        private readonly IFishRepository fishRepository;
        private readonly ISpeciesRepository speciesRepository;

        public SpeciesPageViewModelFactory(ILocalesRepository localesRepository, IFishRepository fishRepository, ISpeciesRepository speciesRepository, IGenusPanelViewModelFactory genusPanelViewModelFactory, IPhotoGalleryViewModelFactory photoGalleryViewModelFactory, IHeaderViewModelFactory headerViewModelFactory)
        {
            this.localesRepository = localesRepository;
            this.fishRepository = fishRepository;
            this.speciesRepository = speciesRepository;
            this.genusPanelViewModelFactory = genusPanelViewModelFactory;
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

            var viewModel = new SpeciesPageViewModel { Species = DtoFactory.Build(species), Fish = this.fishRepository.GetBySpecies(species.Id).ToDtoList(), HeaderViewModel = headerViewModel, Locales = this.localesRepository.GetWithSpecies(species.Id).ToDtoList(), PhotoGalleryViewModel = this.photoGalleryViewModelFactory.Build(species), GenusPanelViewModel = genusPanel, Description = string.Format("Profile, photos and map for {0}", species.FullName), Keywords = "Lake " + species.Genus.GenusType.Lake.Name + ", " + species.Genus.Name + ", " + string.Join(", ", species.Genus.Species.Select(x => x.Name)) };

            return viewModel;
        }
    }
}