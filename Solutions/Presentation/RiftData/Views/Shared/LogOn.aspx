<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Admin.Master" Inherits="System.Web.Mvc.ViewPage<RiftData.Presentation.ViewModels.Admin.LogOnModel>" %>

<asp:Content ID="loginTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Log On
</asp:Content>

<asp:Content ID="loginContent" ContentPlaceHolderID="MainContent" runat="server">


    <form method="post" class="form label-inline">
        <%:this.Html.ValidationSummary(true, "Login was unsuccessful. Please correct the errors and try again.")%>
                
        <div class="field">
            <%:this.Html.LabelFor(m => m.UserName)%>
            <%:this.Html.TextBoxFor(m => m.UserName)%>
            <%:this.Html.ValidationMessageFor(m => m.UserName)%>
        </div>
                
        <div class="field">
            <%:this.Html.LabelFor(m => m.Password)%>
            <%:this.Html.PasswordFor(m => m.Password)%>
            <%:this.Html.ValidationMessageFor(m => m.Password)%>
        </div>
                
        <div class="field">
            <%:this.Html.CheckBoxFor(m => m.RememberMe)%>
            <%:this.Html.LabelFor(m => m.RememberMe)%>
        </div>
        <button class="azurebutton">
            <span>Log on</span>
        </button>

    </form>
</asp:Content>