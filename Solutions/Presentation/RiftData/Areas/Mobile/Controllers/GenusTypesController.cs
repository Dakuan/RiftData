using System.Web.Mvc;
using RiftData.Presentation.Contracts.ViewModelFactories.Mobile;

namespace RiftData.Areas.Mobile.Controllers
{
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