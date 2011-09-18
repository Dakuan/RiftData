using System.ComponentModel.DataAnnotations;

namespace RiftData.Presentation.ViewModels.Admin
{
    public class LocaleUpdateFormViewModel
    {
        public int Id { get; set; }

        [Required]
        public string Name { get; set; }

        [Required]
        public double Latitude { get; set; }

        [Required]
        public double Longitude { get; set; }
    }
}
