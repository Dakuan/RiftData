using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace RiftData.Presentation.ViewModels.Dto
{
    public class LakeDto
    {
        public IList<GenusTypeDto> GenusTypes;

        public int Id { get; set; }

        public string Name { get; set; }
    }
}
