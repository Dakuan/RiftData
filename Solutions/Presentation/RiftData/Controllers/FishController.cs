using System.Web.Mvc;

namespace RiftData.Controllers
{
    public class FishController : Controller
    {
        public ActionResult Index(string fishName)
        {
            return View();
        }
    }
}