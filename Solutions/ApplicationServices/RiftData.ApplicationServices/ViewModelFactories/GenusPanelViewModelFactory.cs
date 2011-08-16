using RiftData.ApplicationServices.DtoServices.Contracts;
using RiftData.Presentation.Contracts;
using RiftData.Presentation.ViewModels;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    public class GenusPanelViewModelFactory : IGenusPanelViewModelFactory
    {
        private readonly IGenusDtoService _genusDtoService;

        private readonly IGenusTypeDtoService genusTypeDtoService;

        public GenusPanelViewModelFactory(IGenusDtoService genusDtoService, IGenusTypeDtoService genusTypeDtoService)
        {
            _genusDtoService = genusDtoService;
            this.genusTypeDtoService = genusTypeDtoService;
        }

        public GenusPanelViewModel Build (int genusTypeId)
        {
            var genusTypeDto = this.genusTypeDtoService.GetGenusTypeDto(genusTypeId);

            return new GenusPanelViewModel { GenusList = this._genusDtoService.GetGenusDtos(genusTypeId), GenusType = genusTypeDto };
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
            return new GenusPanelViewModel { GenusList = this._genusDtoService.GetGenusDtos() };
        }
    }
}
