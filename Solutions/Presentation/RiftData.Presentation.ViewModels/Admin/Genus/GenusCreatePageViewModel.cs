namespace RiftData.Presentation.ViewModels.Admin.Genus
{
    using System.Web.Mvc;

    public class GenusCreatePageViewModel : ViewModelBase
    {
        public GenusCreatePageViewModel()
        {
            this.SelectedView = SelectedView.Genus;
        }

        public SelectList Lakes { get; set; }

        public string Name { get; set; }
    }
}