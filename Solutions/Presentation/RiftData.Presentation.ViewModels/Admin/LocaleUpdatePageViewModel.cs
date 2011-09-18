using System.ComponentModel.DataAnnotations;

namespace RiftData.Presentation.ViewModels.Admin
{
    public class LocaleUpdatePageViewModel : ViewModelBase
    {
        public LocaleUpdatePageViewModel()
        {
            this.SelectedView = SelectedView.Locales;
        }

        [Required]
        public string Name { get; set; }

        public double Latitude { get; set; }

        public double Longitude { get; set; }

        public int ZoomLevel { get; set; }
    }
}