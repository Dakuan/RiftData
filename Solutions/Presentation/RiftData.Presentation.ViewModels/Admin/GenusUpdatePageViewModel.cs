namespace RiftData.Presentation.ViewModels.Admin
{
    public class GenusUpdatePageViewModel : ViewModelBase
    {
        public GenusUpdatePageViewModel()
        {
            this.SelectedView = SelectedView.Genus;
        }

        public int Id { get; set; }

        public string Mode { get; set; }

        public string Name { get; set; }
    }
}