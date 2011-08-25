using System.Web.Mvc;

namespace RiftData.Controllers
{
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
            return new JsonResult { JsonRequestBehavior = JsonRequestBehavior.AllowGet, Data = this.genusDtoService.GetGenusDtos() };
        }
    }
}
