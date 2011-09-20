using RiftData.Presentation.Contracts.Admin;

namespace RiftData.Areas.Admin.Controllers
{
    using System.Web.Mvc;

    using RiftData.Presentation.ViewModels.Admin;

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