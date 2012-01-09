namespace RiftData.Classes
{
    using System;
    using System.Web;

    public static class UrlHelper
    {
        public static string ToPublicUrl(Uri relativeUri, HttpRequestBase request)
        {
            var httpContext = request.RequestContext.HttpContext;

            if (httpContext.Request.Url != null)
            {
                var uriBuilder = new UriBuilder
                    {
                        Host = httpContext.Request.Url.Host,
                        Path = "/",
                        Port = 80,
                        Scheme = "http",
                    };

                if (httpContext.Request.IsLocal)
                {
                    uriBuilder.Port = httpContext.Request.Url.Port;
                }

                return new Uri(uriBuilder.Uri, relativeUri).AbsoluteUri;
            }

            return null;
        }
    }
}