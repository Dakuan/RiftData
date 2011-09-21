namespace RiftData.Areas.Admin.Controllers
{
    using System.Web;
    using System.Web.Mvc;

    using RiftData.Presentation.Contracts.Admin;

    [Authorize]
    public class PhotosController : Controller
    {
        private readonly IPhotosService photosService;

        public PhotosController(IPhotosService photosService)
        {
            this.photosService = photosService;
        }

        public ActionResult Cancel(string Id)
        {
            if (Id != null)
            {
                this.photosService.DeletePhoto(Id);
            }

            return new JsonResult { JsonRequestBehavior = JsonRequestBehavior.AllowGet };
        }

        public ActionResult Index()
        {
            return this.PartialView("PhotoUploaderContent");
        }

        public ActionResult Save(HttpPostedFileBase attachments, int id)
        {
            // save photo to flickr  
            var photo = this.photosService.SavePhoto(attachments, id);

            if (photo != null)
            {
                return this.Json(new { url = photo.ThumbNailUrl, status = "ok", flickrid = photo.FlickrId, photoid = photo.Id }, "text/plain");
            }

            return this.Json(new { url = string.Empty, status = "failed" }, "text/plain");
        }
    }
}