<%@ Page Language="C#" AutoEventWireup="true" CodeFile="set-up.aspx.cs" Inherits="admin_set_up" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Set up your account</title>
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
                        <h3 class="box-title">Set up account</h3>
                    </div>
                    <div class="box-body">
                        <div class="form-group">
                            <asp:TextBox ID="txt_hotelname" runat="server" class="form-control" placeholder="Hotel Name"></asp:TextBox>                            
                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="txt_address" TextMode="MultiLine" runat="server" class="form-control" placeholder="Address"></asp:TextBox>                            
                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="txt_subtittle" runat="server" class="form-control" placeholder="Tag Line"></asp:TextBox>                            
                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="txt_emailid" runat="server" class="form-control" placeholder="Email ID"></asp:TextBox>                            
                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="txt_pwd" runat="server" class="form-control" placeholder="Password" TextMode="Password"></asp:TextBox>                            
                        </div>                        
                    </div>

                    <div class="box-footer clearfix">
                        <asp:LinkButton ID="lnk_setup" class="pull-right btn btn-default" OnClick="lnk_setup_Click" runat="server">Finish <i class="fa fa-arrow-circle-right"></i></asp:LinkButton>                        
                    </div>
                </div>
            </div>
        </div>

    </form>
</body>
</html>
