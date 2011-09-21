namespace RiftData.Presentation.ViewModels.Admin
{
    using System.Web.Mvc;

    public class GenusTypeCreatePageViewModel : ViewModelBase
    {
        public GenusTypeCreatePageViewModel()
        {
            this.SelectedView = SelectedView.GenusTypes;
        }

        public SelectList Lakes { get; set; }
    }
}