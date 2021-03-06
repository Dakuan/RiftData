﻿using RiftData.Domain.Extensions;
using RiftData.Presentation.Contracts.ViewModelFactories.Admin;
using RiftData.Presentation.ViewModels.Admin.Shared;
using RiftData.Presentation.ViewModels.Admin.Species;

namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using System.Web;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.ViewModels.Admin;

    public class SpeciesEditPageViewModelFactory : ISpeciesEditPageViewModelFactory
    {
        private readonly IGenusRepository genusRepository;

        private readonly INavigationViewModelFactory navigationViewModelFactory;
        private readonly ISpeciesRepository speciesRepository;

        private readonly ITemperamentRepository temperamentRepository;

        public SpeciesEditPageViewModelFactory(INavigationViewModelFactory navigationViewModelFactory, ISpeciesRepository speciesRepository, IGenusRepository genusRepository, ITemperamentRepository temperamentRepository)
        {
            this.navigationViewModelFactory = navigationViewModelFactory;
            this.speciesRepository = speciesRepository;
            this.genusRepository = genusRepository;
            this.temperamentRepository = temperamentRepository;
        }

        public SpeciesEditPageViewModel Build(int speciesId)
        {
            var species = this.speciesRepository.GetSpeciesFromId(speciesId);

            var viewModel = new SpeciesEditPageViewModel { NavigationViewModel = this.navigationViewModelFactory.Build(SelectedView.Fish), Described = species.Described, Description = HttpUtility.HtmlDecode(species.Description), Mode = "Update", Name = species.Name, MaxSize = species.MaxSize, MinSize = species.MinSize, Temperament = this.temperamentRepository.GetAll().ToSelectList(species.Temperament.Id), Genus = this.genusRepository.GetOfType(species.Genus.GenusType.Id).ToSelectList(species.Genus.Id) };

            return viewModel;
        }

        public SpeciesEditPageViewModel Build()
        {
            return new SpeciesEditPageViewModel { NavigationViewModel = this.navigationViewModelFactory.Build(SelectedView.Fish), Temperament = this.temperamentRepository.GetAll().ToSelectList("select a temperament"), Genus = this.genusRepository.GetAll().ToSelectList("select a genus"), Mode = "Create" };
        }
    }
}