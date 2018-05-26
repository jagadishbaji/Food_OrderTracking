<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Kitchen_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Welcome</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <meta http-equiv="refresh" content="15" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row">
                <asp:Repeater ID="rpt_tables" runat="server" OnItemDataBound="rpt_tables_ItemDataBound">
                    <ItemTemplate>
                        <div class="col-md-4">
                            <div class="panel panel-info">
                                <div class="panel-heading">
                                    <h4 class="text-center">Table #<%#Eval("tableNumber") %></h4>
                                    <asp:HiddenField ID="hf_orderid" Value='<%# Eval("order_id") %>' runat="server" />
                                </div>
                                <asp:Repeater ID="rpt_items" runat="server">
                                    <ItemTemplate>
                                        <ul class="list-group list-group-flush text-center">
                                            <li class="list-group-item clearfix text-left"><%# Eval("itemname") %> <span class="pull-right badge"><%# Eval("qty") %></span></li>                                           
                                        </ul>
                                    </ItemTemplate>
                                </asp:Repeater>

                                <%--<div class="panel-footer">
                                    <a class="btn btn-lg btn-block btn-info">Purchase</a>
                                </div>--%>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>


            </div>
        </div>
    </form>
</body>
</html>
