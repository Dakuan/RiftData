namespace RiftData.ApplicationServices
{
    using System.Web;

    using RiftData.Domain.Entities;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts.Admin;

    public class PhotosService : IPhotosService
    {
        private readonly IFishRepository fishRepository;

        private readonly IPhotosRepository photosRepository;

        public PhotosService(IPhotosRepository photosRepository, IFishRepository fishRepository)
        {
            this.photosRepository = photosRepository;

            this.fishRepository = fishRepository;
        }

        public void DeletePhoto(string id)
        {
            this.photosRepository.Delete(id);
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
    }
}