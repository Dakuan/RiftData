using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace RiftData.Shared.ViewModels.Dto
{
    public class FishDto
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public string LocaleName { get; set; }

        public double Latitude { get; set; }

        public double Longitude { get; set; }
    }
}
