namespace RiftData.ApplicationServices.ViewModelFactories
{
    using RiftData.ApplicationServices.DtoServices.Contracts;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts;
    using RiftData.Presentation.ViewModels;

    public class LocaleInfoBoxViewModelFactory : ILocaleInfoBoxViewModelFactory
    {
        private readonly ILocalesRepository _localesRepository;

        private readonly ISpeciesDtoService _speciesDtoService;

        public LocaleInfoBoxViewModelFactory(ILocalesRepository localesRepository, ISpeciesDtoService speciesDtoService)
        {
            this._localesRepository = localesRepository;
            this._speciesDtoService = speciesDtoService;
        }

        public LocaleInfoBoxViewModel Build(int localeId)
        {
            var locale = this._localesRepository.Get(localeId);

            var viewModel = new LocaleInfoBoxViewModel
                {
                   Name = locale.Name, Species = this._speciesDtoService.GetSpeciesAtLocale(localeId) 
                };

            return viewModel;
        }
    }
}