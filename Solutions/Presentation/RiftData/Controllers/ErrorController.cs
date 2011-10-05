using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RiftData.Presentation.Contracts;

namespace RiftData.Controllers
{
    public class ErrorController : Controller
    {
        private readonly IInfoPageViewModelFactory infoPageViewModelFactory;

        public ErrorController(IInfoPageViewModelFactory infoPageViewModelFactory)
        {
            this.infoPageViewModelFactory = infoPageViewModelFactory;
        }

        public ActionResult NoFish()
        {
            var viewModel = this.infoPageViewModelFactory.Build();

            viewModel.Description = "Oh noes! Something went wrong!";

            viewModel.Keywords = "Rift valley cichlids";

            return View(viewModel);
        }
    }
}
