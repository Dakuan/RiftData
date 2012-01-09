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
            return this.Tweet("New", "fish", url, BuildHashTags(newFish.Genus.GenusType.Name, newFish.Locale.Lake.Name));
        }

        public bool PostFishUpdate(Fish fish, string url)
        {
            return this.Tweet("Updated", "fish", url, BuildHashTags(fish.Genus.GenusType.Name, fish.Locale.Lake.Name));
        }

        private static string BuildHashTags(string genusTypeName, string lakeName)
        {
            return string.Format("#RiftData #{0} #Lake{1}", genusTypeName, lakeName);
        }

        private bool Tweet(string action, string subject, string url, string hashTags)
        {
            var message = string.Format("{0} {1}: {2} {3}", action, subject, url, hashTags);

            using (var twitterContext = new TwitterContext(this.authorizer))
            {
                var status = twitterContext.UpdateStatus(message, true);

                return status != null;
            }
        }
    }
}