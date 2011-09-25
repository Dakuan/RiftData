namespace RiftData.Presentation.ViewModels.Dto
{
    using System.Collections.Generic;

    public class LakeDto
    {
        public IList<GenusTypeDto> GenusTypes { get; set; }

        public int Id { get; set; }

        public string Name { get; set; }

        public string Description { get; set; }
    }
}