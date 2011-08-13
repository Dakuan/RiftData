using System;
using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Entities;
using RiftData.Domain.Repositories;

namespace RiftData.Infrastructure.Data.Repositories
{
    public class PhotosRepository : IPhotosRepository
    {
        private readonly RiftDataDataContext dataEntities;

        public PhotosRepository(RiftDataDataContext dataEntities)
        {
            this.dataEntities = dataEntities;
        }

        public IList<Photo>GetPhotosForSpecies(int speciesId)
        {
            var list = new List<Photo>();

            this.dataEntities.Fish.Where(f => f.Species.Id ==speciesId).ToList().ForEach(f => f.Photos.ToList().ForEach(p =>
                                                                                                                            {
                                                                                                                                if (string.IsNullOrEmpty(p.Caption))
                                                                                                                                {
                                                                                                                                    p.Caption = f.Name;
                                                                                                                                }
                                                                                                                                
                                                                                                                                list.Add(p);
                                                                                                                            }));

            return list;
        }
    }
}