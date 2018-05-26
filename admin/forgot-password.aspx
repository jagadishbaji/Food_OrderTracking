<%@ Page Language="C#" AutoEventWireup="true" CodeFile="forgot-password.aspx.cs" Inherits="admin_forgot_password" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reset Password</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet" type="text/css" />
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
                        <h3 class="box-title">Forgot Password</h3>
                    </div>
                    <div class="box-body">
                        <div class="form-group">
                            <input type="text" class="form-control" placeholder="Registered Email ID" />
                        </div>                        
                    </div>

                    <div class="box-footer clearfix">
                        <a href="Default.aspx">Sign In</a>&nbsp;|&nbsp;
                        <a href="register.aspx">New Account?</a>
                        <button class="pull-right btn btn-default" id="sendEmail">Reset Password <i class="fa fa-arrow-circle-right"></i></button>
                    </div>
                </div>
            </div>
        </div>

    </form>
</body>
</html>
