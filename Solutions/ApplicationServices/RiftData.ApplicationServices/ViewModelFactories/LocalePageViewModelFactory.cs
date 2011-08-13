using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts;
using RiftData.Presentation.ViewModels;
using RiftData.ApplicationServices.DtoServices.Contracts;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    public class LocalePageViewModelFactory : ILocalePageViewModelFactory
    {
        private readonly IGenusTypeDtoService _genusTypeDtoService;
        private readonly ILocalesRepository _localesRepository;
        private readonly IDtoFactory _dtoFactory;
        private readonly IGenusPanelViewModelFactory _genusPanelViewModelFactory;
        private readonly IFishDtoService _fishDtoService;
        private readonly IPhotoGalleryViewModelFactory _photoGalleryViewModelFactory;

        public LocalePageViewModelFactory(IGenusTypeDtoService genusTypeDtoService, ILocalesRepository localesRepository, IDtoFactory dtoFactory, IGenusPanelViewModelFactory genusPanelViewModelFactory, IFishDtoService fishDtoService, IPhotoGalleryViewModelFactory photoGalleryViewModelFactory)
        {
            _genusTypeDtoService = genusTypeDtoService;
            _localesRepository = localesRepository;
            _dtoFactory = dtoFactory;
            _genusPanelViewModelFactory = genusPanelViewModelFactory;
            _fishDtoService = fishDtoService;
            _photoGalleryViewModelFactory = photoGalleryViewModelFactory;
        }

        public LocalePageViewModel Build(string fullName)
        {
            var locale = this._localesRepository.GetByFullName(fullName);

            var genusPanelViewModel = this._genusPanelViewModelFactory.Build();

            var viewModel = new LocalePageViewModel
                                {
                                    Locale = this._dtoFactory.Build(locale),
                                    Fish = this._fishDtoService.GetFishAtLocale(locale.Id),
                                    GenusPanelViewModel = genusPanelViewModel,
                                    GenusTypes = this._genusTypeDtoService.GetAllGenusTypes(),
                                    SelectedGenusTypeId = 1,
                                    PhotoGallery = this._photoGalleryViewModelFactory.Build(locale)
                                };

            return viewModel;
        }
    }
}