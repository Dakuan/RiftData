using RiftData.Presentation.Contracts.ViewModelFactories.Admin;
using RiftData.Presentation.ViewModels.Admin.Locale;
using RiftData.Presentation.ViewModels.Admin.Shared;

namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.ViewModels.Admin;

    public class LocaleUpdatePageViewModelFactory : ILocaleUpdatePageViewModelFactory
    {
        private readonly ILocalesRepository localesRepository;
        private readonly INavigationViewModelFactory navigationViewModelFactory;

        public LocaleUpdatePageViewModelFactory(ILocalesRepository localesRepository, INavigationViewModelFactory navigationViewModelFactory)
        {
            this.localesRepository = localesRepository;
            this.navigationViewModelFactory = navigationViewModelFactory;
        }

        public LocaleUpdatePageViewModel Build(int localeId)
        {
            var locale = this.localesRepository.Get(localeId);

            var viewModel = new LocaleUpdatePageViewModel { NavigationViewModel = this.navigationViewModelFactory.Build(SelectedView.Locales), Latitude = locale.Latitude, Longitude = locale.Longitude, Name = locale.Name, ZoomLevel = locale.ZoomLevel };

            return viewModel;
        }
    }
}