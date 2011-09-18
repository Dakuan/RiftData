using RiftData.ApplicationServices.DtoServices.Contracts;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts;
using RiftData.Presentation.ViewModels;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    public class LocaleInfoBoxViewModelFactory : ILocaleInfoBoxViewModelFactory
    {
        private readonly ILocalesRepository _localesRepository;
        private readonly ISpeciesDtoService _speciesDtoService;

        public LocaleInfoBoxViewModelFactory(ILocalesRepository localesRepository, ISpeciesDtoService speciesDtoService)
        {
            _localesRepository = localesRepository;
            _speciesDtoService = speciesDtoService;
        }

        public LocaleInfoBoxViewModel Build(int localeId)
        {
            var locale = this._localesRepository.Get(localeId);

            var viewModel = new LocaleInfoBoxViewModel
                                {
                                    Name = locale.Name,
                                    Species = _speciesDtoService.GetSpeciesAtLocale(localeId)
                                };

            return viewModel;
        }
    }
}