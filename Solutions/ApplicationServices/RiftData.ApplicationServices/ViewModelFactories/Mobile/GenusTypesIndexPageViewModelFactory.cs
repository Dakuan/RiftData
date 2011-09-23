using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using RiftData.ApplicationServices.DtoServices.Extensions;
using RiftData.Domain.Extensions;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts.ViewModelFactories.Mobile;
using RiftData.Presentation.ViewModels.Mobile;
using RiftData.Presentation.ViewModels.Shared;

namespace RiftData.ApplicationServices.ViewModelFactories.Mobile
{
    using Castle.Core;

    using RiftData.Presentation.ViewModels.Dto;

    public class GenusTypesIndexPageViewModelFactory : IGenusTypesIndexPageViewModelFactory
    {
        private readonly IGenusTypeRepository genusTypeRepository;

        private readonly IPhotosRepository photosRepository;

        public GenusTypesIndexPageViewModelFactory(IGenusTypeRepository genusTypeRepository, IPhotosRepository photosRepository)
        {
            this.genusTypeRepository = genusTypeRepository;
            this.photosRepository = photosRepository;
        }

        public GenusTypesIndexPageViewModel Build(string genusTypeName)
        {
            var genusType = this.genusTypeRepository.GetByName(genusTypeName);

            var dictionary = new Dictionary<GenusDto, PhotoDto>();

            genusType.Genus.SortGenus().ToDtoList().ForEach(x =>
                {
                    var photo = this.photosRepository.GetSingleForGenus(x.Id);

                    if (photo == null)
                    {
                        dictionary.Add(x, null);
                    }
                    else
                    {
                        dictionary.Add(x, DtoFactory.Build(photo));
                    }
                });

            var viewModel = new GenusTypesIndexPageViewModel
                                {
                                    MetaData = MetaData.Build(string.Empty, genusType.Name, string.Empty),
                                    Genera = dictionary,
                                    Header = genusType.Name                    
                                };

            return viewModel;
        }
    }
}
