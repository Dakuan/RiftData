namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using RiftData.ApplicationServices.DtoServices.Extensions;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts.Admin.LocalePages;
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

            var viewModel = new LocalePageViewModel
                {
                   Locales = locales.ToDtoList(), LocalesSelectList = locales.ToSelectList("select a locale") 
                };

            return viewModel;
        }
    }
}