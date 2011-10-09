using System.Collections.Generic;
using System.Web.Mvc;
using RiftData.Presentation.ViewModels.Admin.Shared;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.Presentation.ViewModels.Admin.Fish
{
    public class FishEditPageViewModel : Shared.ViewModelBase
    {
        public FishEditPageViewModel(int id)
        {
            this.Id = id;
        }

        public string Description { get; set; }

        public SelectList Genus { get; set; }

        public int Id { get; private set; }

        public SelectList Locales { get; set; }

        public string MessageBoxContentSource { get; set; }

        public bool MessageBoxVisible { get; set; }

        public string Name { get; set; }

        public IEnumerable<PhotoDto> Photos { get; set; }

        public SelectList Species { get; set; }
    }
}