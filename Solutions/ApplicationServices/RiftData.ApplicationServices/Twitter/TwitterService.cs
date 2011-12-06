namespace RiftData.ApplicationServices.Twitter
{
    using LinqToTwitter;

    using RiftData.Domain.Entities;

    public class TwitterService : ITwitterService
    {
        private const string ConsumerKey = "2NB93hDFIpVW7ve11SvmPw";

        private const string ConsumerSecret = "AsXIuB2v092E3jZTZZOD16Ox0WcHEpsF3RHFj7Bpo";

        private const string AccessToken = "380849324-JCc29QlJ9MLhyMb9UqZTzBQSdjGeKL4Vnd199yIt";

        private const string AccessTokenSecret = "gprxK0aOrMZJhnpsJy6hc21GSXX7pBEjpsmZxzUqk";

        private SingleUserAuthorizer authorizer;

        public TwitterService()
        {
            var credentials = new InMemoryCredentials { AccessToken = AccessTokenSecret, ConsumerKey = ConsumerKey, ConsumerSecret = ConsumerSecret, OAuthToken = AccessToken };

            this.authorizer = new SingleUserAuthorizer { Credentials = credentials };
        }

        public bool PostFishAddition(Fish newFish, string url)
        {
            var message = string.Format("New fish: {0} {1} #RiftData #{2}", newFish.Name, url, newFish.Genus.GenusType.Name);

            using (var twitterContext = new TwitterContext(this.authorizer))
            {
                var status = twitterContext.UpdateStatus(message, true);

                if (status != null)
                {
                    return true;
                }
                return false;
            }
        }
    }
}