namespace RiftData.Extensions
{
    using System;
    using System.Web;
    using System.Web.Mvc;

    public static class HttpRequestExtensions
    {
        public static Uri UrlOriginal(this HttpRequestBase request)
        {
            var hostHeader = request.Headers["host"];

            return new Uri(string.Format("{0}://{1}{2}", request.Url.Scheme, hostHeader, request.RawUrl));
        }
        public static string ToPublicUrl(this UrlHelper urlHelper, Uri relativeUri)
        {
            var httpContext = urlHelper.RequestContext.HttpContext;

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
    }
}