using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using RiftData.Shared.ViewModels;
using RiftData.Domain.Repositories;
using RiftData.Domain.Entities;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    public class GenusPanelViewModelFactory : IGenusPanelViewModelFactory
    {
        private IGenusRepository genusRepository;

        public GenusPanelViewModelFactory(IGenusRepository genusRepository)
        {
            this.genusRepository = genusRepository;
        }

        public GenusPanelViewModel Build (int genusTypeId)
        {
            var genusList = this.genusRepository.GetGenusOfIdWithFish(genusTypeId);

            var genusType = genusList[0].GenusType;

            return new GenusPanelViewModel { GenusList = genusList, GenusType = genusType };
        }

        public GenusPanelViewModel Build(int genusTypeId, int selectedGenusId, int selectedSpecies)
        {
            var viewModel = this.Build(genusTypeId);

            viewModel.ExpandedGenus = selectedGenusId;

            viewModel.SelectedSpecies = selectedSpecies;

            return viewModel;
        }
    }
}
