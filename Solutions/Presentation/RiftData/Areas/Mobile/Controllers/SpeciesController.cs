using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RiftData.Presentation.Contracts.ViewModelFactories.Mobile;

namespace RiftData.Areas.Mobile.Controllers
{
    public class SpeciesController : Controller
    {
        private readonly ISpeciesIndexPageViewModelFactory speciesIndexPageViewModelFactory;

        public SpeciesController(ISpeciesIndexPageViewModelFactory speciesIndexPageViewModelFactory)
        {
            this.speciesIndexPageViewModelFactory = speciesIndexPageViewModelFactory;
        }

        public ActionResult Index(string speciesName)
        {
            return View(this.speciesIndexPageViewModelFactory.Build(speciesName));
        }

    }
}
