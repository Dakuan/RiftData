namespace RiftData.Presentation.ViewModels.Dto
{
    using System.Collections.Generic;

    public class FishDto
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public bool HasPhotos { get; set; }

        public string UrlName { get; set; }

        public string Description { get; set; }

        public bool HasDescription { get; set; }

        public SpeciesDto Species { get; set; }

        public LocaleDto Locale { get; set; }

        public IEnumerable<PhotoDto> Photos { get; set; }
    }
}
