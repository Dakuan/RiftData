using RiftData.ApplicationServices.DtoServices.Contracts;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts;
using RiftData.Presentation.ViewModels;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    public class FishPageViewModelFactory : IFishPageViewModelFactory
    {
        private readonly IGenusPanelViewModelFactory _genusPanelViewModelFactory;
        private readonly IFishRepository fishRepository;
        private readonly IPhotoGalleryViewModelFactory photoGalleryViewModelFactory;
        private readonly IDtoFactory dtoFactory;
        private readonly IHeaderViewModelFactory _headerViewModelFactory;

        public FishPageViewModelFactory(IGenusPanelViewModelFactory genusPanelViewModelFactory, IFishRepository fishRepository, IPhotoGalleryViewModelFactory photoGalleryViewModelFactory, IDtoFactory dtoFactory,  IHeaderViewModelFactory headerViewModelFactory)
        {
            _genusPanelViewModelFactory = genusPanelViewModelFactory;
            this.fishRepository = fishRepository;
            this.photoGalleryViewModelFactory = photoGalleryViewModelFactory;
            this.dtoFactory = dtoFactory;
            _headerViewModelFactory = headerViewModelFactory;
        }

        public FishPageViewModel Build(string fishName)
        {
            var fish = this.fishRepository.GetFishFromName(fishName);

            var viewModel = new FishPageViewModel
                                {
                                    Fish = this.dtoFactory.Build(fish),
                                    PhotoGalleryViewModel = this.photoGalleryViewModelFactory.Build(fish),
                                    HeaderViewModel = this._headerViewModelFactory.Build(fish),
                                    GenusPanelViewModel = this._genusPanelViewModelFactory.Build(fish.Genus.GenusType.Id)
                                };

            return viewModel;
        }
    }
}