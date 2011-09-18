using System.Web.Mvc;
using RiftData.Domain.Entities;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts.Admin;
using RiftData.Presentation.ViewModels.Admin;

namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    public class FishPageViewModelFactory : IFishPageViewModelFactory
    {
        private readonly IFishRepository _fishRepository;
        private readonly IGenusRepository _genusRepository;
        private readonly IGenusTypeRepository _genusTypeRepository;

        public FishPageViewModelFactory(IFishRepository fishRepository, IGenusRepository genusRepository, IGenusTypeRepository genusTypeRepository)
        {
            _fishRepository = fishRepository;
            _genusRepository = genusRepository;
            _genusTypeRepository = genusTypeRepository;
        }

        public FishIndexPageViewModel Build(int id)
        {
            var genusList = this._genusRepository.GetGenusOfType(id);

            genusList.Insert(0, new Genus{ Name = "Filter by Genus" });

            var viewModel = new FishIndexPageViewModel
                                {
                                    SelectedView = SelectedView.Fish, 
                                    Fish = this._fishRepository.GetFishOfType(id),
                                    Type = this._genusTypeRepository.GetGenusType(id),
                                    GenusList = new SelectList(genusList, "Id", "Name"),
                                    GenusTypes = this._genusTypeRepository.GetAll()
                                    
                                };

            return viewModel;
        }
    }
}
