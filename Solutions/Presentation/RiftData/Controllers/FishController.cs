using System;

namespace RiftData.Controllers
{
    using System.Web.Mvc;

    using RiftData.Presentation.Contracts;

    [OutputCache(CacheProfile = "Daily")]
    public class FishController : Controller
    {
        private readonly IFishPageViewModelFactory fishPageViewModelFactory;

        public FishController(IFishPageViewModelFactory fishPageViewModelFactory)
        {
            this.fishPageViewModelFactory = fishPageViewModelFactory;
        }

        public ActionResult Index(string fishName)
        {
            try
            {
                var viewModel = this.fishPageViewModelFactory.Build(fishName);

                return View(viewModel);
            }
            catch (Exception)
            {
                //todo, log this
                return RedirectToAction("NoFish", "Error");
            }
        }
    }
}