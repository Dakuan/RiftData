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

        public GenusPanelViewModelFactory(IGenusRepository genusRepository)
        {
            this.genusRepository = genusRepository;
        }

        public GenusPanelViewModel Build(int genusTypeId)
        {
            return new GenusPanelViewModel { GenusList = this.genusRepository.GetOfType(genusTypeId).ToDtoList() };
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