namespace RiftData.ApplicationServices.ViewModelFactories.Admin
{
    using System.Web;

    using RiftData.Domain.Repositories;
    using RiftData.Presentation.Contracts.Admin.LakePages;
    using RiftData.Presentation.ViewModels.Admin.Lake;

    public class LakeUpdatePageViewModelFactory : ILakeUpdatePageViewModelFactory
    {
        private readonly ILakeRepository lakeRepository;

        public LakeUpdatePageViewModelFactory(ILakeRepository lakeRepository)
        {
            this.lakeRepository = lakeRepository;
        }

        public LakeUpdatePageViewModel Build(int lakeId)
        {
            var lake = this.lakeRepository.Get(lakeId);

            return new LakeUpdatePageViewModel { Description = HttpUtility.HtmlDecode(lake.Description), Id = lake.Id, Name = lake.Name };
        }
    }
}