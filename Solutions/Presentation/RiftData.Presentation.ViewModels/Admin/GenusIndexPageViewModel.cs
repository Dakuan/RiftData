namespace RiftData.Presentation.ViewModels.Admin
{
    using System.Collections.Generic;

    using RiftData.Presentation.ViewModels.Dto;

    public class GenusIndexPageViewModel : ViewModelBase
    {
        public GenusIndexPageViewModel()
        {
            this.SelectedView = SelectedView.Genus;
        }

        public IList<GenusDto> Genus { get; set; }
    }
}