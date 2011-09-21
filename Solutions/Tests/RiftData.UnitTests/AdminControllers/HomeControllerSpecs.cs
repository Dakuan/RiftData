﻿//-------------------------------------------------------------------------------------------------
// <auto-generated> 
// Marked as auto-generated so StyleCop will ignore BDD style tests
// </auto-generated>
//-------------------------------------------------------------------------------------------------

#pragma warning disable 169
// ReSharper disable InconsistentNaming
// ReSharper disable UnusedMember.Global
// ReSharper disable UnusedMember.Local

namespace RiftData.UnitTests.AdminControllers
{
    using System.Web.Mvc;

    using Machine.Specifications;
    using Machine.Specifications.AutoMocking.Rhino;
    using Machine.Specifications.Mvc;

    using RiftData.Areas.Admin.Controllers;
    using RiftData.Presentation.ViewModels.Admin;

    public class HomeControllerSpecs
    {
        public class context_for_home_controller_specifications : Specification<HomeController>
        {
        }

        [Subject(typeof(HomeController))]
        public class when_the_home_controller_is_asked_for_the_index_action : context_for_home_controller_specifications
        {
            private static ActionResult result;

            private static HomePageViewModel the_view_model;

            private Establish context = () => { the_view_model = new HomePageViewModel(); };

            private Because of = () => result = subject.Index();

            private It should_return_the_default_view = () => result.ShouldBeAView().And().ViewName.ShouldEqual(string.Empty);

            // It should_pass_the_view_model_to_the_view = () => result.ShouldBeAView().And().ViewData.Model.ShouldEqual(the_view_model);
        }
    }
}