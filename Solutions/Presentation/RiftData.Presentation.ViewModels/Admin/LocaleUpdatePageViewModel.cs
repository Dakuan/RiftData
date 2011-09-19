namespace RiftData.Presentation.ViewModels.Admin
{
    using System.ComponentModel.DataAnnotations;

    public class LocaleUpdatePageViewModel : ViewModelBase
    {
        public LocaleUpdatePageViewModel()
        {
            this.SelectedView = SelectedView.Locales;
        }

        public double Latitude { get; set; }

        public double Longitude { get; set; }

        [Required]
        public string Name { get; set; }

        public int ZoomLevel { get; set; }
    }
}