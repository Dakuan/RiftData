using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using RiftData.Domain.Entities;
using RiftData.Domain.Factories;
using RiftData.Infrastructure.Data;

namespace RiftData.Domain.Repositories
{
    public class PhotosRepository : RepositoryBase<Photo, RiftData.Infrastructure.Data.Photos>, IPhotosRepository
    {
        private IPhotoFactory photoFactory;

        public PhotosRepository(RiftDataDataEntities dataEntites, IPhotoFactory photoFactory) : base(dataEntites)
        {
            this.photoFactory = photoFactory;
        }

        public IQueryable<Photo> List
        {
            get { throw new NotImplementedException(); }
        }

        public IList<Photo>GetPhotosForSpecies(int speciesId)
        {
            var list = new List<RiftData.Infrastructure.Data.Photos>();

            this.dataEntities.Fish.Where(
                f => f.Species == speciesId && dataEntities.Photos.Any(p => p.FishId == f.FishID)).ToList().ForEach(
                    f => this.dataEntities.Photos.Where(p => p.FishId == f.FishID).ToList().ForEach(list.Add));


            var tasks = new List<Task<Photo>>();

            list.ForEach(t => tasks.Add(new Task<Photo>(() => this.photoFactory.Build(t))));

            Task.WaitAll();

            var photoList = new List<Photo>();

            tasks.ToList().ForEach(t => photoList.Add(t.Result));

            return photoList;
        }

        protected override IEnumerable<Photo> Sort(IEnumerable<Photo> unsortedList)
        {
            //redundant until theres a reasonable way of sorting photos
            throw new NotImplementedException();
        }

        protected override Photo BuildUp(Photos dataObject)
        {
            //photos do not require prereqisites, this function is rendudant
            throw new NotImplementedException();
        }
    }
}
