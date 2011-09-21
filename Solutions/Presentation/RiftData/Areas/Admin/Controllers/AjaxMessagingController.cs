namespace RiftData.Areas.Admin.Controllers
{
    using System.Web.Mvc;

    using RiftData.Presentation.ViewModels.Admin;

    public class AjaxMessagingController : Controller
    {
        public ActionResult Loading()
        {
            return this.PartialView("AjaxLoading");
        }

        public ActionResult UpdateFailure(string subject, string okAction, string okController)
        {
            var vm = new MessageBoxViewModel { Message = "Oops! Something went wrong, the " + subject.ToLower() + " wasn't updated", OkAction = okAction, OkController = okController };

            return this.PartialView("AjaxMessage", vm);
        }

        public ActionResult UpdateSuccess(string subject, string okAction, string okController)
        {
            var vm = new MessageBoxViewModel { Message = subject + " successfully updated", OkAction = okAction, OkController = okController };

            return this.PartialView("AjaxMessage", vm);
        }
    }
}