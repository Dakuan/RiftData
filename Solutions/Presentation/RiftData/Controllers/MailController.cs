namespace RiftData.Controllers
{
    using RiftData.Presentation.Contracts.Mailer;

    using System.Web.Mvc;

    public class MailController : Controller
    {
        private readonly IMailer mailer;

        public MailController(IMailer mailer)
        {
            this.mailer = mailer;
        }

        public ActionResult Send(string message, string name, string email)
        {
            this.mailer.SendHelpOffer(message, name, email);

            return new JsonResult { JsonRequestBehavior = JsonRequestBehavior.AllowGet };
        }
    }
}