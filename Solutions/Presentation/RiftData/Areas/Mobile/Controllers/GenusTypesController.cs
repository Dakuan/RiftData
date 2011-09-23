namespace RiftData.Areas.Mobile.Controllers
{
    using System.Web.Mvc;

    using RiftData.Presentation.Contracts.ViewModelFactories.Mobile;

    [OutputCache(CacheProfile = "Daily")]
    public class GenusTypesController : Controller
    {
        private readonly IGenusTypesIndexPageViewModelFactory genusTypesIndexPageViewModelFactory;

        public GenusTypesController(IGenusTypesIndexPageViewModelFactory genusTypesIndexPageViewModelFactory)
        {
            this.genusTypesIndexPageViewModelFactory = genusTypesIndexPageViewModelFactory;
        }

        public ActionResult Index(string genusTypeName)
        {
            return View(this.genusTypesIndexPageViewModelFactory.Build(genusTypeName));
        }
    }
}