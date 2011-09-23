using System.Collections.Generic;
using System.Linq;
using RiftData.ApplicationServices.DtoServices.Extensions;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts.ViewModelFactories.Mobile;
using RiftData.Presentation.ViewModels.Dto;
using RiftData.Presentation.ViewModels.Mobile;
using RiftData.Presentation.ViewModels.Shared;

namespace RiftData.ApplicationServices.ViewModelFactories.Mobile
{
    public class HomeIndexPageViewModelFactory : IHomeIndexPageViewModelFactory
    {
        private readonly ILakeRepository lakeRepository;
        private readonly IGenusTypeRepository genusTypeRepository;

        public HomeIndexPageViewModelFactory(ILakeRepository lakeRepository, IGenusTypeRepository genusTypeRepository)
        {
            this.lakeRepository = lakeRepository;
            this.genusTypeRepository = genusTypeRepository;
        }

        public HomeIndexPageViewModel Build()
        {
            var dictionary = new Dictionary<LakeDto, IList<GenusTypeDto>>();

            this.lakeRepository.GetAllWithGenusTypes().ToList().ForEach(l => dictionary.Add(DtoFactory.Build(l), this.genusTypeRepository.GetFromLake(l.Id).ToDtoList()));

            var viewModel = new HomeIndexPageViewModel
                            {
                                Header = "Lakes",
                                MetaData = MetaData.Build(string.Empty, "Lakes", string.Empty),
                                Lakes = this.lakeRepository.GetAllWithGenusTypes().ToDtoList(),
                                DataDictionary = dictionary
                            };

            return viewModel;
        }
    }
}