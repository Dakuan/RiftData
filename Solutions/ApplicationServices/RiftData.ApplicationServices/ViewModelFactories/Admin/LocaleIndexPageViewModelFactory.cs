using RiftData.ApplicationServices.Extensions;
using RiftData.Domain.Extensions;
using RiftData.Presentation.Contracts.ViewModelFactories.Admin;
using RiftData.Presentation.ViewModels.Admin.Locale;

namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.ViewModels.Admin;

    public class LocaleIndexPageViewModelFactory : ILocaleIndexPageViewModelFactory
    {
        private readonly ILocalesRepository localesRepository;

        public LocaleIndexPageViewModelFactory(ILocalesRepository localesRepository)
        {
            this.localesRepository = localesRepository;
        }

        public LocalePageViewModel Build()
        {
            var locales = this.localesRepository.GetAll();

            var viewModel = new LocalePageViewModel { Locales = locales.ToDtoList(), LocalesSelectList = locales.ToSelectList("select a locale") };

            return viewModel;
        }
    }
}