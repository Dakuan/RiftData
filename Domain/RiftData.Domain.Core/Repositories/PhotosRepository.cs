using System;
using System.Linq;
using RiftData.Domain.Entities;
using RiftData.Domain.Factories;
using RiftData.Infrastructure.Data;

namespace RiftData.Domain.Repositories
{
    public class PhotosRepository : RepositoryBase<Photo>
    {
        private IPhotoFactory photoFactory;

        public PhotosRepository(RiftDataDataEntities dataEntites, IPhotoFactory photoFactory) : base(dataEntites)
        {
            this.photoFactory = photoFactory;
        }

        public override IQueryable<Photo> List
        {
            get { throw new NotImplementedException(); }
        }
    }
}
