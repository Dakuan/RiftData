namespace RiftData.ApplicationServices.ViewModelFactories
{
    using System.Linq;

    using RiftData.ApplicationServices.DtoServices.Contracts;
    using RiftData.Presentation.Contracts;
    using RiftData.Presentation.ViewModels;

    public class GenusPanelViewModelFactory : IGenusPanelViewModelFactory
    {
        private readonly IGenusDtoService _genusDtoService;

        public GenusPanelViewModelFactory(IGenusDtoService genusDtoService)
        {
            this._genusDtoService = genusDtoService;
        }

        public GenusPanelViewModel Build(int genusTypeId)
        {
            return new GenusPanelViewModel { GenusList = this._genusDtoService.GetGenusDtos(genusTypeId).ToList() };
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