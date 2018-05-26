<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="customer_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Welcome</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <link href="../css/customer.css" rel="stylesheet" />
    <style>
        body.modal-open #wrap { -webkit-filter: blur(7px); -moz-filter: blur(15px); -o-filter: blur(15px); -ms-filter: blur(15px); filter: blur(15px); }
        /*body { background:url(../themes/3329e406-d594-4ca0-8b1c-3485fa7586b0.jpg) no-repeat 0 300px;
        }*/
        .modal-backdrop { background: #f7f7f7; }
        .cart { position: absolute; top: 0; right: 10px; padding: 20px; border-radius: 0 0 50px 50px; border: 1px solid #ddd; z-index: 1; }
            .cart a { color: #000; }
        
        .row ,.container-fluid,.side-body *{ background:transparent!important;overflow:hidden;}
        .productbox { background:#FFF!important}
        video#bgvid { position: fixed; top: 50%; left: 50%; min-width: 100%; min-height: 100%; width: auto; height: auto; z-index: -100; -webkit-transform: translateX(-50%) translateY(-50%); transform: translateX(-50%) translateY(-50%); background: url(../img/logo.png) no-repeat; background-size: cover; }
        body { background-size:100%;}
    </style>
    <script src="../js/jquery.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
       
        <asp:Panel ID="pnl_cart" CssClass="cart" runat="server">
             <br /><br />
            <i class="glyphicon glyphicon-shopping-cart"></i>
            <asp:LinkButton ID="lnk_cart" OnClick="lnk_cart_Click" runat="server" Text="0"></asp:LinkButton>
        </asp:Panel>
        <asp:HiddenField ID="hf_orderid" runat="server" />
        <asp:Panel ID="pnl_table" runat="server">
            <div class="center-block">
                <div class="col-lg-4">
                    <div class="form-inline">
                        <asp:TextBox ID="txt_table" placeholder="Enter table number" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:Button ID="btn_table" OnClick="btn_table_Click" CssClass="btn btn-info" runat="server" Text="Save" />
                    </div>
                </div>
            </div>
        </asp:Panel>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <Triggers>
                <asp:PostBackTrigger ControlID="lnk_search" />
            </Triggers>
            <ContentTemplate>
                <asp:Panel ID="pnl_page" runat="server">
                    <div class="row">
                        <!-- uncomment code for absolute positioning tweek see top comment in css -->
                        <!-- <div class="absolute-wrapper"> </div> -->
                        <!-- Menu -->
                        <div class="side-menu">

                            <nav class="navbar navbar-default" role="navigation">
                                <!-- Brand and toggle get grouped for better mobile display -->
                                <div class="navbar-header">
                                    <div class="brand-wrapper">
                                        <!-- Hamburger -->
                                        <button type="button" class="navbar-toggle">
                                            <span class="sr-only">Toggle navigation</span>
                                            <span class="icon-bar"></span>
                                            <span class="icon-bar"></span>
                                            <span class="icon-bar"></span>
                                        </button>

                                        <!-- Brand -->
                                        <div class="brand-name-wrapper">
                                            <a class="navbar-brand" href="#">Digital
                                            </a>
                                        </div>

                                        <!-- Search -->
                                        <a data-toggle="collapse" href="#search" class="btn btn-default" id="search-trigger">
                                            <span class="glyphicon glyphicon-search"></span>
                                        </a>

                                        <!-- Search body -->
                                        <div id="search" class="panel-collapse collapse">
                                            <div class="panel-body">
                                                <div class="navbar-form" role="search">
                                                    <div class="form-group">
                                                        <asp:TextBox ID="txt_search" class="form-control" placeholder="Search" runat="server"></asp:TextBox>
                                                    </div>
                                                    <asp:LinkButton ID="lnk_search" class="btn btn-default " OnClick="lnk_search_Click" runat="server"><span class="glyphicon glyphicon-ok"></span></asp:LinkButton>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>

                                <!-- Main Menu -->
                                <div class="side-menu-container">
                                    <ul class="nav navbar-nav">
                                        <li>
                                            <asp:LinkButton ID="lnk_combos" OnClick="lnk_combos_Click" runat="server"><span class="glyphicon glyphicon-send"></span>Combos</asp:LinkButton>
                                        </li>
                                        <asp:Repeater ID="rpt_category" runat="server">
                                            <ItemTemplate>
                                                <li>
                                                    <asp:LinkButton ID="lnk_category" CommandArgument='<%# Eval("category_id") %>' CommandName='<%# Eval("category_name") %>' OnClick="lnk_category_Click" runat="server"><span class="glyphicon glyphicon-send"></span> <%# Eval("category_name") %></asp:LinkButton>
                                                </li>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </ul>
                                </div>
                                <!-- /.navbar-collapse -->
                            </nav>

                        </div>

                        <!-- Main Content -->
                        <div class="container-fluid">
                            <div class="side-body">
                                <asp:Panel ID="pnl_combo" runat="server">
                                    <div class="col-lg-12">
                                        <h1>Combos</h1>
                                        <asp:Repeater ID="rpt_combos" runat="server" OnItemCommand="rpt_combos_ItemCommand">
                                            <ItemTemplate>
                                                <div class="col-lg-3 productbox">
                                                    <div class="img-thumbnail">
                                                        <img src='<%# "../project_files/combos/" + Eval("combo_picture") %>' class="img-responsive" />
                                                    </div>
                                                    <div class="product-title"><%# Eval("title") %></div>
                                                    <div class="product-price">
                                                        <asp:HiddenField ID="hf_price" Value=' <%# Eval("price") %>' runat="server" />
                                                        <%# Eval("price") %> INR
                                            <div class="form-inline">
                                                <div class="form-group">
                                                    <asp:TextBox ID="txt_qty" placeholder="QTY" CssClass="form-control" runat="server"></asp:TextBox>
                                                    <asp:LinkButton ID="lnk_okcombo" CommandArgument='<%# Eval("Combo_id") %>' runat="server"><span class="glyphicon glyphicon-send"></span></asp:LinkButton>
                                                </div>
                                            </div>
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>


                                    </div>
                                </asp:Panel>
                                <asp:Panel ID="pnl_items" runat="server">
                                    <div class="col-lg-12">
                                        <h1>
                                            <asp:Label ID="lbl_category" runat="server" Text=""></asp:Label></h1>
                                        <asp:Repeater ID="rpt_items" runat="server" OnItemCommand="rpt_items_ItemCommand">
                                            <ItemTemplate>
                                                <div class="col-lg-3 productbox">
                                                    <div class="img-thumbnail">
                                                        <img src='<%# "../project_files/items/" + Eval("item_image") %>' class="img-responsive" />
                                                    </div>
                                                    <div class="product-title"><%# Eval("item_name") %></div>
                                                    <div class="product-price">
                                                        <asp:HiddenField ID="hf_price" Value=' <%# Eval("price") %>' runat="server" />
                                                        <%# Eval("price") %> INR
                                            <div class="form-inline">
                                                <div class="form-group">
                                                    <asp:TextBox ID="txt_qty" placeholder="QTY" CssClass="form-control" runat="server"></asp:TextBox>
                                                    <asp:LinkButton ID="lnk_okItem" CommandArgument='<%# Eval("item_id") %>' runat="server"><span class="glyphicon glyphicon-send"></span></asp:LinkButton>
                                                </div>
                                            </div>
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                </asp:Panel>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>

        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <Triggers>
                <asp:PostBackTrigger ControlID="btn_neworder" />
            </Triggers>
            <ContentTemplate>
                <asp:Panel ID="pnl_neworder" runat="server">

                    <video autoplay loop poster="../img/logo.png" id="bgvid">
                        <source src="intro.mp4" type="video/mp4">
                    </video>
                    <div class="text-center">
                        <asp:Button ID="btn_neworder" OnClick="btn_neworder_Click" runat="server" Style="position: absolute; top: 50%; background: rgba(0,0,0,0.2); border: 4px solid #fff; color: #fff; padding: 5px 20px; font-size: 25px;" Text="New Order" />
                    </div>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>


        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
                <%--<asp:Timer ID="tmr_new" OnTick="tmr_new_Tick" Interval="5000" runat="server"></asp:Timer>--%>
            </ContentTemplate>
        </asp:UpdatePanel>


        <button class="btn btn-primary btn-lg" style="position: fixed; bottom: 5px; right: 10px;" data-toggle="modal" data-target="#ModalSongs">
            Show Playlist
        </button>

        <!-- Modal -->
        <div class="modal fade" id="modalCart" tabindex="-1" role="dialog" aria-labelledby="cartModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="cartModalLabel">Order Summary</h4>
                    </div>
                    <div class="modal-body">
                        <asp:HiddenField ID="order_details_id" runat="server" />
                        <asp:Repeater ID="rpt_invoice" runat="server">
                            <HeaderTemplate>
                                <table class="table table-condensed table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <td>SL #</td>
                                            <td>Item Name</td>
                                            <td>Price</td>
                                            <td>Qty</td>
                                            <td>Total</td>
                                            <td>Delete</td>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td><%# Container.ItemIndex +1 %></td>
                                    <td><%# Eval("itemname") %></td>
                                    <td><%# Eval("price") %></td>
                                    <td><%# Eval("qty") %></td>
                                    <td class="amount"><%# Eval("amount") %></td>
                                    <td>
                                        <asp:LinkButton ID="LinkButton1" CommandArgument='<%#Eval("order_detailid") %>' OnClick="LinkButton1_Click" runat="server">Cancel</asp:LinkButton></td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </tbody>
                                <tr>
                                    <td colspan="3"></td>
                                    <td>Grand Total</td>
                                    <td class="grandtotal"></td>
                                </tr>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
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



        <div class="modal fade" id="ModalSongs" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-body" style="overflow: hidden">
                        <div class="col-lg-12">
                            <ul>
                                <asp:UpdatePanel ID="upnl_songs" UpdateMode="Conditional" runat="server">
                                    <ContentTemplate>
                                        <asp:Repeater ID="rpt_playlist" runat="server">
                                            <ItemTemplate>
                                                <li class='<%# "list-group-item text-left "+Eval("is_playing") %>'><%# Eval("song_name") %>
                                                    <span data-id='<%# Eval("song_id") %>' class="badge pull-right play-song" style='<%# "cursor:pointer;"+Eval("is_requested")%>'>Play this </span>
                                                </li>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                        <asp:Timer ID="tmr_songs" OnTick="tmr_songs_Tick" Interval="15000" runat="server"></asp:Timer>

                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

        </div>



        <script src="../js/bootstrap.min.js"></script>
        <script>
            $(function () {
                $('.navbar-toggle').click(function () {
                    $('.navbar-nav').toggleClass('slide-in');
                    $('.side-body').toggleClass('body-slide-in');
                    $('#search').removeClass('in').addClass('collapse').slideUp(200);

                    /// uncomment code for absolute positioning tweek see top comment in css
                    //$('.absolute-wrapper').toggleClass('slide-in');

                });

                // Remove menu for searching
                $('#search-trigger').click(function () {
                    $('.navbar-nav').removeClass('slide-in');
                    $('.side-body').removeClass('body-slide-in');

                    /// uncomment code for absolute positioning tweek see top comment in css
                    //$('.absolute-wrapper').removeClass('slide-in');

                });
                setInterval(function () {
                    var options = {
                        type: "POST",
                        url: "default.aspx/isClosed",
                        data: '{"orderid":"' + $("#hf_orderid").val() + '"}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            if (data.d == "True")
                                window.location = "default.aspx";
                            // alert(data);
                        }
                    };
                    $.ajax(options);
                }, 20000);

            });
            function calc() {
                var gt = 0;
                $(".amount").each(function () {
                    gt += parseFloat($(this).text());
                });
                $(".grandtotal").text(gt);
            }

        </script>
        <script>
            var prm = Sys.WebForms.PageRequestManager.getInstance();
            prm.add_pageLoaded(pageLoaded);



            function pageLoaded() {
                $(".play-song").on("click", function () {
                    $this = $(this);
                    var options = {
                        type: "POST",
                        url: "default.aspx/play_song",
                        data: '{"songid":"' + $this.data("id") + '"}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            $this.hide();
                        }
                    };
                    $.ajax(options);
                });
            }

        </script>
        <script>
            $("body").css("background", "url(../themes/<%= background %>) repeat 0 290px");
            //alert('s');
        </script>
    </form>
</body>
</html>
