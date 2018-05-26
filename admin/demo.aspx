<%@ Page Language="C#" AutoEventWireup="true" CodeFile="demo.aspx.cs" Inherits="admin_demo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Label ID="Label1" runat="server"  Font-Size="X-Large" Font-Bold="True"></asp:Label>
        ENTER NAME :&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="name" runat="server"></asp:TextBox>
        <br />
        <br />
        <br />
        eMAIL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="email" runat="server" ></asp:TextBox>
        <br />
        <br />
        MOBILE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="mobile" runat="server"></asp:TextBox>
        <br />
        <br />
        <br />
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Button" />
        <br />
        <br />
    
    </div>
    </form>
</body>
</html>
