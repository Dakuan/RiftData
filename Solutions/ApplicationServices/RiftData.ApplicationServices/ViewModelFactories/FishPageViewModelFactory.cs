namespace RiftData.ApplicationServices.ViewModelFactories
{
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts;
    using RiftData.Presentation.ViewModels;

    public class FishPageViewModelFactory : IFishPageViewModelFactory
    {
        private readonly IGenusPanelViewModelFactory _genusPanelViewModelFactory;

        private readonly IHeaderViewModelFactory _headerViewModelFactory;

        private readonly IDtoFactory dtoFactory;

        private readonly IFishRepository fishRepository;

        private readonly IPhotoGalleryViewModelFactory photoGalleryViewModelFactory;

        public FishPageViewModelFactory(IGenusPanelViewModelFactory genusPanelViewModelFactory, IFishRepository fishRepository, IPhotoGalleryViewModelFactory photoGalleryViewModelFactory, IDtoFactory dtoFactory, IHeaderViewModelFactory headerViewModelFactory)
        {
            _genusPanelViewModelFactory = genusPanelViewModelFactory;
            this.fishRepository = fishRepository;
            this.photoGalleryViewModelFactory = photoGalleryViewModelFactory;
            this.dtoFactory = dtoFactory;
            _headerViewModelFactory = headerViewModelFactory;
        }

        public FishPageViewModel Build(string fishName)
        {
            var fish = fishRepository.GetFishFromName(fishName);

            var viewModel = new FishPageViewModel
                                {
                                    Fish = dtoFactory.Build(fish), 
                                    PhotoGalleryViewModel = photoGalleryViewModelFactory.Build(fish), 
                                    HeaderViewModel = _headerViewModelFactory.Build(fish), 
                                    GenusPanelViewModel = _genusPanelViewModelFactory.Build(fish.Genus.GenusType.Id)
                                };

            return viewModel;
        }
    }
}