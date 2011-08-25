using System.Web.Mvc;

namespace RiftData.Controllers
{
    using System.Linq;

    using RiftData.ApplicationServices.DtoServices.Contracts;

    public class ServiceController : Controller
    {
        private readonly IGenusDtoService genusDtoService;

        public ServiceController(IGenusDtoService genusDtoService)
        {
            this.genusDtoService = genusDtoService;
        }

        public ActionResult GetAllGenera()
        {
            var results = this.genusDtoService.GetGenusDtos();

            results.ToList().ForEach(g => g.Species.Clear());

            return new JsonResult { JsonRequestBehavior = JsonRequestBehavior.AllowGet, Data = this.genusDtoService.GetGenusDtos() };
        }
    }
}
