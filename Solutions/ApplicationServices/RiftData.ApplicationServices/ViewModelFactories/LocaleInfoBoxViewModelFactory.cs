namespace RiftData.ApplicationServices.ViewModelFactories
{
    using System.Linq;

    using RiftData.ApplicationServices.DtoServices.Contracts;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts;
    using RiftData.Presentation.ViewModels;

    public class LocaleInfoBoxViewModelFactory : ILocaleInfoBoxViewModelFactory
    {
        private readonly ILocalesRepository localesRepository;

        private readonly ISpeciesDtoService speciesDtoService;

        public LocaleInfoBoxViewModelFactory(ILocalesRepository localesRepository, ISpeciesDtoService speciesDtoService)
        {
            this.localesRepository = localesRepository;
            this.speciesDtoService = speciesDtoService;
        }

        public LocaleInfoBoxViewModel Build(int localeId)
        {
            var locale = this.localesRepository.Get(localeId);

            var viewModel = new LocaleInfoBoxViewModel { Name = locale.Name, Species = this.speciesDtoService.GetSpeciesAtLocale(localeId).ToList() };

            return viewModel;
        }
    }
}