using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RiftData.Presentation.Contracts;

namespace RiftData.Controllers
{
    public class InfoController : Controller
    {
        private readonly IInfoPageViewModelFactory _infoPageViewModelFactory;

        public InfoController(IInfoPageViewModelFactory infoPageViewModelFactory)
        {
            _infoPageViewModelFactory = infoPageViewModelFactory;
        }

        public ActionResult HelpUs()
        {
            var viewModel = this._infoPageViewModelFactory.Build();

            return View(viewModel);
        }

        public ActionResult About()
        {
            var viewModel = this._infoPageViewModelFactory.Build();

            return View(viewModel);
        }
    }
}
