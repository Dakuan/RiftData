namespace RiftData.ApplicationServices.DtoServices.Contracts
{
    using System.Collections.Generic;

    using RiftData.Presentation.ViewModels.Dto;

    public interface IGenusDtoService
    {
        IEnumerable<GenusDto> GetGenusDtos(int genusTypeId);

        IList<GenusDto> GetGenusDtos();
    }
}