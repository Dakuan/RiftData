namespace RiftData.Presentation.ViewModels.Dto
{
    public class LocaleDto
    {
        public string Description { get; set; }

        public bool HasDescription { get; set; }

        public bool HasPhotos { get; set; }

        public int Id { get; set; }

        public LakeDto Lake { get; set; }

        public double Latitude { get; set; }

        public double Longitude { get; set; }

        public string Name { get; set; }

        public int ZoomLevel { get; set; }
    }
}