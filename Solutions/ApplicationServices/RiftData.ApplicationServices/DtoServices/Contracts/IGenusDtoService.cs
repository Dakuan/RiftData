using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.ApplicationServices.DtoServices.Contracts
{
    public interface IGenusDtoService
    {
        IList<GenusDto> GetGenusTypeDtos(int genusTypeId);

        IList<GenusDto> GetGenusTypeDtos();
    }
}