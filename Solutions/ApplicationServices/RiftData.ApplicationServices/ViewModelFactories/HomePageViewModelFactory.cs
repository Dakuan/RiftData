﻿namespace RiftData.ApplicationServices.ViewModelFactories
{
    using Domain.Repositories;
    using DtoServices.Contracts;
    using Presentation.Contracts;
    using Presentation.ViewModels;

    public class HomePageViewModelFactory : IHomePageViewModelFactory
    {
        private readonly IGenusTypeDtoService genusTypeDtoService;
        private readonly IGenusPanelViewModelFactory genusPanelViewModelFactory;
        private readonly IHeaderViewModelFactory headerViewModelFactory;
        private readonly IGenusTypeRepository genusTypeRepository;

        public HomePageViewModelFactory(IGenusTypeDtoService genusTypeDtoService, IGenusPanelViewModelFactory genusPanelViewModelFactory, IHeaderViewModelFactory headerViewModelFactory, IGenusTypeRepository genusTypeRepository)
        {
            this.genusTypeDtoService = genusTypeDtoService;
            this.genusPanelViewModelFactory = genusPanelViewModelFactory;
            this.headerViewModelFactory = headerViewModelFactory;
            this.genusTypeRepository = genusTypeRepository;
        }

        public HomePageViewModel Build(string genusTypeName)
        {
            var genusType = this.genusTypeRepository.GetGenusTypeByName(genusTypeName);

            var genusPanelViewModel = this.genusPanelViewModelFactory.Build(genusType.Id);

            var headerViewModel = this.headerViewModelFactory.Build(genusType);

            return new HomePageViewModel 
                { 
                    GenusPanelViewModel = genusPanelViewModel,
                    GenusType = this.genusTypeDtoService.GetGenusTypeDto(genusType.Id),
                    HeaderViewModel = headerViewModel
                };
        }
    }
}