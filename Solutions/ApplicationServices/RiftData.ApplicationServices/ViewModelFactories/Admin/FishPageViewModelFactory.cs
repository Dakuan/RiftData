namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using System.Linq;

    using RiftData.ApplicationServices.DtoServices.Extensions;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts.Admin;
    using RiftData.Presentation.ViewModels.Admin;

    public class FishPageViewModelFactory : IFishPageViewModelFactory
    {
        private readonly IFishRepository _fishRepository;

        private readonly IGenusRepository _genusRepository;

        private readonly IGenusTypeRepository _genusTypeRepository;

        public FishPageViewModelFactory(
            IFishRepository fishRepository, IGenusRepository genusRepository, IGenusTypeRepository genusTypeRepository)
        {
            this._fishRepository = fishRepository;
            this._genusRepository = genusRepository;
            this._genusTypeRepository = genusTypeRepository;
        }

        public FishIndexPageViewModel Build(int id)
        {
            var genusList = this._genusRepository.GetOfType(id);

            var viewModel = new FishIndexPageViewModel
                {
                    SelectedView = SelectedView.Fish, 
                    Fish = this._fishRepository.GetOfType(id).ToList().ToDtoList(), 
                    Type = DtoFactory.Build(this._genusTypeRepository.Get(id)), 
                    GenusList = genusList.ToSelectList("select a genus"), 
                    GenusTypes = this._genusTypeRepository.GetAll().ToList().ToDtoList()
                };

            return viewModel;
        }
    }
}