using System.Web;
using System.Web.Mvc;
using RiftData.Presentation.Contracts.Admin;

namespace RiftData.Areas.Admin.Controllers
{
     [Authorize]
    public class PhotosController : Controller
    {
        private readonly IPhotosService photosService;

        public PhotosController(IPhotosService photosService)
        {
            this.photosService = photosService;
        }

        public ActionResult Index()
        {
            return PartialView("PhotoUploaderContent");
        }

        public ActionResult Save(HttpPostedFileBase attachments, int id)
        {
            //save photo to flickr  
            var photo = this.photosService.SavePhoto(attachments, id);

            if (photo != null)
            {
                return Json(new { url = photo.ThumbNailUrl , status = "ok", flickrid = photo.FlickrId, photoid = photo.Id }, "text/plain");
            }
            else
            {
                return Json(new { url = string.Empty, status = "failed" }, "text/plain");
            }
        }

        public ActionResult Cancel(string Id)
        {
            if (Id != null)
            {
                photosService.DeletePhoto(Id.ToString());
            }

            return new JsonResult { JsonRequestBehavior = JsonRequestBehavior.AllowGet };
        }
    }
}