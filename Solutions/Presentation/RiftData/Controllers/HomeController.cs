﻿namespace RiftData.Controllers
{
    using System.Web.Mvc;

    using RiftData.Presentation.Contracts;

    [OutputCache(CacheProfile = "Daily")]
    public class HomeController : Controller
    {
        private readonly IHomePageViewModelFactory homePageViewModelFactory;

        public HomeController(IHomePageViewModelFactory homePageViewModelFactory)
        {
            this.homePageViewModelFactory = homePageViewModelFactory;
        }

        public ActionResult Index(string genusTypeName)
        {
            if (genusTypeName == null)
            {
                genusTypeName = "Mbuna";
            }

            var viewModel = this.homePageViewModelFactory.Build(genusTypeName);

            return View(viewModel);
        }
    }
}