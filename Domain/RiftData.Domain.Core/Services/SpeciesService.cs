using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using RiftData.Infrastructure.Data;

namespace RiftData.Domain.Services
{
    internal class SpeciesService
    {
        public static bool SpeciesHasPhoto(RiftDataDataEntities dataEntities, int speciesId)
        {
            return dataEntities.Fish.Where(f => f.Species == speciesId).Any(f => dataEntities.Photos.Any(p => p.FishId == f.FishID));
        }
    }
}
