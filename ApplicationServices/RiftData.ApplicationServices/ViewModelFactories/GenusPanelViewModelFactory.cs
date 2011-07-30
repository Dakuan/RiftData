using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using RiftData.Shared.ViewModels;
using RiftData.Domain.Repositories;
using RiftData.Domain.Entities;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    public class GenusPanelViewModelFactory : IGenusPanelViewModelFactory
    {
        private IRepository<Genus> genusRepository;

        public GenusPanelViewModelFactory(IRepository<Genus> genusRepository)
        {
            this.genusRepository = genusRepository;
        }

        public GenusPanelViewModel Build (int genusTypeId)
        {
            var genusList = this.genusRepository.List.Where(g => g.GenusType.Id == genusTypeId).ToList();

            var genusType = genusList[0].GenusType;

            return new GenusPanelViewModel { GenusList = genusList, GenusType = genusType };
        }
    }
}
