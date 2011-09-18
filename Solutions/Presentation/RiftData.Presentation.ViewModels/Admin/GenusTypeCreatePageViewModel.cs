using System.Web.Mvc;

namespace RiftData.Presentation.ViewModels.Admin
{
    public class GenusTypeCreatePageViewModel : ViewModelBase
    {        
        public GenusTypeCreatePageViewModel()
        {
            this.SelectedView = SelectedView.GenusTypes;
        }

        public SelectList Lakes { get; set; }
    }
}