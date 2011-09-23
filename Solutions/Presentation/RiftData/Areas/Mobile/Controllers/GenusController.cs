namespace RiftData.Areas.Mobile.Controllers
{
    using System.Web.Mvc;

    using RiftData.Presentation.Contracts.ViewModelFactories.Mobile;

    [OutputCache(CacheProfile = "Daily")]
    public class GenusController : Controller
    {
        private readonly IGenusIndexPageViewModelFactory genusIndexPageViewModelFactory;

        public GenusController(IGenusIndexPageViewModelFactory genusIndexPageViewModelFactory)
        {
            this.genusIndexPageViewModelFactory = genusIndexPageViewModelFactory;
        }

        public ActionResult Index(string genusName)
        {
            return View(this.genusIndexPageViewModelFactory.Build(genusName));
        }
    }
}
