namespace RiftData.Presentation.ViewModels.Admin
{
    public class GenusUpdateFormViewModel : ViewModelBase
    {
        public GenusUpdateFormViewModel()
        {
            this.SelectedView = SelectedView.Genus;
        }

        public int Id { get; set; }

        public string Name { get; set; }
    }
}