namespace RiftData.ApplicationServices.ViewModelFactories
{
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts;
    using RiftData.Presentation.ViewModels;

    public class FishPageViewModelFactory : IFishPageViewModelFactory
    {
        private readonly IGenusPanelViewModelFactory _genusPanelViewModelFactory;

        private readonly IHeaderViewModelFactory _headerViewModelFactory;

        private readonly IFishRepository fishRepository;

        private readonly IPhotoGalleryViewModelFactory photoGalleryViewModelFactory;

        public FishPageViewModelFactory(
            IGenusPanelViewModelFactory genusPanelViewModelFactory, 
            IFishRepository fishRepository, 
            IPhotoGalleryViewModelFactory photoGalleryViewModelFactory, 
            IHeaderViewModelFactory headerViewModelFactory)
        {
            this._genusPanelViewModelFactory = genusPanelViewModelFactory;
            this.fishRepository = fishRepository;
            this.photoGalleryViewModelFactory = photoGalleryViewModelFactory;
            this._headerViewModelFactory = headerViewModelFactory;
        }

        public FishPageViewModel Build(string fishName)
        {
            var fish = this.fishRepository.GetFromName(fishName);

            var viewModel = new FishPageViewModel
                {
                    Fish = DtoFactory.Build(fish), 
                    PhotoGalleryViewModel = this.photoGalleryViewModelFactory.Build(fish), 
                    HeaderViewModel = this._headerViewModelFactory.Build(fish), 
                    GenusPanelViewModel = this._genusPanelViewModelFactory.Build(fish.Genus.GenusType.Id)
                };

            return viewModel;
        }
    }
}