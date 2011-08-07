using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace RiftData.Shared.ViewModels.Dto
{
    public class LocaleDto
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public double Latitude { get; set; }

        public double Longitude { get; set; }
    }
}
