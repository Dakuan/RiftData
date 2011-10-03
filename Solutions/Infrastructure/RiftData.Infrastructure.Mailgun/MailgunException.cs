namespace RiftData.Infrastructure.Mailgun
{
    using System;
    using System.Net;
    using System.Runtime.InteropServices;

    [Serializable]
    [ComVisible(true)]
    public class MailgunException : ApplicationException
    {
        public MailgunException(string message)
            : base(message)
        {
        }

        public MailgunException(string message, Exception inner)
            : base(message, inner)
        {
        }

        public static MailgunException Wrap(WebException ex)
        {
            // Mailgun provides detailed error message in HTTP status line.
            //
            // WebException.ToString() overrides status description for standard
            // HTTP codes such as 404 (Not found), 409 (Conflict), 500 (Internal error).
            //
            // Fortunately, in .NET we can see what is wrong as follows:
            var response = ex.Response as HttpWebResponse;
            if (response != null)
            {
                string message = string.Format("{0} {1}", (int)response.StatusCode, response.StatusDescription);
                return new MailgunException(message, ex);
            }
            else
            {
                return new MailgunException(ex.Message, ex);
            }
        }
    }
}