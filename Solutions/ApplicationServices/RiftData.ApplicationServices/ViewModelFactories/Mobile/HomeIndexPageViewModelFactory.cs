namespace RiftData.ApplicationServices.ViewModelFactories.Mobile
{
    using System.Collections.Generic;
    using System.Linq;

    using Castle.Core;

    using RiftData.ApplicationServices.DtoServices.Extensions;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts.ViewModelFactories.Mobile;
    using RiftData.Presentation.ViewModels.Dto;
    using RiftData.Presentation.ViewModels.Mobile;
    using RiftData.Presentation.ViewModels.Shared;

    public class HomeIndexPageViewModelFactory : IHomeIndexPageViewModelFactory
    {
        private readonly ILakeRepository lakeRepository;
        private readonly IGenusTypeRepository genusTypeRepository;

        private readonly IPhotosRepository photosRepository;

        public HomeIndexPageViewModelFactory(ILakeRepository lakeRepository, IGenusTypeRepository genusTypeRepository, IPhotosRepository photosRepository)
        {
            this.lakeRepository = lakeRepository;
            this.genusTypeRepository = genusTypeRepository;
            this.photosRepository = photosRepository;
        }

        public HomeIndexPageViewModel Build()
        {
            var dictionary = new Dictionary<LakeDto, IDictionary<GenusTypeDto, PhotoDto>>();

            this.lakeRepository.GetAllWithGenusTypes().ToList().ForEach(l => dictionary.Add(DtoFactory.Build(l), this.BuildGenusTypeDictionary(this.genusTypeRepository.GetFromLake(l.Id).ToDtoList())));

            var viewModel = new HomeIndexPageViewModel
                            {
                                Header = "Lakes",
                                MetaData = MetaData.Build(string.Empty, "Lakes", string.Empty),
                                DataDictionary = dictionary
                            };

            return viewModel;
        }

        private IDictionary<GenusTypeDto, PhotoDto> BuildGenusTypeDictionary(IList<GenusTypeDto> dtoList)
        {
            var dictionary = new Dictionary<GenusTypeDto, PhotoDto>();

            dtoList.ForEach(x =>
                {
                    var photo = this.photosRepository.GetSingleForGenusType(x.Id);

                    dictionary.Add(x, photo == null ? null : DtoFactory.Build(photo));
                });

            return dictionary;
        }
    }
}