<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="admin_Default" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Please Login</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        
        <link href="../css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        
        <link href="../css/ionicons.min.css" rel="stylesheet" type="text/css" />
        
        <link href="../css/admin-section.css" rel="stylesheet" type="text/css" />
        <link href="../css/custom.css" rel="stylesheet" type="text/css" />
    <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
          <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
        <![endif]-->    
</head>
<body>
    <form id="form1" runat="server">
        <p class="clearfix"></p><p class="clearfix"></p>
        <div class="container">
            <div class="col-lg-4 center-block text-center">
                <h3>ORDER TRACKING</h3>
            </div>
        </div>
        <p class="clearfix"></p>
        <div class="container">
            <div class="col-lg-4 center-block">
                <div class="box box-info">
                    <div class="box-header">
                        <i class="glyphicon glyphicon-lock"></i>
                        <h3 class="box-title">Login</h3>
                    </div>
                    <div id="server-message"></div>
                    <div class="box-body">
                        <div class="form-group">
                            <asp:TextBox ID="txt_emailid" runat="server" class="form-control" placeholder="Email ID"></asp:TextBox>                            
                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="txt_pwd" runat="server" class="form-control" placeholder="Password" TextMode="Password"></asp:TextBox>                            
                        </div>
                        <div class="form-group">
                            <label>
                                <asp:CheckBox ID="chk_remember" runat="server" /> Remember Me
                            </label>
                        </div>
                    </div>

                    <div class="box-footer clearfix">
                        <%--<a href="register.aspx">Register</a>&nbsp;|&nbsp;--%>
                        <a href="forgot-password.aspx">Forgot password?</a>
                        <asp:LinkButton ID="lnk_login" class="pull-right btn btn-default" OnClick="lnk_login_Click" runat="server">Sign In <i class="fa fa-arrow-circle-right"></i></asp:LinkButton>                        
                    </div>
                </div>
            </div>
        </div>
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