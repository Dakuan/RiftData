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
    public class GenusTypesIndexPageViewModelFactory : IGenusTypesIndexPageViewModelFactory
    {
        private readonly IGenusTypeRepository genusTypeRepository;

        public GenusTypesIndexPageViewModelFactory(IGenusTypeRepository genusTypeRepository)
        {
            this.genusTypeRepository = genusTypeRepository;
        }

        public GenusTypesIndexPageViewModel Build(string genusTypeName)
        {
            var genusType = this.genusTypeRepository.GetByName(genusTypeName);

            var viewModel = new GenusTypesIndexPageViewModel
                                {
                                    MetaData = MetaData.Build(string.Empty, genusType.Name, string.Empty),
                                    Genera = genusType.Genus.SortGenus().ToDtoList(),
                                    Header = genusType.Name                    
                                };

            return viewModel;
        }
    }
}
