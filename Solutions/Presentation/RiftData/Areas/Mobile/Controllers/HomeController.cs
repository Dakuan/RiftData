namespace RiftData.Areas.Mobile.Controllers
{
    using System.Web.Mvc;

    using RiftData.Presentation.Contracts.ViewModelFactories.Mobile;

    [OutputCache(CacheProfile = "Daily")]
    public class HomeController : Controller
    {
        private readonly IHomeIndexPageViewModelFactory homeIndexPageViewModelFactory;

        public HomeController(IHomeIndexPageViewModelFactory homeIndexPageViewModelFactory)
        {
            this.homeIndexPageViewModelFactory = homeIndexPageViewModelFactory;
        }

        public ActionResult Index()
        {
            return View(this.homeIndexPageViewModelFactory.Build());
        }
    }
}
