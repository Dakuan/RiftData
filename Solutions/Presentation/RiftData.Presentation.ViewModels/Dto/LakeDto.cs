namespace RiftData.Presentation.ViewModels.Dto
{
    using System.Collections.Generic;

    public class LakeDto
    {
        public IEnumerable<GenusTypeDto> GenusTypes;

        public int Id { get; set; }

        public string Name { get; set; }
    }
}