using RiftData.Domain.Entities;
using RiftData.Presentation.ViewModels.Admin.Fish;

namespace RiftData.ApplicationServices.CrudServices
{
    public interface IFishService
    {
        Fish Fish { get; set; }

        CrudResult CreateFish(FishEditFormViewModel viewModel);

        CrudResult UpdateFish(FishEditFormViewModel viewModel);
    }
}
