namespace RiftData.Presentation.ViewModels.Dto
{
    public class SpeciesDto
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public string UrlName { get; set; }

        public bool HasPhotos { get; set; }

        public bool HasDescription { get; set; }

        public string Description { get; set; }
    }
}