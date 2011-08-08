using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using RiftData.Domain.Repositories;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.ApplicationServices.DtoServices
{
    public class PhotoDtoService
    {
        private readonly IPhotosRepository _photosRepository;

        public PhotoDtoService(IPhotosRepository photosRepository)
        {
            _photosRepository = photosRepository;
        }

        IList<PhotoDto> GetRandomPhotos(int numberOfPhotos)
        {
            var list = new List<PhotoDto>();

            return list;
        }
    }
}
