using System.Collections.Generic;
using System.Linq;
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
            var genusList = this.genusRepository.GetGenusOfIdWithFish(genusTypeId);

            var genusDtoList = new List<GenusDto>();

            genusList.ToList().ForEach(g => genusDtoList.Add(this._dtoFactory.Build(g)));

            var genusType = genusList[0].GenusType;

            return new GenusPanelViewModel { GenusList = genusDtoList, GenusType = genusType };
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
