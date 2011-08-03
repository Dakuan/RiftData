using System.Collections.Generic;

namespace RiftData.Domain.Entities
{
    public interface IPhotoSubject
    {
        IList<Photo> Photos { get; }

        bool HasPhotos { get; }
    }
}
