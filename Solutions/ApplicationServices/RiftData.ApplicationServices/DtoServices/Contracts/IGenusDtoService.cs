using System.Collections.Generic;
using RiftData.Presentation.ViewModels.Dto;

namespace RiftData.ApplicationServices.DtoServices.Contracts
{
    public interface IGenusDtoService
    {
        IEnumerable<GenusDto> GetGenusDtos(int genusTypeId);

        IList<GenusDto> GetGenusDtos();
    }
}