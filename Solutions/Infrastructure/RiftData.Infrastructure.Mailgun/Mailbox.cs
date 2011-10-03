namespace RiftData.Infrastructure.Mailgun
{
    using System.IO;
    using System.Net;
    using System.Xml;

    /// <summary>
    ///     Mailbox captures all mail arriving to it's address.
    ///     Email will be stored on the server and can be later accessed via IMAP or POP3                                                                                   
    ///     protocols.                                                                                                                                                
    ///                                                                                                                                                           
    ///     Mailbox has several properties:                                                                                                                           
    ///                                                                                                                                                           
    ///     alex@gmail.com                                                                                                                                            
    ///     ^      ^                                                                                                                                                 
    ///     |      |                                                                                                                                                 
    ///     user    domain                                                                                                                                            
    ///                                                                                                                                                           
    ///     and a password                                                                                                                                            
    ///                                                                                                                                                           
    ///     user and domain can not be changed for an existing mailbox.
    /// </summary>
    public class Mailbox : MailgunResourceUpsertable<Mailbox>
    {
        private static readonly ResourceInfo _resInfo = new ResourceInfo("mailboxes", "mailbox");

        public Mailbox()
        {
        }

        /// <summary>
        ///     Construct the Mailbox.
        /// </summary>
        /// <param name = "user">
        /// </param>
        /// <param name = "domain">
        /// </param>
        /// <param name = "password">
        /// </param>
        public Mailbox(string user, string domain, string password)
        {
            this.User = user;
            this.Domain = domain;
            this.Password = password;
        }

        public string Domain { get; set; }

        public string Password { get; set; }

        public string Size { get; set; }

        public string User { get; set; }

        public static void UpsertFromCsv(byte[] mailboxes)
        {
            HttpWebRequest wr = Mailgun.OpenRequest(Mailgun.ApiUrl + "mailboxes.txt", "POST");
            wr.ContentLength = mailboxes.Length;
            wr.ContentType = "text/plain";
            using (Stream rs = Mailgun.GetRequestStream(wr))
            {
                rs.Write(mailboxes, 0, mailboxes.Length);
            }

            using (Mailgun.SendRequest(wr))
            {
            }
        }

        public override string ToString()
        {
            return string.Format("Mailbox({0}@{1} {2})", this.User, this.Domain, this.Size);
        }

        internal override ResourceInfo getResourceInfo()
        {
            return _resInfo;
        }

        protected override bool onReadProperty(string propName, object propVal)
        {
            if (base.onReadProperty(propName, propVal))
            {
                return true;
            }

            switch (propName)
            {
                case "user":
                    this.User = (string)propVal;
                    return true;
                case "domain":
                    this.Domain = (string)propVal;
                    return true;
                case "size":
                    this.Size = (string)propVal;
                    return true;
                default:
                    return false;
            }
        }

        protected override void writeInnerXml(XmlWriter xw)
        {
            base.writeInnerXml(xw);
            this.writeARProperty(xw, "user", this.User);
            this.writeARProperty(xw, "domain", this.Domain);
            this.writeARProperty(xw, "password", this.Password);
        }

        // our target is C# 2.0, don't use "structure initialization syntax"
    }
}