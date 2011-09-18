using System.Web;
using RiftData.Domain.Entities;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts.Admin;

namespace RiftData.ApplicationServices
{
    public class PhotosService : IPhotosService
    {
        private IPhotosRepository photosRepository;

        private IFishRepository fishRepository;

        public PhotosService(IPhotosRepository photosRepository, IFishRepository fishRepository)
        {
            this.photosRepository = photosRepository;

            this.fishRepository = fishRepository;
        }

        public Fish GetFish(int id)
        {
            return this.fishRepository.GetFish(id);
        }

        public Photo SavePhoto(HttpPostedFileBase attachments, int fishId)
        {
            var fish = this.fishRepository.GetFish(fishId);

            return this.photosRepository.Add(attachments, fish.Id);
        }

        public void DeletePhoto(string id)
        {
            this.photosRepository.Delete(id);
        }
    }
}