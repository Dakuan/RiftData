using RiftData.Presentation.ViewModels.Admin.Shared;

namespace RiftData.Presentation.ViewModels.Admin.Genus
{
    using System.Web.Mvc;

    public class GenusCreatePageViewModel : Shared.ViewModelBase
    {
        public SelectList Lakes { get; set; }

        public string Name { get; set; }
    }
}