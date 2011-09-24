using RiftData.ApplicationServices.Extensions;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    using System.Collections.Generic;

    using RiftData.Domain.Entities;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts;
    using RiftData.Presentation.ViewModels;
    using RiftData.Presentation.ViewModels.Dto;

    public class HeaderViewModelFactory : IHeaderViewModelFactory
    {
        private readonly IGenusTypeRepository genusTypeRepository;

        private readonly ILakeRepository lakeRepository;

        public HeaderViewModelFactory(ILakeRepository lakeRepository, IGenusTypeRepository genusTypeRepository)
        {
            this.lakeRepository = lakeRepository;
            this.genusTypeRepository = genusTypeRepository;
        }

        public HeaderViewModel Build()
        {
            var viewModel = new HeaderViewModel { Lakes = this.lakeRepository.GetAll().ToDtoList(), GenusTypes = new List<GenusTypeDto>() };

            return viewModel;
        }

        public HeaderViewModel Build(int lakeId, int genusTypeId)
        {
            var viewModel = this.Build();

            viewModel.GenusTypes = this.genusTypeRepository.GetFromLake(lakeId).ToDtoList();

            viewModel.SelectedLakeId = lakeId;

            viewModel.SelectedGenusTypeId = genusTypeId;

            return viewModel;
        }

        public HeaderViewModel Build(Locale locale)
        {
            var viewModel = new HeaderViewModel { Lakes = this.lakeRepository.GetAll().ToDtoList(), SelectedLakeId = locale.Lake.Id, GenusTypes = this.genusTypeRepository.GetFromLocale(locale.Id).ToDtoList() };

            return viewModel;
        }

        public HeaderViewModel Build(Fish fish)
        {
            var viewModel = new HeaderViewModel { Lakes = this.lakeRepository.GetAll().ToDtoList(), SelectedGenusTypeId = fish.Genus.GenusType.Id, SelectedLakeId = fish.Locale.Lake.Id, GenusTypes = this.genusTypeRepository.GetFromLocale(fish.Locale.Id).ToDtoList() };

            return viewModel;
        }

        public HeaderViewModel Build(GenusType genusType)
        {
            var viewModel = new HeaderViewModel { SelectedGenusTypeId = genusType.Id, SelectedLakeId = genusType.Lake.Id, GenusTypes = this.genusTypeRepository.GetFromLake(genusType.Lake.Id).ToDtoList(), Lakes = this.lakeRepository.GetAll().ToDtoList() };

            return viewModel;
        }

        public HeaderViewModel Build(Lake lake)
        {
            var viewModel = this.Build();

            viewModel.SelectedLakeId = lake.Id;

            viewModel.GenusTypes = lake.GenusTypes.ToDtoList();

            return viewModel;
        }

        public HeaderViewModel BuildFromSpecies(int speciesId)
        {
            var lake = this.lakeRepository.GetLakeFromSpeciesId(speciesId);

            var genusType = this.genusTypeRepository.GetFromSpecies(speciesId);

            return this.Build(lake.Id, genusType.Id);
        }
    }
}