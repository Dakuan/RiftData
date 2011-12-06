namespace RiftData.ApplicationServices.Twitter
{
    using RiftData.Domain.Entities;

    public interface ITwitterService
    {
        bool PostFishAddition(Fish newFish, string url);
    }
}