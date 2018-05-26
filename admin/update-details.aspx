<%@ Page Language="C#" AutoEventWireup="true" CodeFile="update-details.aspx.cs" Inherits="admin_update_details" %>

<%@ Register Src="~/admin/header.ascx" TagPrefix="uc1" TagName="header" %>
<%@ Register Src="~/admin/sidemenu.ascx" TagPrefix="uc1" TagName="sidemenu" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8"/>
        <title>Order Tracking</title>
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
                    <h1>Update Details
                       
                        <small>Change personal details</small>
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="dashboard.aspx"><i class="fa fa-dashboard"></i>Home</a></li>
                        <li class="active">Change details</li>
                    </ol>
                </section>

                <!-- Main content -->
                <section class="content">

                    <div class="container">
                        <div class="col-lg-4">
                            <div class="box box-info">
                                <div class="box-header">
                                    <i class="glyphicon glyphicon-lock"></i>
                                    <h3 class="box-title">Change Details</h3>
                                </div>
                                <div id="server-message"></div>
                                <div class="box-body">
                                    <div class="form-group">
                                        <label>Full Name</label>
                                        <asp:TextBox ID="txt_fullname" CssClass="form-control" placeholder="Full Name" runat="server"></asp:TextBox>                                        
                                    </div>
                                    <div class="form-group">
                                        <label>Email ID</label>
                                        <asp:TextBox ID="txt_emailid" CssClass="form-control" placeholder="Email ID" runat="server"></asp:TextBox>
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
                                    <i class="glyphicon glyphicon-lock"></i>
                                    <h3 class="box-title">Profile Picture</h3>
                                </div>
                                <div class="box-body">
                                    <div id="croppicProfilePicture" class="croppicImageCrop" style="width: 240px; height: 240px;background:url(../project_files/<%= (Session["Adminlogin_details"] as Adminlogin_details).profile_pic%>)"></div>
                                </div>
                                <div class="box-footer clearfix">
                                </div>                                
                            </div>
                        </div>
                    </div>
                </section>
                <!-- Main content -->
            </aside>
            <!-- All content section ends here-->
        </div>        
        <script src="../js/jquery.js"></script>
        <!-- Bootstrap -->
        <script src="../js/bootstrap.min.js"></script>
        
        <!-- AdminLTE App -->
        <script src="../js/AdminLTE/app.js"></script> 
        <script src="../js/plugins/croppic/js/croppic.min.js"></script>
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
            var croppicHeaderOptions = {
                uploadUrl: '../processors/save_image.ashx',
                cropUrl: '../processors/crop.ashx',
                doubleZoomControls: false,
                cropData: {
                    "profile_pic": "true",
                    "instance_id": "<%= Session["admin_id"].ToString() %>"
                },
                uploadData: {
                    "type": "profile"
                },                
                modal: false,
                loaderHtml: '<div class="loader bubblingG"><span id="bubblingG_1"></span><span id="bubblingG_2"></span><span id="bubblingG_3"></span></div>',
                onAfterImgCrop: function () {
                    
                }
            }

            var croppicManager = new Croppic('croppicProfilePicture', croppicHeaderOptions);
        </script>       
    </form>
</body>
</html>
