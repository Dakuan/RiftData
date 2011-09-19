﻿using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts;
using RiftData.Presentation.ViewModels;
using RiftData.ApplicationServices.DtoServices.Contracts;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    public class LocalePageViewModelFactory : ILocalePageViewModelFactory
    {
        private readonly IGenusPanelViewModelFactory _genusPanelViewModelFactory;
        private readonly ILocalesRepository _localesRepository;
        private readonly IHeaderViewModelFactory _headerViewModelFactory;
        private readonly IFishDtoService _fishDtoService;
        private readonly IPhotoGalleryViewModelFactory _photoGalleryViewModelFactory;

        public LocalePageViewModelFactory(IGenusPanelViewModelFactory genusPanelViewModelFactory, ILocalesRepository localesRepository, IHeaderViewModelFactory headerViewModelFactory, IFishDtoService fishDtoService, IPhotoGalleryViewModelFactory photoGalleryViewModelFactory)
        {
            _genusPanelViewModelFactory = genusPanelViewModelFactory;
            _localesRepository = localesRepository;
            _headerViewModelFactory = headerViewModelFactory;
            _fishDtoService = fishDtoService;
            _photoGalleryViewModelFactory = photoGalleryViewModelFactory;
        }

        public LocalePageViewModel Build(string fullName)
        {
            var locale = this._localesRepository.GetByFullName(fullName);

            var headerViewModel = this._headerViewModelFactory.Build(locale);

            var viewModel = new LocalePageViewModel
                                {
                                    Locale = DtoFactory.Build(locale),
                                    Fish = this._fishDtoService.GetFishAtLocale(locale.Id),
                                    HeaderViewModel = headerViewModel,
                                    PhotoGallery = this._photoGalleryViewModelFactory.Build(locale),
                                    GenusPanelViewModel = this._genusPanelViewModelFactory.Build(1)
                                };

            return viewModel;
        }
    }
}