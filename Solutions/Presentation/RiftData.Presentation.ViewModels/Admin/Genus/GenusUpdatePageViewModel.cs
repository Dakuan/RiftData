using System.Web.Mvc;
using RiftData.Presentation.ViewModels.Admin.Shared;

namespace RiftData.Presentation.ViewModels.Admin.Genus
{
    public class GenusUpdatePageViewModel : Shared.ViewModelBase
    {
        public int Id { get; set; }

        public string Mode { get; set; }

        public SelectList Lakes { get; set; }

        public string Name { get; set; }
    }
}