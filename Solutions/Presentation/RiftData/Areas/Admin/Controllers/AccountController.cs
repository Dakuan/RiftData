namespace RiftData.Areas.Admin.Controllers
{
    using System.Web.Mvc;
    using System.Web.Routing;
    using System.Web.Security;

    using RiftData.Presentation.ViewModels.Admin;

    [HandleError]
    public class AccountController : Controller
    {
        public IFormsAuthenticationService FormsService { get; set; }

        public IMembershipService MembershipService { get; set; }

        [Authorize]
        public ActionResult ChangePassword()
        {
            this.ViewData["PasswordLength"] = this.MembershipService.MinPasswordLength;
            return this.View();
        }

        [Authorize]
        [HttpPost]
        public ActionResult ChangePassword(ChangePasswordModel model)
        {
            if (this.ModelState.IsValid)
            {
                if (this.MembershipService.ChangePassword(this.User.Identity.Name, model.OldPassword, model.NewPassword))
                {
                    return this.RedirectToAction("ChangePasswordSuccess");
                }
                else
                {
                    this.ModelState.AddModelError(
                        string.Empty, "The current password is incorrect or the new password is invalid.");
                }
            }

            // If we got this far, something failed, redisplay form
            this.ViewData["PasswordLength"] = this.MembershipService.MinPasswordLength;
            return View(model);
        }

        // **************************************
        // URL: /Account/ChangePasswordSuccess
        // **************************************
        public ActionResult ChangePasswordSuccess()
        {
            return this.View();
        }

        public ActionResult LogOff()
        {
            this.FormsService.SignOut();

            return this.RedirectToAction("Index", "Home");
        }

        // **************************************
        // URL: /Account/LogOn
        // **************************************
        public ActionResult LogOn()
        {
            return this.View();
        }


        [HttpPost]
        public ActionResult LogOn(LogOnModel model, string returnUrl)
        {
            if (this.ModelState.IsValid)
            {
                if (this.MembershipService.ValidateUser(model.UserName, model.Password))
                {
                    this.FormsService.SignIn(model.UserName, model.RememberMe);
                    if (!string.IsNullOrEmpty(returnUrl))
                    {
                        return this.Redirect(returnUrl);
                    }
                    else
                    {
                        return this.RedirectToAction("Index", "Home");
                    }
                }
                else
                {
                    this.ModelState.AddModelError(string.Empty, "The user name or password provided is incorrect.");
                }
            }

            // If we got this far, something failed, redisplay form
            return View(model);
        }


        // **************************************
        // URL: /Account/LogOff
        // **************************************

        // **************************************
        // URL: /Account/Register
        // **************************************
        [Authorize(Roles = "Admin")]
        public ActionResult Register()
        {
            this.ViewData["PasswordLength"] = this.MembershipService.MinPasswordLength;
            return this.View();
        }

        [HttpPost]
        [Authorize(Roles = "Admin")]
        public ActionResult Register(RegisterModel model)
        {
            if (this.ModelState.IsValid)
            {
                // Attempt to register the user
                MembershipCreateStatus createStatus = this.MembershipService.CreateUser(
                    model.UserName, model.Password, model.Email);

                if (createStatus == MembershipCreateStatus.Success)
                {
                    this.FormsService.SignIn(model.UserName, false /* createPersistentCookie */);
                    return this.RedirectToAction("Index", "Home");
                }
                else
                {
                    this.ModelState.AddModelError(string.Empty, AccountValidation.ErrorCodeToString(createStatus));
                }
            }

            // If we got this far, something failed, redisplay form
            this.ViewData["PasswordLength"] = this.MembershipService.MinPasswordLength;
            return View(model);
        }

        protected override void Initialize(RequestContext requestContext)
        {
            if (this.FormsService == null)
            {
                this.FormsService = new FormsAuthenticationService();
            }

            if (this.MembershipService == null)
            {
                this.MembershipService = new AccountMembershipService();
            }

            base.Initialize(requestContext);
        }

        // **************************************
        // URL: /Account/ChangePassword
        // **************************************
    }
}