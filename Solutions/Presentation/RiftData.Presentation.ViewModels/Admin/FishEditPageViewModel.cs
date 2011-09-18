using System.Collections.Generic;
using System.Web.Mvc;
using RiftData.Domain.Entities;

namespace RiftData.Presentation.ViewModels.Admin
{
    public class FishEditPageViewModel : ViewModelBase
    {
        public FishEditPageViewModel(int id)
        {
            Id = id;

            this.SelectedView = SelectedView.Fish;
        }

        public int Id { get; private set; }

        public string Name { get; set; }

        public SelectList Species { get; set; }

        public SelectList Locales { get; set; }

        public SelectList Genus { get; set; }

        public string Description { get; set; }

        public bool MessageBoxVisible { get; set; }

        public string MessageBoxContentSource { get; set; }

        public IList<Photo> Photos { get; set; }
    }
}