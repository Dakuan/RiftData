namespace RiftData.Extensions
{
    using System;
    using System.Web;

    public static class HttpRequestExtensions
    {
        public static Uri UrlOriginal(this HttpRequestBase request)
        {
            var hostHeader = request.Headers["host"];

            return new Uri(
                string.Format(
                    "{0}://{1}{2}",
                    request.Url.Scheme,
                    hostHeader,
               request.RawUrl));
        }
    }
}