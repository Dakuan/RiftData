using System;
using System.Collections.Generic;
using System.Linq;
using RiftData.Domain.Entities;
using RiftData.Domain.Factories;
using RiftData.Infrastructure.Data;

namespace RiftData.Domain.Repositories
{
    public class PhotosRepository : RepositoryBase<Photo, RiftData.Infrastructure.Data.Photos>, IPhotosRepository
    {
        private readonly RiftDataDataEntities dataEntites;

        private IPhotoFactory photoFactory;

        public PhotosRepository(RiftDataDataEntities dataEntites, IPhotoFactory photoFactory) : base(dataEntites)
        {
            this.photoFactory = photoFactory;
        }

        public IQueryable<Photo> List
        {
            get { throw new NotImplementedException(); }
        }

        protected override IEnumerable<Photo> Sort(IEnumerable<Photo> unsortedList)
        {
            throw new NotImplementedException();
        }

        protected override Photo BuildUp(Photos dataObject)
        {
            throw new NotImplementedException();
        }
    }
}
