<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Admin.Master" Inherits="System.Web.Mvc.ViewPage<RiftData.Presentation.ViewModels.Admin.LogOnModel>" %>

<asp:Content ID="loginTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Log On
</asp:Content>

<asp:Content ID="loginContent" ContentPlaceHolderID="MainContent" runat="server">


        <form method="post" class="form label-inline">
        <%: Html.ValidationSummary(true, "Login was unsuccessful. Please correct the errors and try again.") %>
                
                <div class="field">
                    <%: Html.LabelFor(m => m.UserName) %>
                    <%: Html.TextBoxFor(m => m.UserName) %>
                    <%: Html.ValidationMessageFor(m => m.UserName) %>
                </div>
                
                <div class="field">
                    <%: Html.LabelFor(m => m.Password) %>
                    <%: Html.PasswordFor(m => m.Password) %>
                    <%: Html.ValidationMessageFor(m => m.Password) %>
                </div>
                
                <div class="field">
                    <%: Html.CheckBoxFor(m => m.RememberMe) %>
                    <%: Html.LabelFor(m => m.RememberMe) %>
                </div>
                <button class="azurebutton">
                    <span>Log on</span>
                </button>

        </form>
</asp:Content>
