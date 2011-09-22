using RiftData.Domain.Repositories;

namespace RiftData.Areas.Admin.Controllers
{
    using System.Web;
    using System.Web.Mvc;

    [Authorize]
    public class PhotosController : Controller
    {
        private readonly IPhotosRepository photosRepository;

        public PhotosController(IPhotosRepository photosRepository)
        {
            this.photosRepository = photosRepository;
        }

        public ActionResult Cancel(string Id)
        {
            if (Id != null)
            {
                this.photosRepository.Delete(Id);
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
            var photo = this.photosRepository.Add(attachments, id);

            if (photo != null)
            {
                return this.Json(new { url = photo.ThumbNailUrl, status = "ok", flickrid = photo.FlickrId, photoid = photo.Id }, "text/plain");
            }

            return this.Json(new { url = string.Empty, status = "failed" }, "text/plain");
        }
    }
}