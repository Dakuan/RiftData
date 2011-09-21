namespace RiftData.ApplicationServices.ViewModelFactories
{
    using System.Linq;

    using RiftData.ApplicationServices.DtoServices.Contracts;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts;
    using RiftData.Presentation.ViewModels;

    public class LocalePageViewModelFactory : ILocalePageViewModelFactory
    {
        private readonly IFishDtoService fishDtoService;

        private readonly IGenusPanelViewModelFactory genusPanelViewModelFactory;

        private readonly IHeaderViewModelFactory headerViewModelFactory;

        private readonly ILocalesRepository localesRepository;

        private readonly IPhotoGalleryViewModelFactory photoGalleryViewModelFactory;

        public LocalePageViewModelFactory(IGenusPanelViewModelFactory genusPanelViewModelFactory, ILocalesRepository localesRepository, IHeaderViewModelFactory headerViewModelFactory, IFishDtoService fishDtoService, IPhotoGalleryViewModelFactory photoGalleryViewModelFactory)
        {
            this.genusPanelViewModelFactory = genusPanelViewModelFactory;
            this.localesRepository = localesRepository;
            this.headerViewModelFactory = headerViewModelFactory;
            this.fishDtoService = fishDtoService;
            this.photoGalleryViewModelFactory = photoGalleryViewModelFactory;
        }

        public LocalePageViewModel Build(string fullName)
        {
            var locale = this.localesRepository.GetByFullName(fullName);

            var headerViewModel = this.headerViewModelFactory.Build(locale);

            var fish = this.fishDtoService.GetFishAtLocale(locale.Id);

            var viewModel = new LocalePageViewModel { Locale = DtoFactory.Build(locale), Fish = fish, HeaderViewModel = headerViewModel, PhotoGallery = this.photoGalleryViewModelFactory.Build(locale), GenusPanelViewModel = this.genusPanelViewModelFactory.Build(1), Description = string.Format("Information and map for {0}, Lake {1}", locale.Name, locale.Lake.Name), Keywords = string.Format("Lake {0}, {1}", locale.Lake.Name, string.Join(", ", fish.Select(x => x.Name))) };

            return viewModel;
        }
    }
}