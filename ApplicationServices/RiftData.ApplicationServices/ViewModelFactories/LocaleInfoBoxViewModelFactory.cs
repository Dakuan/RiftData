using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using RiftData.Domain.Entities;
using RiftData.Domain.Repositories;
using RiftData.Shared.ViewModels;
using RiftData.Shared.ViewModels.Dto;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    public class LocaleInfoBoxViewModelFactory : ILocaleInfoBoxViewModelFactory
    {
        private readonly IDtoFactory _dtoFactory;
        private readonly ISpeciesRepository _speciesRepository;
        private readonly ILocalesRepository _localesRepository;

        public LocaleInfoBoxViewModelFactory(IDtoFactory dtoFactory, ISpeciesRepository speciesRepository, ILocalesRepository localesRepository)
        {
            _dtoFactory = dtoFactory;
            _speciesRepository = speciesRepository;
            _localesRepository = localesRepository;
        }

        public LocaleInfoBoxViewModel Build(int localeId)
        {
            var locale = this._localesRepository.GetById(localeId);

            var species = this._speciesRepository.GetSpeciesAtLocale(locale.Id);

            var speciesDtoList = new List<SpeciesDto>();

            species.ToList().ForEach(s => speciesDtoList.Add(this._dtoFactory.Build(s)));

            var viewModel = new LocaleInfoBoxViewModel
                                {
                                    Name = locale.Name,
                                    Species = speciesDtoList
                                };

            return viewModel;
        }
    }
}