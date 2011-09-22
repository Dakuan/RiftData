using RiftData.Presentation.Contracts.ViewModelFactories.Admin;

namespace RiftData.Areas.Admin.Controllers
{
    using System.Web.Mvc;

    [Authorize]
    public class HomeController : Controller
    {
        private readonly IHomePageViewModelFactory homePageViewModelFactory;

        public HomeController(IHomePageViewModelFactory homePageViewModelFactory)
        {
            this.homePageViewModelFactory = homePageViewModelFactory;
        }

        public ActionResult Index()
        {
            var viewModel = this.homePageViewModelFactory.Build();

            return this.View(viewModel);
        }
    }
}