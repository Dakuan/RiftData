using System;
using RiftData.Domain.Enums;
using RiftData.Presentation.Contracts.Mailer;

namespace RiftData.Controllers
{
    using System.Web.Mvc;

    using RiftData.Presentation.Contracts;

    [OutputCache(CacheProfile = "Daily")]
    public class FishController : Controller
    {
        private readonly IFishPageViewModelFactory fishPageViewModelFactory;
        private readonly IMailer mailer;

        public FishController(IFishPageViewModelFactory fishPageViewModelFactory, IMailer mailer)
        {
            this.fishPageViewModelFactory = fishPageViewModelFactory;
            this.mailer = mailer;
        }

        public ActionResult Index(string fishName)
        {
            try
            {
                var viewModel = this.fishPageViewModelFactory.Build(fishName);

                return View(viewModel);
            }
            catch (Exception exception)
            {
                //todo, log this
                this.mailer.LogNotFound(fishName, ItemType.Fish);

                return RedirectToAction("NoFish", "Error");
            }
        }
    }
}