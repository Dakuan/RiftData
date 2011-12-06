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

        private readonly SingleUserAuthorizer authorizer;

        public TwitterService()
        {
            var credentials = new InMemoryCredentials { AccessToken = AccessTokenSecret, ConsumerKey = ConsumerKey, ConsumerSecret = ConsumerSecret, OAuthToken = AccessToken };

            this.authorizer = new SingleUserAuthorizer { Credentials = credentials };
        }

        public bool PostFishAddition(Fish newFish, string url)
        {
            var message = string.Format("New fish: {0} {1} {2}", newFish.Name, url, this.BuildHashTags(newFish.Genus.GenusType.Name, newFish.Locale.Lake.Name));

            using (var twitterContext = new TwitterContext(this.authorizer))
            {
                var status = twitterContext.UpdateStatus(message, true);

                return status != null;
            }
        }

        private string BuildHashTags(string genusTypeName, string lakeName)
        {
            return string.Format("#RiftData #{0} #{1}", genusTypeName, lakeName);
        }
    }
}