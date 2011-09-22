using System.Web.Mvc;
using RiftData.Presentation.Contracts.ViewModelFactories.Mobile;

namespace RiftData.Areas.Mobile.Controllers
{
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
