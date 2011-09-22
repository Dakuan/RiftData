using RiftData.Presentation.Contracts.ViewModelFactories.Admin;
using RiftData.Presentation.ViewModels.Admin.GenusType;

namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using RiftData.ApplicationServices.DtoServices.Extensions;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.ViewModels.Admin;

    public class GenusTypesUpdatePageViewModelFactory : IGenusTypesUpdatePageViewModelFactory
    {
        private readonly IGenusTypeRepository genusTypeRepository;

        private readonly ILakeRepository lakeRepository;

        public GenusTypesUpdatePageViewModelFactory(ILakeRepository lakeRepository, IGenusTypeRepository genusTypeRepository)
        {
            this.lakeRepository = lakeRepository;
            this.genusTypeRepository = genusTypeRepository;
        }

        public GenusTypeUpdatePageViewModel Build(int genusTypeId)
        {
            var genusType = this.genusTypeRepository.Get(genusTypeId);

            var viewModel = new GenusTypeUpdatePageViewModel { Lakes = this.lakeRepository.GetAll().ToSelectList(genusType.Lake.Id), GenusType = DtoFactory.Build(genusType) };

            return viewModel;
        }
    }
}