using RiftData.Presentation.ViewModels.Admin.Genus;

namespace RiftData.Presentation.Contracts.ViewModelFactories.Admin
{
    public interface IGenusUpdatePageViewModelFactory
    {
        GenusUpdatePageViewModel Build(int genusId);
    }
}