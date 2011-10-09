using RiftData.ApplicationServices.Extensions;
using RiftData.Domain.Extensions;
using RiftData.Presentation.Contracts.ViewModelFactories.Admin;
using RiftData.Presentation.ViewModels.Admin.Locale;
using RiftData.Presentation.ViewModels.Admin.Shared;

namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.ViewModels.Admin;

    public class LocaleIndexPageViewModelFactory : ILocaleIndexPageViewModelFactory
    {
        private readonly ILocalesRepository localesRepository;
        private readonly INavigationViewModelFactory navigationViewModelFactory;

        public LocaleIndexPageViewModelFactory(ILocalesRepository localesRepository, INavigationViewModelFactory navigationViewModelFactory)
        {
            this.localesRepository = localesRepository;
            this.navigationViewModelFactory = navigationViewModelFactory;
        }

        public LocalePageViewModel Build()
        {
            var locales = this.localesRepository.GetAll();

            var viewModel = new LocalePageViewModel { NavigationViewModel = this.navigationViewModelFactory.Build(SelectedView.Locales), Locales = locales.ToDtoList(), LocalesSelectList = locales.ToSelectList("select a locale") };

            return viewModel;
        }
    }
}