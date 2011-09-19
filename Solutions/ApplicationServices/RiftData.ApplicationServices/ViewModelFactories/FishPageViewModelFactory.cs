namespace RiftData.ApplicationServices.ViewModelFactories
{
    using System.Linq;

    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts;
    using RiftData.Presentation.ViewModels;

    public class FishPageViewModelFactory : IFishPageViewModelFactory
    {
        private readonly IGenusPanelViewModelFactory genusPanelViewModelFactory;

        private readonly IHeaderViewModelFactory headerViewModelFactory;

        private readonly IFishRepository fishRepository;

        private readonly IPhotoGalleryViewModelFactory photoGalleryViewModelFactory;

        public FishPageViewModelFactory(
            IGenusPanelViewModelFactory genusPanelViewModelFactory, 
            IFishRepository fishRepository, 
            IPhotoGalleryViewModelFactory photoGalleryViewModelFactory, 
            IHeaderViewModelFactory headerViewModelFactory)
        {
            this.genusPanelViewModelFactory = genusPanelViewModelFactory;
            this.fishRepository = fishRepository;
            this.photoGalleryViewModelFactory = photoGalleryViewModelFactory;
            this.headerViewModelFactory = headerViewModelFactory;
        }

        public FishPageViewModel Build(string fishName)
        {
            var fish = this.fishRepository.GetFromName(fishName);

            var viewModel = new FishPageViewModel
                {
                    Fish = DtoFactory.Build(fish), 
                    PhotoGalleryViewModel = this.photoGalleryViewModelFactory.Build(fish), 
                    HeaderViewModel = this.headerViewModelFactory.Build(fish), 
                    GenusPanelViewModel = this.genusPanelViewModelFactory.Build(fish.Genus.GenusType.Id),
                    Description = string.Format("Profile for {0}", fish.Name),
                    Keywords = "Lake " + fish.Genus.GenusType.Lake.Name + ", " + fish.Genus.GenusType.Name  + ", " + fish.Genus.Name + ", " + string.Join(", ", fish.Genus.Species.Select(x => x.Name))
                };

            return viewModel;
        }
    }
}