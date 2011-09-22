using RiftData.Presentation.ViewModels.Admin.Shared;

namespace RiftData.Presentation.ViewModels.Admin.GenusType
{
    using System.Web.Mvc;

    public class GenusTypeCreatePageViewModel : Shared.ViewModelBase
    {
        public GenusTypeCreatePageViewModel()
        {
            this.SelectedView = SelectedView.GenusTypes;
        }

        public SelectList Lakes { get; set; }
    }
}