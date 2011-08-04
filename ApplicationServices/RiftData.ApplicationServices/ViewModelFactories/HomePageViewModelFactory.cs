using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using RiftData.Domain.Entities;
using RiftData.Domain.Repositories;
using RiftData.Shared.ViewModels;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    public class HomePageViewModelFactory : IHomePageViewModelFactory
    {
        private IGenusTypeRepository genusTypeRepository;

        public HomePageViewModelFactory(IGenusTypeRepository genusTypeRepository)
        {
            this.genusTypeRepository = genusTypeRepository;
        }

        public HomePageViewModel Build()
        {
            var genusTypes = this.genusTypeRepository.List.Where(t => t.GenusCount > 0).ToList();

            return new HomePageViewModel { GenusTypes = genusTypes };
        }
    }
}
