namespace RiftData.Presentation.ViewModels.Admin
{
    using System.Collections.Generic;
    using System.Web.Mvc;

    using RiftData.Presentation.ViewModels.Dto;

    public class FishEditPageViewModel : ViewModelBase
    {
        public FishEditPageViewModel(int id)
        {
            this.Id = id;

            this.SelectedView = SelectedView.Fish;
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