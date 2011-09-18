using RiftData.ApplicationServices.DtoServices.Contracts;
using RiftData.Presentation.Contracts;
using RiftData.Presentation.ViewModels;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    public class GenusPanelViewModelFactory : IGenusPanelViewModelFactory
    {
        private readonly IGenusDtoService _genusDtoService;


        public GenusPanelViewModelFactory(IGenusDtoService genusDtoService)
        {
            _genusDtoService = genusDtoService;
        }

        public GenusPanelViewModel Build (int genusTypeId)
        {
            return new GenusPanelViewModel { GenusEnumerable = this._genusDtoService.GetGenusDtos(genusTypeId)};
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
