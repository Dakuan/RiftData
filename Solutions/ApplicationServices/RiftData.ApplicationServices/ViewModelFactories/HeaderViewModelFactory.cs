﻿using System.Collections.Generic;
using RiftData.Domain.Entities;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    using DtoServices.Contracts;
    using Presentation.ViewModels;

    public class HeaderViewModelFactory : IHeaderViewModelFactory
    {
        private readonly ILakeDtoService _lakeDtoService;
        private readonly ILakeRepository _lakeRepository;
        private readonly IGenusTypeRepository _genusTypeRepository;
        private readonly IGenusTypeDtoService _genusTypeDtoService;

        public HeaderViewModelFactory(ILakeDtoService lakeDtoService, ILakeRepository lakeRepository, IGenusTypeRepository genusTypeRepository, IGenusTypeDtoService genusTypeDtoService)
        {
            _lakeDtoService = lakeDtoService;
            _lakeRepository = lakeRepository;
            _genusTypeRepository = genusTypeRepository;
            _genusTypeDtoService = genusTypeDtoService;
        }

        public HeaderViewModel Build()
        {
            var viewModel = new HeaderViewModel
                                {
                                    Lakes = _lakeDtoService.GetAllLakes(),
                                    GenusTypes = new List<GenusTypeDto>()
                                };

            return viewModel;
        }

        public HeaderViewModel Build(int lakeId, int genusTypeId)
        {
            var viewModel = this.Build();

            var lake = this._lakeRepository.GetFromGenusType(genusTypeId);

            viewModel.GenusTypes = this._genusTypeDtoService.GetGenusTypesFromLake(lake);

            viewModel.SelectedLakeId = lakeId;

            viewModel.SelectedGenusTypeId = genusTypeId;

            return viewModel;
        }

        public HeaderViewModel BuildFromSpecies(int speciesId)
        {
            var lake = this._lakeRepository.GetLakeFromSpeciesId(speciesId);

            var genusType = this._genusTypeRepository.GetFromSpecies(speciesId);

            return this.Build(lake.Id, genusType.Id);
        }

        public HeaderViewModel Build(Locale locale)
        {
            var viewModel = new HeaderViewModel
                                {
                                    Lakes = this._lakeDtoService.GetAllLakes(),
                                    SelectedLakeId = locale.Lake.Id,
                                    GenusTypes = this._genusTypeDtoService.GetGenusTypesFromLocale(locale)
                                };

            return viewModel;
        }

        public HeaderViewModel Build(Fish fish)
        {
            var viewModel = new HeaderViewModel
                                {
                                    Lakes = this._lakeDtoService.GetAllLakes(),
                                    SelectedGenusTypeId = fish.Genus.GenusType.Id,
                                    SelectedLakeId = fish.Locale.Lake.Id,
                                    GenusTypes = this._genusTypeDtoService.GetGenusTypesFromLocale(fish.Locale)
                                };

            return viewModel;
        }

        public HeaderViewModel Build(GenusType genusType)
        {
            var viewModel = new HeaderViewModel
                                {
                                    SelectedGenusTypeId = genusType.Id,
                                    SelectedLakeId = genusType.Lake.Id,
                                    GenusTypes = this._genusTypeDtoService.GetGenusTypesFromLake(genusType.Lake),
                                    Lakes = this._lakeDtoService.GetAllLakes()
                                };

            return viewModel;
        }

        public HeaderViewModel Build(LakeDto lake)
        {
            var viewModel = this.Build();

            viewModel.SelectedLakeId = lake.Id;

            viewModel.GenusTypes = lake.GenusTypes;

            return viewModel;
        }
    }
}