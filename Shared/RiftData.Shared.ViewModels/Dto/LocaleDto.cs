namespace RiftData.Presentation.ViewModels.Dto
{
    public class LocaleDto
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public double Latitude { get; set; }

        public double Longitude { get; set; }

        public bool HasPhotos { get; set; }
    }
}
