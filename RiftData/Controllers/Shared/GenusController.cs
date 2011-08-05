
using System;
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

        public ActionResult GenusPanel(int id, int? selectedGenusId, int? selectedSpeciesId)
        {
            var viewModel = this.genusPanelViewModelFactory.Build(id, Convert.ToInt16(selectedGenusId), Convert.ToInt16(selectedSpeciesId));
           
            return PartialView("GenusPanel", viewModel);
        }
    }
}