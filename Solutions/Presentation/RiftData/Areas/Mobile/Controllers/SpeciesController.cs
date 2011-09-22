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
        private readonly ISpeciesPhotosPageViewModelFactory speciesPhotosPageViewModelFactory;

        public SpeciesController(ISpeciesIndexPageViewModelFactory speciesIndexPageViewModelFactory, ISpeciesPhotosPageViewModelFactory speciesPhotosPageViewModelFactory)
        {
            this.speciesIndexPageViewModelFactory = speciesIndexPageViewModelFactory;
            this.speciesPhotosPageViewModelFactory = speciesPhotosPageViewModelFactory;
        }

        public ActionResult Index(string speciesName)
        {
            return View(this.speciesIndexPageViewModelFactory.Build(speciesName));
        }

        public ActionResult Photos(string speciesName)
        {
            return View(this.speciesPhotosPageViewModelFactory.Build(speciesName));
        }
    }
}
