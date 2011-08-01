using System;
using System.Collections.Generic;
using RiftData.Domain.Entities;
using RiftData.Domain.Factories;

namespace RiftData.Domain.Repositories
{
    public class PhotoRepository : IPhotoRepository
    {
        private readonly IPhotoFactory _photoFactory;

        public PhotoRepository(IPhotoFactory photoFactory)
        {
            _photoFactory = photoFactory;
        }

        public Photo GetPhoto(int id)
        {
            throw new NotImplementedException();
        }

        public void GetPhotosForSubjects(Dictionary<int, IPhotoSubject> photoSubjects)
        {
            throw new NotImplementedException();
        }

        public void GetPhotosForSubject(IPhotoSubject photoSubject)
        {
            throw new NotImplementedException();
        }
    }
}