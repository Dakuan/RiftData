namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts.Admin.LocalePages;
    using RiftData.Presentation.ViewModels.Admin;

    public class LocaleUpdatePageViewModelFactory : ILocaleUpdatePageViewModelFactory
    {
        private readonly ILocalesRepository localesRepository;

        public LocaleUpdatePageViewModelFactory(ILocalesRepository localesRepository)
        {
            this.localesRepository = localesRepository;
        }

        public LocaleUpdatePageViewModel Build(int localeId)
        {
            var locale = this.localesRepository.Get(localeId);

            var viewModel = new LocaleUpdatePageViewModel { Latitude = locale.Latitude, Longitude = locale.Longitude, Name = locale.Name, ZoomLevel = locale.ZoomLevel };

            return viewModel;
        }
    }
}