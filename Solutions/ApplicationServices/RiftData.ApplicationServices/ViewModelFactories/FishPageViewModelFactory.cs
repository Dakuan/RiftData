using RiftData.ApplicationServices.DtoServices.Contracts;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts;
using RiftData.Presentation.ViewModels;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    public class FishPageViewModelFactory : IFishPageViewModelFactory
    {
        private readonly IFishRepository fishRepository;
        private readonly IPhotoGalleryViewModelFactory photoGalleryViewModelFactory;
        private readonly IDtoFactory dtoFactory;
        private readonly IGenusPanelViewModelFactory genusPanelViewModelFactory;
        private readonly IGenusTypeDtoService genusTypeDtoService;

        public FishPageViewModelFactory(IFishRepository fishRepository, IPhotoGalleryViewModelFactory photoGalleryViewModelFactory, IDtoFactory dtoFactory, IGenusPanelViewModelFactory genusPanelViewModelFactory, IGenusTypeDtoService genusTypeDtoService)
        {
            this.fishRepository = fishRepository;
            this.photoGalleryViewModelFactory = photoGalleryViewModelFactory;
            this.dtoFactory = dtoFactory;
            this.genusPanelViewModelFactory = genusPanelViewModelFactory;
            this.genusTypeDtoService = genusTypeDtoService;
        }

        public FishPageViewModel Build(string fishName)
        {
            var fish = this.fishRepository.GetFishFromName(fishName);

            var viewModel = new FishPageViewModel
                                {
                                    Fish = this.dtoFactory.Build(fish),
                                    PhotoGalleryViewModel = this.photoGalleryViewModelFactory.Build(fish),
                                    GenusPanelViewModel = this.genusPanelViewModelFactory.Build(fish.Genus.GenusType.Id, fish.Genus.Id, fish.Species.Id),
                                    GenusTypes = this.genusTypeDtoService.GetAllGenusTypes()
                                };

            return viewModel;
        }
    }
}