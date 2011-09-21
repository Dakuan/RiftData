<%@ Page Language="C#" MasterPageFile="Admin.Master" Inherits="System.Web.Mvc.ViewPage<RiftData.Presentation.ViewModels.Admin.Account.RegisterModel>" %>

<asp:Content ID="registerTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Register
</asp:Content>

<asp:Content ID="registerContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Create a New Account</h2>
    <p>
        Use the form below to create a new account. 
    </p>
    <p>
        Passwords are required to be a minimum of <%:this.ViewData["PasswordLength"]%> characters in length.
    </p>

    <% using (this.Html.BeginForm())
       {%>
    <%:this.Html.ValidationSummary(true, "Account creation was unsuccessful. Please correct the errors and try again.")%>
    <div>
        <fieldset>
            <legend>Account Information</legend>
                
            <div class="editor-label">
                <%:this.Html.LabelFor(m => m.UserName)%>
            </div>
            <div class="editor-field">
                <%:this.Html.TextBoxFor(m => m.UserName)%>
                <%:this.Html.ValidationMessageFor(m => m.UserName)%>
            </div>
                
            <div class="editor-label">
                <%:this.Html.LabelFor(m => m.Email)%>
            </div>
            <div class="editor-field">
                <%:this.Html.TextBoxFor(m => m.Email)%>
                <%:this.Html.ValidationMessageFor(m => m.Email)%>
            </div>
                
            <div class="editor-label">
                <%:this.Html.LabelFor(m => m.Password)%>
            </div>
            <div class="editor-field">
                <%:this.Html.PasswordFor(m => m.Password)%>
                <%:this.Html.ValidationMessageFor(m => m.Password)%>
            </div>
                
            <div class="editor-label">
                <%:this.Html.LabelFor(m => m.ConfirmPassword)%>
            </div>
            <div class="editor-field">
                <%:this.Html.PasswordFor(m => m.ConfirmPassword)%>
                <%:this.Html.ValidationMessageFor(m => m.ConfirmPassword)%>
            </div>
                
            <p>
                <input type="submit" value="Register" />
            </p>
        </fieldset>
    </div>
    <% } %>
</asp:Content>