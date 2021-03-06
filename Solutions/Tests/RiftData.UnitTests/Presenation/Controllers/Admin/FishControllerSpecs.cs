﻿////-------------------------------------------------------------------------------------------------
//// <auto-generated> 
//// Marked as auto-generated so StyleCop will ignore BDD style tests
//// </auto-generated>
////-------------------------------------------------------------------------------------------------

//using RiftData.Domain.Enums;
//using RiftData.Presentation.Contracts.ViewModelFactories.Admin;
//using RiftData.Presentation.ViewModels.Admin;
//using RiftData.Presentation.ViewModels.Admin.Fish;
//using System.Collections.Generic;
//using System.Web.Mvc;
//using Machine.Specifications;
//using Machine.Specifications.AutoMocking.Rhino;
//using Machine.Specifications.Mvc;
//using Rhino.Mocks;
//using RiftData.Areas.Admin.Controllers;
//using RiftData.Domain.Entities;
//using RiftData.Domain.Repositories;

//#pragma warning disable 169
//// ReSharper disable InconsistentNaming
//// ReSharper disable UnusedMember.Global
//// ReSharper disable UnusedMember.Local

//namespace RiftData.UnitTests.Presenation.Controllers.Admin
//{
//    public class FishControllerSpecs

//    {
//        public class context_for_fish_controller : Specification<FishController>
//        {
//            protected static IFishEditPageViewModelFactory the_fish_edit_page_view_model_factory;

//            protected static IFishPageViewModelFactory the_fish_page_view_model_factory;

//            protected static IFishRepository the_fish_repository;

//            protected static IPhotosRepository the_photo_repository;

//            protected static ISpeciesRepository the_species_respository;

//            private Establish context = () =>
//                {
//                    the_fish_page_view_model_factory = DependencyOf<IFishPageViewModelFactory>();

//                    the_fish_edit_page_view_model_factory = DependencyOf<IFishEditPageViewModelFactory>();

//                    the_fish_repository = DependencyOf<IFishRepository>();

//                    the_species_respository = DependencyOf<ISpeciesRepository>();

//                    the_photo_repository = DependencyOf<IPhotosRepository>();
//                };
//        }

//        [Subject(typeof(FishController))]
//        public class when_the_fish_controller_is_asked_for_the_get_species_action : context_for_fish_controller
//        {
//            static ActionResult result;

//            static SelectList the_select_list;

//            static List<Species> the_species_list;

//            Establish context = () =>
//                {
//                    the_species_list = new List<Species>();

//                    the_species_respository.Stub(x => x.GetSpeciesWithGenus(1)).Return(the_species_list);
//                };

//            Because of = () => result = subject.GetSpecies(1);

//            It should_ask_the_species_repository_for_the_list_of_fish = () => the_species_respository.AssertWasCalled(x => x.GetSpeciesWithGenus(1));

//            It should_return_the_species_select_list_as_json = () => ((JsonResult)result).Data.ShouldBeOfType<SelectList>();
//        }

//        [Subject(typeof(FishController))]
//        public class when_the_fish_controller_is_asked_for_the_index_action_with_a_null_ID : context_for_fish_controller
//        {
//            private static ActionResult result;

//            private static FishIndexPageViewModel the_view_model;

//            private Establish context = () =>
//                {
//                    the_view_model = new FishIndexPageViewModel();

//                    the_fish_page_view_model_factory.Stub(c => c.Build(1)).Return(the_view_model);
//                };

//            private Because of = () => result = subject.Index(null);

//            private It should_ask_the_view_model_factory_for_the_view_model = () => the_fish_page_view_model_factory.AssertWasCalled(x => x.Build(1));

//            private It should_pass_the_view_model_to_the_view = () => result.ShouldBeAView().And().ViewData.Model.ShouldEqual(the_view_model);

//            private It should_return_the_default_view = () => result.ShouldBeAView().And().ViewName.ShouldEqual(string.Empty);
//        }

//        [Subject(typeof(FishController))]
//        public class when_the_fish_controller_is_asked_for_the_index_action_with_an_ID : context_for_fish_controller
//        {
//            private static ActionResult result;

//            private static FishIndexPageViewModel the_view_model;

//            private Establish context = () =>
//                {
//                    the_view_model = new FishIndexPageViewModel();

//                    the_fish_page_view_model_factory.Stub(c => c.Build(1)).Return(the_view_model);
//                };

//            private Because of = () => result = subject.Index(1);

//            private It should_ask_the_view_model_factory_for_the_view_model = () => the_fish_page_view_model_factory.AssertWasCalled(x => x.Build(1));

//            private It should_pass_the_view_model_to_the_view = () => result.ShouldBeAView().And().ViewData.Model.ShouldEqual(the_view_model);

//            private It should_return_the_default_view = () => result.ShouldBeAView().And().ViewName.ShouldEqual(string.Empty);
//        }

//        [Subject(typeof(FishController))]
//        public class when_the_fish_controller_is_asked_for_the_create_action : context_for_fish_controller
//        {
//            static ActionResult result;

//            static FishEditPageViewModel the_view_model;

//            Establish context = () =>
//                                            {
//                                                the_view_model = new FishEditPageViewModel(1);

//                                                the_fish_edit_page_view_model_factory.Stub(c => c.Build(1, null)).Return(the_view_model);
//                                            };

//            Because of = () => result = subject.Create(true);

//            It should_ask_the_view_model_factory_for_the_view_model = () => the_fish_edit_page_view_model_factory.AssertWasCalled(x => x.Build(1, null));

//            It should_pass_the_view_model_to_the_view = () => result.ShouldBeAView().And().ViewData.Model.ShouldEqual(the_view_model);

//            It should_return_the_default_view = () => result.ShouldBeAView().And().ViewName.ShouldEqual(string.Empty);
//        }

//        [Subject(typeof(FishController))]
//        public class when_the_fish_controller_is_asked_to_create_the_fish : context_for_fish_controller
//        {
//            static ActionResult result;

//            static Fish the_add_result;

//            Establish context = () =>
//                                    {
//                                        the_add_result = new Fish();

//                                        the_fish_repository.Stub(x => x.Add(1, 1, 1, string.Empty)).Return(the_add_result);
//                                    };

//            Because of = () => result = subject.Create(new FishEditFormViewModel());

//            It should_ask_the_fish_respository_to_add_a_fish = () => the_fish_repository.AssertWasCalled(x => x.Add(1, 1, 1, string.Empty));

//            It should_return_the_result_as_json = () => ((JsonResult)result).Data.ShouldBeOfType<SelectList>();
//        }
//    }
//}