using RiftData.Domain.Enums;
using RiftData.Presentation.Contracts.Mailer;

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
        private readonly IMailer mailer;

        public HomeController(IHomePageViewModelFactory homePageViewModelFactory, IMailer mailer)
        {
            this.homePageViewModelFactory = homePageViewModelFactory;
            this.mailer = mailer;
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
            catch(Exception exception)
            {
                //todo, log this
                this.mailer.LogNotFound(genusTypeName, ItemType.GenusType);

                return RedirectToAction("NoFish", "Error");
            }
        }
    }
}