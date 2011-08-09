using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using RiftData.Infrastructure.Data;

namespace RiftData.Domain.Services
{
    public class HasPhotoService : IHasPhotoService
    {
        private readonly RiftDataDataEntities _dataEntities;

        public HasPhotoService(RiftDataDataEntities dataEntities)
        {
            _dataEntities = dataEntities;
        }

        public bool SpeciesHasPhoto(int speciesId)
        {
            return _dataEntities.Fish.Where(f => f.Species == speciesId).Any(f => _dataEntities.Photos.Any(p => p.FishId == f.FishID));
        }
    }
}