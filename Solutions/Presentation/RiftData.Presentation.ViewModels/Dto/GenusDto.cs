namespace RiftData.Presentation.ViewModels.Dto
{
    using System.Collections.Generic;

    public class GenusDto
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public IList<SpeciesDto> Species { get; set; }

        public int GenusTypeId { get; set; }
    }
}