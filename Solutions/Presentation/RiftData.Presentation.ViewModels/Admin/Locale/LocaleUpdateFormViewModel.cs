namespace RiftData.Presentation.ViewModels.Admin
{
    using System.ComponentModel.DataAnnotations;

    public class LocaleUpdateFormViewModel
    {
        public int Id { get; set; }

        [Required]
        public double Latitude { get; set; }

        [Required]
        public double Longitude { get; set; }

        [Required]
        public string Name { get; set; }
    }
}