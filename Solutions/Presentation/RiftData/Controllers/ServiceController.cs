using System.Web.Mvc;

namespace RiftData.Controllers
{
    using System.Linq;

    using RiftData.ApplicationServices.DtoServices.Contracts;

    public class ServiceController : Controller
    {
        private readonly IGenusDtoService genusDtoService;

        private readonly ISpeciesDtoService speciesDtoService;
		
		private readonly ILocaleDtoService localeDtoService;

        public ServiceController(IGenusDtoService genusDtoService, ISpeciesDtoService speciesDtoService, ILocaleDtoService localeDtoService)
        {
            this.genusDtoService = genusDtoService;
            this.speciesDtoService = speciesDtoService;
			this.localeDtoService = localeDtoService;
        }

        public ActionResult GetAllGenera()
        {
            var results = this.genusDtoService.GetGenusDtos();

            results.ToList().ForEach(g => g.Species.Clear());

            return new JsonResult { JsonRequestBehavior = JsonRequestBehavior.AllowGet, Data = results };
        }

        public ActionResult GetSpeciesForGenus(int id)
        {
            return new JsonResult
                {
                    JsonRequestBehavior = JsonRequestBehavior.AllowGet,
                    Data = this.speciesDtoService.GetSpeciesWithGenus(id)
                };
        }
		
		public ActionResult GetLocalesForZoomLevel(int id)
		{
			return new JsonResult{
				JsonRequestBehavior = JsonRequestBehavior.AllowGet,
				Data = this.localeDtoService.GetLocalesForZoomLevel(id)
			};
		}
    }
}
