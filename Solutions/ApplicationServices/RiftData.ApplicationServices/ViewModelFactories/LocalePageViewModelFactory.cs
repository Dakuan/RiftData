using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts;
using RiftData.Presentation.ViewModels;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    public class LocalePageViewModelFactory : ILocalePageViewModelFactory
    {
        private readonly ILocalesRepository _localesRepository;
        private readonly IDtoFactory _dtoFactory;
        private readonly IFishRepository _fishRepository;
        private readonly IGenusPanelViewModelFactory _genusPanelViewModelFactory;
        private readonly IGenusTypeRepository _genusTypeRepository;

        public LocalePageViewModelFactory(ILocalesRepository localesRepository, IDtoFactory dtoFactory, IFishRepository fishRepository, IGenusPanelViewModelFactory genusPanelViewModelFactory, IGenusTypeRepository genusTypeRepository)
        {
            _localesRepository = localesRepository;
            _dtoFactory = dtoFactory;
            _fishRepository = fishRepository;
            _genusPanelViewModelFactory = genusPanelViewModelFactory;
            _genusTypeRepository = genusTypeRepository;
        }

        public LocalePageViewModel Build(string fullName)
        {
            var locale = this._localesRepository.GetByFullName(fullName);

            var fish = new List<FishDto>();

            this._fishRepository.GetFishByLocale(locale.Id).ToList().ForEach(f => fish.Add(this._dtoFactory.Build(f)));

            var genusPanelViewModel = this._genusPanelViewModelFactory.Build();

            var genusTypes = new List<GenusTypeDto>();
                
            this._genusTypeRepository.GetAll().ToList().ForEach(g => genusTypes.Add(this._dtoFactory.Build(g)));

            var viewModel = new LocalePageViewModel
                                {
                                    Locale = this._dtoFactory.Build(locale),
                                    Fish = fish,
                                    GenusPanelViewModel = genusPanelViewModel,
                                    GenusTypes = genusTypes
                                };

            return viewModel;
        }
    }
}
