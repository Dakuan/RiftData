using System.Web.Mvc;
using RiftData.Presentation.ViewModels.Admin;

namespace RiftData.Areas.Admin.Controllers
{
    [Authorize]
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View(new HomePageViewModel());
        }
    }
}