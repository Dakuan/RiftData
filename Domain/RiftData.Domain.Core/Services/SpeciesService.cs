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
            var hasPhotos = false;

            return dataEntities.Fish.Any(f => dataEntities.Photos.Any(p => p.FishId == f.FishID));

            //dataEntities.Fish.Where(f => f.Species == speciesId).ToList().ForEach(f =>
            //{
            //    if (dataEntities.Photos.Any(p => p.FishId == f.FishID))
            //    {
            //        hasPhotos = true;
            //    }
            //});

            //return hasPhotos;
        }
    }
}
