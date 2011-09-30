
using RiftData.Domain.Repositories;
using RiftData.Presentation.Contracts.ViewModelFactories.Admin;

namespace RiftData.Areas.Admin.Controllers
{
    using System.Web;
    using System.Web.Mvc;

    [Authorize]
    public class PhotosController : Controller
    {
        private readonly IPhotosRepository photosRepository;
        private readonly IPhotosIndexPageViewModelFactory photosIndexPageViewModelFactory;

        public PhotosController(IPhotosRepository photosRepository, IPhotosIndexPageViewModelFactory photosIndexPageViewModelFactory)
        {
            this.photosRepository = photosRepository;
            this.photosIndexPageViewModelFactory = photosIndexPageViewModelFactory;
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
            return View(this.photosIndexPageViewModelFactory.Build());
        }

        public ActionResult GetPhotoUploader()
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

        public ActionResult AddCaption(string caption, int photoId)
        {
            var result = this.photosRepository.AddCaption(photoId, caption); 

            return new JsonResult
                {
                    Data = result,
                    JsonRequestBehavior = JsonRequestBehavior.AllowGet
                };
        }

        public ActionResult GetCaptionWindowContent()
        {
            return PartialView("PhotoCaptionForm");
        }
    }
}