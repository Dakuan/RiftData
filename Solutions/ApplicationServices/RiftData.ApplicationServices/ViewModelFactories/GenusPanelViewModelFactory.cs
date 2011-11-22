using RiftData.ApplicationServices.Extensions;
using RiftData.Domain.Extensions;
using RiftData.Domain.Repositories;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    using System.Collections.Generic;
    using System.Linq;

    using Castle.Components.DictionaryAdapter;

    using RiftData.Domain.Entities;
    using RiftData.Presentation.Contracts;
    using RiftData.Presentation.Contracts.ViewModelFactories;
    using RiftData.Presentation.ViewModels;
    using RiftData.Presentation.ViewModels.Dto;

    public class GenusPanelViewModelFactory : IGenusPanelViewModelFactory
    {
        private readonly IGenusRepository genusRepository;

        private readonly IGenusTypeRepository genusTypeRepository;

        public GenusPanelViewModelFactory(IGenusRepository genusRepository, IGenusTypeRepository genusTypeRepository)
        {
            this.genusRepository = genusRepository;
            this.genusTypeRepository = genusTypeRepository;
        }

        public GenusPanelViewModel Build(int genusTypeId)
        {
            var genusType = this.genusTypeRepository.Get(genusTypeId);
            return new GenusPanelViewModel { GenusList = this.genusRepository.GetOfType(genusTypeId).ToDtoList(), LakeId = genusType.Lake.Id};
        }

        public GenusPanelViewModel Build(int genusTypeId, int selectedGenusId, int selectedSpecies)
        {
            var viewModel = this.Build(genusTypeId);

            viewModel.ExpandedGenus = selectedGenusId;

            viewModel.SelectedSpecies = selectedSpecies;

            var genusType = this.genusTypeRepository.Get(genusTypeId);

            viewModel.LakeId = genusType.Lake.Id;

            return viewModel;
        }

        public GenusPanelViewModel Build(Lake lake)
        {
            var genusType = this.genusTypeRepository.GetFromLake(lake.Id).FirstOrDefault();

            if (genusType != null)
            {
                return this.Build(genusType.Id);
            }
            return new GenusPanelViewModel { GenusList = new List<GenusDto>(), LakeId = lake.Id };
        }
    }
}