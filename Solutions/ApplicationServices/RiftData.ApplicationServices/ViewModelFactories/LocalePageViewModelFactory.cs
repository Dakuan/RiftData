using RiftData.ApplicationServices.Extensions;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    using System.Linq;

    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts;
    using RiftData.Presentation.Contracts.ViewModelFactories;
    using RiftData.Presentation.ViewModels;

    public class LocalePageViewModelFactory : ILocalePageViewModelFactory
    {
        private readonly IFishRepository fishRepository;
        private readonly IGenusPanelViewModelFactory genusPanelViewModelFactory;

        private readonly IHeaderViewModelFactory headerViewModelFactory;

        private readonly ILocalesRepository localesRepository;

        private readonly IPhotoGalleryViewModelFactory photoGalleryViewModelFactory;

        public LocalePageViewModelFactory(IFishRepository fishRepository, IGenusPanelViewModelFactory genusPanelViewModelFactory, ILocalesRepository localesRepository, IHeaderViewModelFactory headerViewModelFactory, IPhotoGalleryViewModelFactory photoGalleryViewModelFactory)
        {
            this.fishRepository = fishRepository;
            this.genusPanelViewModelFactory = genusPanelViewModelFactory;
            this.localesRepository = localesRepository;
            this.headerViewModelFactory = headerViewModelFactory;
            this.photoGalleryViewModelFactory = photoGalleryViewModelFactory;
        }

        public LocalePageViewModel Build(string fullName)
        {
            var locale = this.localesRepository.GetByFullName(fullName);

            var headerViewModel = this.headerViewModelFactory.Build(locale);

            var fish = this.fishRepository.GetByLocale(locale.Id).ToDtoList();

            var viewModel = new LocalePageViewModel 
                { 
                    Locale = DtoFactory.Build(locale), 
                    Fish = fish, 
                    HeaderViewModel = headerViewModel, 
                    PhotoGallery = this.photoGalleryViewModelFactory.Build(locale), 
                    GenusPanelViewModel = this.genusPanelViewModelFactory.Build(locale.Lake), 
                    Description = string.Format("Information and map for {0}, Lake {1}", locale.Name, locale.Lake.Name), 
                    Keywords = string.Format("Lake {0}, {1}", locale.Lake.Name, string.Join(", ", fish.Select(x => x.Name)))
                    
                };

            return viewModel;
        }
    }
}