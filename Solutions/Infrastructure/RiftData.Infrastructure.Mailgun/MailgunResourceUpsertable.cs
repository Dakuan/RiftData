namespace RiftData.Infrastructure.Mailgun
{
    /// <summary>
    ///     Provide Upsert() custom resource method
    /// </summary>
    /// <typeparam name = "T"></typeparam>
    public abstract class MailgunResourceUpsertable<T> : MailgunResource<T>
        where T : MailgunResourceUpsertable<T>, new()
    {
        ///<summary>
        ///    There are 2 differences between Upsert() and Save(). 
        ///    - Upsert does not throw exception if object already exist. 
        ///    - Upsert does not load Id property of the object. 
        ///
        ///    It ensures that resource exists on the server and does not syncronize client object instance.
        ///    In order to modify "upserted" object, you need to Find() it first.
        ///    Upsert() is designed to simplify resource creation, when you want to skip existing resources.
        ///</summary>
        public void Upsert()
        {
            this.update(Mailgun.ApiUrl + this.collectionName + "/upsert.xml", "POST", false);
        }
    }
}