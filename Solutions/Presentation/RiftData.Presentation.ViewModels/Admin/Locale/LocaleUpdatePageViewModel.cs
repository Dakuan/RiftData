using System.ComponentModel.DataAnnotations;
using RiftData.Presentation.ViewModels.Admin.Shared;

namespace RiftData.Presentation.ViewModels.Admin.Locale
{
    public class LocaleUpdatePageViewModel : Shared.ViewModelBase
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