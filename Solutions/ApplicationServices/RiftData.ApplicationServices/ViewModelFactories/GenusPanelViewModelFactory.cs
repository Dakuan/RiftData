using System;
using System.Collections.Generic;
using System.Linq;
using RiftData.Presentation.Contracts;
using RiftData.Presentation.ViewModels;
using RiftData.Domain.Repositories;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    public class GenusPanelViewModelFactory : IGenusPanelViewModelFactory
    {
        private IGenusRepository genusRepository;
        private readonly IDtoFactory _dtoFactory;

        public GenusPanelViewModelFactory(IGenusRepository genusRepository, IDtoFactory dtoFactory)
        {
            this.genusRepository = genusRepository;
            _dtoFactory = dtoFactory;
        }

        public GenusPanelViewModel Build (int genusTypeId)
        {
            var genusDtoList = new List<GenusDto>();

            genusRepository.GetGenusOfIdWithFish(genusTypeId).ToList().ForEach(g => genusDtoList.Add(this._dtoFactory.Build(g)));

            return new GenusPanelViewModel { GenusList = genusDtoList };
        }

        public GenusPanelViewModel Build(int genusTypeId, int selectedGenusId, int selectedSpecies)
        {
            var viewModel = this.Build(genusTypeId);

            viewModel.ExpandedGenus = selectedGenusId;

            viewModel.SelectedSpecies = selectedSpecies;

            return viewModel;
        }

        public GenusPanelViewModel Build()
        {
            var genusDtoList = new List<GenusDto>();

            this.genusRepository.List.ToList().ForEach(g => genusDtoList.Add(this._dtoFactory.Build(g)));

            return new GenusPanelViewModel { GenusList = genusDtoList };
        }
    }
}
