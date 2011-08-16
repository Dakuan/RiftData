namespace RiftData.Presentation.Contracts
{
    using ViewModels;

    public interface IFishPageViewModelFactory
    {
        FishPageViewModel Build(string fishName);
    }
}