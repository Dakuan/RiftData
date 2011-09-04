using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using RiftData.ApplicationServices.DtoServices.Contracts;
using RiftData.Presentation.Contracts;
using RiftData.Presentation.ViewModels;

namespace RiftData.ApplicationServices.ViewModelFactories
{
    public class LakeViewModelFactory : ILakeViewModelFactory
    {
        private readonly ILakeDtoService _lakeDtoService;
        private readonly IHeaderViewModelFactory _headerViewModelFactory;

        public LakeViewModelFactory(ILakeDtoService lakeDtoService, IHeaderViewModelFactory headerViewModelFactory)
        {
            _lakeDtoService = lakeDtoService;
            _headerViewModelFactory = headerViewModelFactory;
        }

        public LakeViewModel Build(string lakeName)
        {
            var lake = this._lakeDtoService.GetLakeFromName(lakeName);

            var viewModel = new LakeViewModel
                                {
                                    Lake = lake,
                                    HeaderViewModel = this._headerViewModelFactory.Build(lake)
                                };

            return viewModel;
        }
    }
}