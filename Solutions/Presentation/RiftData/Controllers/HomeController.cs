using System.Web.Mvc;
using RiftData.ApplicationServices.ViewModelFactories.Contracts;

namespace RiftData.Controllers
{
    public class HomeController : Controller
    {
        private IHomePageViewModelFactory homePageViewModelFactory;

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