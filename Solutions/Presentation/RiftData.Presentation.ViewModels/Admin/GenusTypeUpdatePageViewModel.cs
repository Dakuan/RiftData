using System.Web.Mvc;
using RiftData.Domain.Entities;

namespace RiftData.Presentation.ViewModels.Admin
{
    public class GenusTypeUpdatePageViewModel : ViewModelBase
    {
        public GenusTypeUpdatePageViewModel()
        {
            this.SelectedView = SelectedView.GenusTypes;
        }

        public GenusType GenusType { get; set; }

        public SelectList Lakes { get; set; }
    }
}