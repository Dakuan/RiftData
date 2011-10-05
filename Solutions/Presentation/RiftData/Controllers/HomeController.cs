namespace RiftData.Controllers
{
    using System;
    using System.IO.Compression;
    using System.Web;
    using System.Web.Mvc;

    using RiftData.Attributes;
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

            try
            {
                var viewModel = this.homePageViewModelFactory.Build(genusTypeName);

                return View(viewModel);
            }
            catch(Exception)
            {
                //todo, log this
                return RedirectToAction("NoFish", "Error");
            }
        }
    }
}