namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using RiftData.ApplicationServices.DtoServices.Extensions;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts.Admin;
    using RiftData.Presentation.ViewModels.Admin;

    public class GenusTypesUpdatePageViewModelFactory : IGenusTypesUpdatePageViewModelFactory
    {
        private readonly IGenusTypeRepository _genusTypeRepository;

        private readonly ILakeRepository _lakeRepository;

        public GenusTypesUpdatePageViewModelFactory(
            ILakeRepository lakeRepository, IGenusTypeRepository genusTypeRepository)
        {
            this._lakeRepository = lakeRepository;
            this._genusTypeRepository = genusTypeRepository;
        }

        public GenusTypeUpdatePageViewModel Build(int genusTypeId)
        {
            var genusType = this._genusTypeRepository.Get(genusTypeId);

            var viewModel = new GenusTypeUpdatePageViewModel
                {
                    Lakes = this._lakeRepository.GetAll().ToSelectList(genusType.Lake.Id), 
                    GenusType = DtoFactory.Build(genusType)
                };

            return viewModel;
        }
    }
}