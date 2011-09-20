namespace RiftData.Areas.Admin.Controllers
{
    using System.Web.Mvc;

    using RiftData.Presentation.ViewModels.Admin;

    [Authorize]
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            var viewModel = new HomePageViewModel();

            return this.View(viewModel);
        }
    }
}