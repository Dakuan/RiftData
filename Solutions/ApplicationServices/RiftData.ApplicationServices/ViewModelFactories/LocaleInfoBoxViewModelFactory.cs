using RiftData.ApplicationServices.Extensions;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts;
    using RiftData.Presentation.ViewModels;

    public class LocaleInfoBoxViewModelFactory : ILocaleInfoBoxViewModelFactory
    {
        private readonly ILocalesRepository localesRepository;

        private readonly ISpeciesRepository speciesRepository;

        public LocaleInfoBoxViewModelFactory(ILocalesRepository localesRepository, ISpeciesRepository speciesRepository)
        {
            this.localesRepository = localesRepository;
            this.speciesRepository = speciesRepository;
        }

        public LocaleInfoBoxViewModel Build(int localeId)
        {
            var locale = this.localesRepository.Get(localeId);

            var viewModel = new LocaleInfoBoxViewModel { Name = locale.Name, Species = this.speciesRepository.GetSpeciesAtLocale(locale.Id).ToDtoList() };

            return viewModel;
        }
    }
}