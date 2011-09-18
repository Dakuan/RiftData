using System.Web.Mvc;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts.Admin;
using RiftData.Presentation.ViewModels.Admin;

namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    public class GenusTypeCreatePageViewModelFactory : IGenusTypeCreatePageViewModelFactory
    {
        private readonly ILakeRepository _lakeRepository;

        public GenusTypeCreatePageViewModelFactory(ILakeRepository lakeRepository)
        {
            _lakeRepository = lakeRepository;
        }

        public GenusTypeCreatePageViewModel Build()
        {
            var lakes = this._lakeRepository.GetAll();

            var viewModel = new GenusTypeCreatePageViewModel
                                {
                                    Lakes = new SelectList(lakes, "Id", "Name")
                                };

            return viewModel;
        }
    }
}