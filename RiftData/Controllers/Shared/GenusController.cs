
using System.Web.Mvc;
using RiftData.ApplicationServices.ViewModelFactories;

namespace RiftData.Controllers.Shared
{
    public class GenusController : Controller
    {
        private IGenusPanelViewModelFactory genusPanelViewModelFactory;

        public GenusController(IGenusPanelViewModelFactory genusPanelViewModelFactory)
        {
            this.genusPanelViewModelFactory = genusPanelViewModelFactory;
        }

        public ActionResult GenusPanel(int id)
        {
            var viewModel = this.genusPanelViewModelFactory.Build(id);
           
            return PartialView("GenusPanel", viewModel);
        }
    }
}