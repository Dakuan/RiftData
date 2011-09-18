using System.Linq;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts.Admin;
using RiftData.Presentation.ViewModels.Admin;

namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    public class GenusIndexPageViewModelFactory : IGenusIndexPageViewModelFactory
    {
        private readonly IGenusRepository _genusRepository;

        public GenusIndexPageViewModelFactory(IGenusRepository genusRepository)
        {
            _genusRepository = genusRepository;
        }

        public GenusIndexPageViewModel Builld()
        {
            var viewModel = new GenusIndexPageViewModel
                                {
                                    Genus = this._genusRepository.GetAll().ToList()
                                };

            return viewModel;
        }
    }
}
