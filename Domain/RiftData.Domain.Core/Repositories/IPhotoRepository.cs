using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using RiftData.Domain.Entities;

namespace RiftData.Domain.Repositories
{
    public interface IPhotoRepository
    {
        Photo GetPhoto(int id);

        void GetPhotosForSubjects(Dictionary<int, IPhotoSubject> photoSubjects);

        void GetPhotosForSubject(IPhotoSubject photoSubject);
    }
}
