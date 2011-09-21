namespace RiftData.Presentation.ViewModels.Admin.Lake
{
    public class LakeUpdatePageViewModel : ViewModelBase
    {
        public LakeUpdatePageViewModel()
        {
            this.SelectedView = SelectedView.Lake;
        }

        public int Id { get; set; }

        public string Name { get; set; }

        public string Description { get; set; }
    }
}