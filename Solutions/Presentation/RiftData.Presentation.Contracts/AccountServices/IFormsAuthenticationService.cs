namespace RiftData.Presentation.Contracts.AccountServices
{
    public interface IFormsAuthenticationService
    {
        void SignIn(string userName, bool createPersistentCookie);

        void SignOut();
    }
}