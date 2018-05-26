<%@ Page Language="C#" AutoEventWireup="true" CodeFile="add-combo.aspx.cs" Inherits="admin_add_combo" %>

<%@ Register Src="~/admin/header.ascx" TagPrefix="uc1" TagName="header" %>
<%@ Register Src="~/admin/sidemenu.ascx" TagPrefix="uc1" TagName="sidemenu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Combo</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>

    <link href="../css/bootstrap.min.css" rel="stylesheet" type="text/css" />

    <link href="../css/font-awesome.min.css" rel="stylesheet" type="text/css" />

    <link href="../css/ionicons.min.css" rel="stylesheet" type="text/css" />

    <link href="../css/admin-section.css" rel="stylesheet" type="text/css" />
    <link href="../css/custom.css" rel="stylesheet" type="text/css" />
    <link href="../js/plugins/croppic/css/croppic.css" rel="stylesheet" />
    <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
          <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
        <![endif]-->
</head>
<body class="skin-black">
    <form id="form1" runat="server">
        <uc1:header runat="server" ID="header" />
        <div class="wrapper row-offcanvas row-offcanvas-left">
            <uc1:sidemenu runat="server" ID="sidemenu" />
            <!-- This is the place to put all your content -->
            <aside class="right-side">
                <!-- Heading section of page -->
                <section class="content-header">
                    <h1>Manage Combos
                       
                        <small>Add offers</small>
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="dashboard.aspx"><i class="fa fa-dashboard"></i>Home</a></li>
                        <li class="active">Manage Combos</li>
                    </ol>
                </section>

                <!-- Main content -->
                <section class="content">

                    <div class="container">
                        <div class="col-lg-4">
                            <div class="box box-info">
                                <div class="box-header">
                                    <i class="glyphicon glyphicon-lock"></i>
                                    <h3 class="box-title">Add Combos</h3>
                                </div>
                                <div id="server-message"></div>
                                <div class="box-body">
                                    <div class="form-group">
                                        <label>Title</label>
                                        <asp:TextBox ID="txt_title" CssClass="form-control" placeholder="Title" runat="server"></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label>Description</label>
                                        <asp:TextBox ID="txt_desc" CssClass="form-control" placeholder="Description" TextMode="MultiLine" runat="server"></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label>Price</label>
                                        <asp:TextBox ID="txt_price" CssClass="form-control" placeholder="Price" runat="server"></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label>Picture</label>
                                        <asp:FileUpload ID="fu_picture" CssClass="form-control" runat="server" />
                                    </div>
                                </div>
                                <div class="box-footer clearfix">
                                    <asp:LinkButton ID="lnk_save" class="pull-right btn btn-default" OnClick="lnk_save_Click" runat="server">Save <i class="fa fa-arrow-circle-right"></i></asp:LinkButton>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="col-lg-12">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <td>Title</td>
                                        <td>Description</td>
                                        <td>Price</td>
                                        <td>Picture</td>
                                        <td align="center">Delete</td>
                                    </tr>
                                </thead>

                                <asp:Repeater ID="rpt_combos" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td><%# Eval("title") %></td>
                                            <td><%# Eval("description") %></td>
                                            <td align="right"><%# Eval("price") %></td>
                                            <td><a href="#" class="btn btn-flat show-picture" data-url='<%# Eval("combo_picture") %>'>View picture</a></td>
                                            <td align="center">
                                                <asp:LinkButton ID="lnk_delete" OnClick="lnk_delete_Click" CommandArgument='<%# Eval("combo_id") %>' OnClientClick="return confirm('Are you sure to delete this file?')" CssClass="btn btn-danger" runat="server"><i class="fa fa-trash-o"></i> </asp:LinkButton></td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </table>
                        </div>
                </section>
                <!-- Main content -->
            </aside>
            <!-- All content section ends here-->
        </div>


        <div class="modal fade" id="modal-image" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">Combo Image</h4>
                    </div>
                    <div class="modal-body">
                        <img alt="Combo Image" class="img-responsive" id="combo_image" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>                       
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->

        <script src="../js/jquery.js"></script>
        <!-- Bootstrap -->
        <script src="../js/bootstrap.min.js"></script>
        <!-- AdminLTE App -->
        <script src="../js/AdminLTE/app.js"></script>
        <script>
            function showalert(type, message) {
                if (type == "success")
                    var content = '<div class="alert alert-success alert-dismissable"><i class="fa fa-check"></i><button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button><b>Success!</b> ' + message + '.</div>';
                if (type == "error")
                    var content = '<div class="alert alert-danger alert-dismissable"><i class="fa fa-ban"></i><button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button><b>Alert!</b> ' + message + '.</div>';
                if (type == "warning")
                    var content = '<div class="alert alert-warning alert-dismissable"><i class="fa fa-warning"></i><button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button><b>Warning!</b> ' + message + '.</div>';

                $("#server-message").empty().append(content);
            }

            $(".show-picture").click(function (e) {
                $("#combo_image").attr("src", "../project_files/combos/"+ $(this).data("url"));
                $("#modal-image").modal('show');
                e.preventDefault();
            });
        </script>
    </form>
</body>
</html>
