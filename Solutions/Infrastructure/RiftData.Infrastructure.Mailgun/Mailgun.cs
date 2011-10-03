using System.Reflection;
using System.Runtime.InteropServices;

[assembly: AssemblyTitle("MailgunClient")]
[assembly: AssemblyDescription("Mailgun communication library")]
[assembly: AssemblyCompany("Mailgun")]
[assembly: AssemblyProduct("Mailgun")]
[assembly: AssemblyCopyright("Copyright ©  2010")]
[assembly: AssemblyCulture("")]
[assembly: ComVisible(true)]
[assembly: Guid("0da62158-5036-476c-aca2-61138b6ca3f7")]

// Version information for an assembly consists of the following four values:
//      Major Version
//      Minor Version 
//      Build Number
//      Revision

[assembly: AssemblyVersion("1.0.*")]
[assembly: AssemblyFileVersion("1.0.*")]

namespace RiftData.Infrastructure.Mailgun
{
    using System;
    using System.IO;
    using System.Net;

    /// <summary>
    ///     Mailgun.Init() lets you initialize the library. 
    ///     You need API Key. You may provide API URL if for some reason it differs from standard.
    /// </summary>
    public class Mailgun
    {
        private static string _apiUrl;

        private static CredentialCache _cc;

        internal static string ApiUrl
        {
            get
            {
                if (string.IsNullOrEmpty(_apiUrl))
                {
                    throw new MailgunException("Call Mailgun.Init() first");
                }
                return _apiUrl;
            }
        }

        /// <summary>
        ///     Initialize the library with standard MailGun API URL
        /// </summary>
        /// <param name = "apiKey"></param>
        public static void Init(string apiKey)
        {
            Init(apiKey, "https://mailgun.net/api");
        }

        public static void Init(string apiKey, string apiUrl)
        {
            _apiUrl = apiUrl;
            if (!_apiUrl.EndsWith("/"))
            {
                _apiUrl += "/";
            }
            _cc = new CredentialCache();
            var url = new Uri(_apiUrl);
            _cc.Remove(url, "Basic");
            _cc.Add(url, "Basic", new NetworkCredential("api_key", apiKey));
        }

        internal static Stream GetRequestStream(HttpWebRequest request)
        {
            try
            {
                return request.GetRequestStream();
            }
            catch (WebException ex)
            {
                throw MailgunException.Wrap(ex);
            }
        }

        internal static HttpWebRequest OpenRequest(string url, string method)
        {
            // Expect: 100-continue fails behind transparent squid proxy
            ServicePointManager.Expect100Continue = false;
            var wr = (HttpWebRequest)WebRequest.Create(url);
            wr.Method = method;
            // Turn off proxy auto-detection, it causes long delay on first request
            wr.Proxy = null;
            wr.Credentials = _cc;
            return wr;
        }

        internal static HttpWebResponse SendRequest(HttpWebRequest request)
        {
            try
            {
                return (HttpWebResponse)request.GetResponse();
            }
            catch (WebException ex)
            {
                throw MailgunException.Wrap(ex);
            }
        }
    }
}