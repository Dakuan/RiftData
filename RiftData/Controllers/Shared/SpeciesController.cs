using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace RiftData.Controllers.Shared
{
    public class SpeciesController : Controller
    {
        //
        // GET: /Species/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult SpeciesItem()
        {
            return PartialView("SpeciesItem");
        }
    }
}
