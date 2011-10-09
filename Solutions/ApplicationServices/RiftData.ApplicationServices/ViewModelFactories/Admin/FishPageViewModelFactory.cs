using RiftData.ApplicationServices.Extensions;
using RiftData.Domain.Extensions;
using RiftData.Presentation.Contracts.ViewModelFactories.Admin;
using RiftData.Presentation.ViewModels.Admin.Fish;
using RiftData.Presentation.ViewModels.Admin.Shared;

namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using System.Linq;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.ViewModels.Admin;

    public class FishPageViewModelFactory : IFishPageViewModelFactory
    {
        private readonly INavigationViewModelFactory navigationViewModelFactory;
        private readonly IFishRepository fishRepository;

        private readonly IGenusRepository genusRepository;

        private readonly IGenusTypeRepository genusTypeRepository;

        public FishPageViewModelFactory(INavigationViewModelFactory navigationViewModelFactory, IFishRepository fishRepository, IGenusRepository genusRepository, IGenusTypeRepository genusTypeRepository)
        {
            this.navigationViewModelFactory = navigationViewModelFactory;
            this.fishRepository = fishRepository;
            this.genusRepository = genusRepository;
            this.genusTypeRepository = genusTypeRepository;
        }

        public FishIndexPageViewModel Build(int id)
        {
            var genusList = this.genusRepository.GetOfType(id);

            var viewModel = new FishIndexPageViewModel
                                {
                                    NavigationViewModel = this.navigationViewModelFactory.Build(SelectedView.Fish),
                                    Fish = this.fishRepository.GetOfType(id).ToList().ToDtoList(),
                                    Type = DtoFactory.Build(this.genusTypeRepository.Get(id)),
                                    GenusList = genusList.ToSelectList("select a genus")
                                };

            return viewModel;
        }
    }
}