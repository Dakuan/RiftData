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

        public ActionResult Index()
        {
            var viewModel = this.homePageViewModelFactory.Build();

            return View(viewModel);
        }
    }
}