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
    using System.Collections.Generic;
    using System.Web.Mvc;

    using Machine.Specifications;
    using Machine.Specifications.AutoMocking.Rhino;
    using Machine.Specifications.Mvc;

    using Rhino.Mocks;

    using RiftData.Areas.Admin.Controllers;
    using RiftData.Domain.Entities;
    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts.Admin.FishPages;
    using RiftData.Presentation.ViewModels.Admin;

    public class FishControllerSpecs
    {
        public class context_for_fish_controller : Specification<FishController>
        {
            protected static IFishEditPageViewModelFactory the_fish_edit_page_view_model_factory;

            protected static IFishPageViewModelFactory the_fish_page_view_model_factory;

            protected static IFishRepository the_fish_repository;

            protected static IPhotosRepository the_photo_repository;

            protected static ISpeciesRepository the_species_respository;

            private Establish context = () =>
                {
                    the_fish_page_view_model_factory = DependencyOf<IFishPageViewModelFactory>();

                    the_fish_edit_page_view_model_factory = DependencyOf<IFishEditPageViewModelFactory>();

                    the_fish_repository = DependencyOf<IFishRepository>();

                    the_species_respository = DependencyOf<ISpeciesRepository>();

                    the_photo_repository = DependencyOf<IPhotosRepository>();
                };
        }

        [Subject(typeof(FishController))]
        public class when_the_fish_controller_is_asked_for_the_get_species_action : context_for_fish_controller
        {
            private static ActionResult result;

            private static SelectList the_select_list;

            private static List<Species> the_species_list;

            private Establish context = () =>
                {
                    the_species_list = new List<Species>();

                    the_species_respository.Stub(x => x.GetSpeciesWithGenus(1)).Return(the_species_list);
                };

            private Because of = () => result = subject.GetSpecies(1);

            private It should_ask_the_species_repository_for_the_list_of_fish = () => the_species_respository.AssertWasCalled(x => x.GetSpeciesWithGenus(1));

            private It should_return_the_species_select_list_as_json = () => ((JsonResult)result).Data.ShouldBeOfType<SelectList>();
        }

        [Subject(typeof(FishController))]
        public class when_the_fish_controller_is_asked_for_the_index_action_with_a_null_ID : context_for_fish_controller
        {
            private static ActionResult result;

            private static FishIndexPageViewModel the_view_model;

            private Establish context = () =>
                {
                    the_view_model = new FishIndexPageViewModel();

                    the_fish_page_view_model_factory.Stub(c => c.Build(1)).Return(the_view_model);
                };

            private Because of = () => result = subject.Index(null);

            private It should_ask_the_view_model_factory_for_the_view_model = () => the_fish_page_view_model_factory.AssertWasCalled(x => x.Build(1));

            private It should_pass_the_view_model_to_the_view = () => result.ShouldBeAView().And().ViewData.Model.ShouldEqual(the_view_model);

            private It should_return_the_default_view = () => result.ShouldBeAView().And().ViewName.ShouldEqual(string.Empty);
        }

        [Subject(typeof(FishController))]
        public class when_the_fish_controller_is_asked_for_the_index_action_with_an_ID : context_for_fish_controller
        {
            private static ActionResult result;

            private static FishIndexPageViewModel the_view_model;

            private Establish context = () =>
                {
                    the_view_model = new FishIndexPageViewModel();

                    the_fish_page_view_model_factory.Stub(c => c.Build(1)).Return(the_view_model);
                };

            private Because of = () => result = subject.Index(1);

            private It should_ask_the_view_model_factory_for_the_view_model = () => the_fish_page_view_model_factory.AssertWasCalled(x => x.Build(1));

            private It should_pass_the_view_model_to_the_view = () => result.ShouldBeAView().And().ViewData.Model.ShouldEqual(the_view_model);

            private It should_return_the_default_view = () => result.ShouldBeAView().And().ViewName.ShouldEqual(string.Empty);
        }
    }
}