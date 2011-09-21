﻿namespace RiftData.Areas.Admin
{
    using System.Web.Mvc;

    public class AdminAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "Admin";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute("Admin_default", "Admin/{controller}/{action}/{id}", new { controller = "Home", action = "Index", id = UrlParameter.Optional }, new[] { "RiftData.Areas.Admin.Controllers" });

            context.MapRoute("Admin_fish", "Admin/Fish/{action}/{id}", new { controller = "Home", action = "Index", id = UrlParameter.Optional }, new[] { "RiftData.Areas.Admin.Controllers" });
        }
    }
}