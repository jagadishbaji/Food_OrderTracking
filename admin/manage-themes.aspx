<%@ Page Language="C#" AutoEventWireup="true" CodeFile="manage-themes.aspx.cs" Inherits="admin_manage_themes" %>

<%@ Register Src="~/admin/header.ascx" TagPrefix="uc1" TagName="header" %>
<%@ Register Src="~/admin/sidemenu.ascx" TagPrefix="uc1" TagName="sidemenu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage items</title>
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
                    <h1>Manage Theme
                       
                        <small>Add images to display at customer screens</small>
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="dashboard.aspx"><i class="fa fa-dashboard"></i>Home</a></li>
                        <li class="active">Manage Theme</li>
                    </ol>
                </section>

                <!-- Main content -->
                <section class="content">

                    <div class="container">
                        <div class="col-lg-4">
                            <div class="box box-info">
                                <div class="box-header">
                                    <i class="glyphicon glyphicon-plus-sign"></i>&nbsp;&nbsp;&nbsp;
                                    <h3 class="box-title">Add Theme</h3>
                                </div>
                                <div id="server-message"></div>
                                <div class="box-body">
                                    <div class="form-group">
                                        <label>Name</label>
                                        <asp:TextBox ID="txt_name" CssClass="form-control" placeholder="Name" runat="server"></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label>Upload Image</label>
                                        <asp:FileUpload ID="fu_image" CssClass="form-control btn-file" runat="server" />
                                    </div>
                                    
                                </div>
                                <div class="box-footer clearfix">
                                    <asp:LinkButton ID="lnk_save" class="pull-right btn btn-default" OnClick="lnk_save_Click" runat="server">Save <i class="fa fa-arrow-circle-right"></i></asp:LinkButton>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="box box-info">
                                <div class="box-header">
                                    <i class="glyphicon glyphicon-plus-sign"></i>&nbsp;&nbsp;&nbsp;
                                    <h3 class="box-title">Set Theme</h3>
                                </div>
                                <div id="server-message"></div>
                                <div class="box-body">
                                    <div class="form-group">
                                        <label>Select Theme</label>
                                        <asp:DropDownList ID="ddl_themes" CssClass="form-control" runat="server"></asp:DropDownList>
                                    </div>
                                    <div class="form-group">
                                        <asp:Image ID="img_preview" runat="server" />
                                    </div>
                                    
                                </div>
                                <div class="box-footer clearfix">
                                    <asp:LinkButton ID="lnk_settheme" class="pull-right btn btn-default" OnClick="lnk_settheme_Click" runat="server">Set Theme &nbsp;<i class="fa fa-arrow-circle-right"></i></asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-12">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <td>Title</td>                                        
                                        <td align="center">Delete</td>
                                    </tr>
                                </thead>

                                <asp:Repeater ID="rpt_items" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td><%# Eval("theme_name") %></td>                                            
                                            <td align="center">
                                                <asp:LinkButton ID="lnk_delete" OnClientClick="return confirm('Are you sure to delete this file?')" OnClick="lnk_delete_Click" CommandArgument='<%# Eval("theme_id") %>' CssClass="btn btn-danger" runat="server"> <i class="fa fa-trash-o"></i> </asp:LinkButton></td>
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
            
        </script>
    </form>
</body>
</html>
