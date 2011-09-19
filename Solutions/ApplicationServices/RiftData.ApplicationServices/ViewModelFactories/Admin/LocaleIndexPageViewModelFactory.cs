namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using RiftData.ApplicationServices.DtoServices.Extensions;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts.Admin;
    using RiftData.Presentation.ViewModels.Admin;

    public class LocaleIndexPageViewModelFactory : ILocaleIndexPageViewModelFactory
    {
        private readonly ILocalesRepository _localesRepository;

        public LocaleIndexPageViewModelFactory(ILocalesRepository localesRepository)
        {
            this._localesRepository = localesRepository;
        }

        public LocalePageViewModel Build()
        {
            var locales = this._localesRepository.GetAll();

            var viewModel = new LocalePageViewModel
                {
                   Locales = locales.ToDtoList(), LocalesSelectList = locales.ToSelectList("select a locale") 
                };

            return viewModel;
        }
    }
}