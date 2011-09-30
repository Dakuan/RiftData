using RiftData.ApplicationServices.Extensions;
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts.ViewModelFactories.Admin;
using RiftData.Presentation.ViewModels.Admin.Photos;

namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    public class PhotosIndexPageViewModelFactory : IPhotosIndexPageViewModelFactory
    {
        private readonly IPhotosRepository photoRepository;

        public PhotosIndexPageViewModelFactory(IPhotosRepository photoRepository)
        {
            this.photoRepository = photoRepository;
        }

        public PhotosIndexPageViewModel Build()
        {
            var viewModel = new PhotosIndexPageViewModel
                                {
                                    Photos = this.photoRepository.GetAll().ToDtoList()
                                };

            return viewModel;
        }
    }
}