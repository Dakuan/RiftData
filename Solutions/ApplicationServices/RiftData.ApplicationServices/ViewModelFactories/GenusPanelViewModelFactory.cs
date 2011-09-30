using RiftData.ApplicationServices.Extensions;
using RiftData.Domain.Extensions;
using RiftData.Domain.Repositories;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    using RiftData.Presentation.Contracts;
    using RiftData.Presentation.ViewModels;

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

            return viewModel;
        }

        public GenusPanelViewModel Build()
        {
            return this.Build(1);
        }
    }
}