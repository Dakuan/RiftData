<%@ Page Language="C#" MasterPageFile="Site.Master" Inherits="System.Web.Mvc.ViewPage<RiftData.Presentation.ViewModels.Admin.Account.ChangePasswordModel>" %>

<asp:Content ID="changePasswordTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Change Password
</asp:Content>

<asp:Content ID="changePasswordContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Change Password</h2>
    <p>
        Use the form below to change your password. 
    </p>
    <p>
        New passwords are required to be a minimum of <%:this.ViewData["PasswordLength"]%> characters in length.
    </p>

    <% using (this.Html.BeginForm())
       {%>
    <%:this.Html.ValidationSummary(true, "Password change was unsuccessful. Please correct the errors and try again.")%>
    <div>
        <fieldset>
            <legend>Account Information</legend>
                
            <div class="editor-label">
                <%:this.Html.LabelFor(m => m.OldPassword)%>
            </div>
            <div class="editor-field">
                <%:this.Html.PasswordFor(m => m.OldPassword)%>
                <%:this.Html.ValidationMessageFor(m => m.OldPassword)%>
            </div>
                
            <div class="editor-label">
                <%:this.Html.LabelFor(m => m.NewPassword)%>
            </div>
            <div class="editor-field">
                <%:this.Html.PasswordFor(m => m.NewPassword)%>
                <%:this.Html.ValidationMessageFor(m => m.NewPassword)%>
            </div>
                
            <div class="editor-label">
                <%:this.Html.LabelFor(m => m.ConfirmPassword)%>
            </div>
            <div class="editor-field">
                <%:this.Html.PasswordFor(m => m.ConfirmPassword)%>
                <%:this.Html.ValidationMessageFor(m => m.ConfirmPassword)%>
            </div>
                
            <p>
                <input type="submit" value="Change Password" />
            </p>
        </fieldset>
    </div>
    <% } %>
</asp:Content>