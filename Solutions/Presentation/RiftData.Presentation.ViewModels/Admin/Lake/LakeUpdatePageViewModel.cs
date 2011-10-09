using RiftData.Presentation.ViewModels.Admin.Shared;

namespace RiftData.Presentation.ViewModels.Admin.Lake
{
    public class LakeUpdatePageViewModel : Shared.ViewModelBase
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public string Description { get; set; }
    }
}