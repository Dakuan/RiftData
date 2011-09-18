using System.Web.Mvc;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts.Admin;
using RiftData.Presentation.ViewModels.Admin;

namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    public class GenusTypesUpdatePageViewModelFactory : IGenusTypesUpdatePageViewModelFactory
    {
        private readonly ILakeRepository _lakeRepository;
        private readonly IGenusTypeRepository _genusTypeRepository;

        public GenusTypesUpdatePageViewModelFactory(ILakeRepository lakeRepository, IGenusTypeRepository genusTypeRepository)
        {
            _lakeRepository = lakeRepository;
            _genusTypeRepository = genusTypeRepository;
        }

        public GenusTypeUpdatePageViewModel Build(int genusTypeId)
        {
            var genusType = this._genusTypeRepository.GetGenusType(genusTypeId);

            var viewModel = new GenusTypeUpdatePageViewModel
                                {
                                    Lakes = new SelectList(this._lakeRepository.GetAll(), "Id", "Name", genusType.Lake.Id),
                                    GenusType =genusType
                                };

            return viewModel;
        }
    }
}