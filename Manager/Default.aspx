<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Manager_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Welcome</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .playing { background: #0094ff !important; color: #fff !important; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="col-lg-12">
            <div class="row">
                <div class="col-lg-12">
                    <div class="col-lg-8">
                        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                        <asp:UpdatePanel ID="upnl_repeater" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:Repeater ID="rpt_tables" runat="server" OnItemDataBound="rpt_tables_ItemDataBound">
                                    <ItemTemplate>
                                        <div class="col-md-4">
                                            <div class="panel panel-info">
                                                <div class="panel-heading">
                                                    <h4 class="text-center">Table #<%#Eval("tableNumber") %></h4>
                                                    <asp:HiddenField ID="hf_orderid" Value='<%# Eval("order_id") %>' runat="server" />
                                                </div>
                                                <ul class="list-group list-group-flush text-center">
                                                    <asp:Repeater ID="rpt_items" runat="server">
                                                        <ItemTemplate>
                                                            <li class="list-group-item clearfix text-left"><%# Eval("itemname") %> <span class="pull-right badge"><%# Eval("qty") %> * <%# Eval("price") %> = <%# Eval("amount") %></span></li>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                    <li class="list-group-item clearfix text-left">Total <span class="pull-right badge"><%# Eval("amount") %></span></li>
                                                </ul>
                                                <div class="panel-footer">
                                                    <asp:LinkButton ID="lnkCheckout" OnClick="lnkCheckout_Click" CommandArgument='<%# Eval("order_id") %>' runat="server" class="btn btn-lg btn-block btn-info">Checkout</asp:LinkButton>
                                                </div>
                                            </div>
                                        </div>

                                    </ItemTemplate>
                                </asp:Repeater>
                                <asp:Timer runat="server" Interval="15000" ID="tm_list" OnTick="tm_list_Tick"></asp:Timer>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <div class="col-lg-4">
                        <div class="player">
                            <audio controls="controls" id="audio_player">                                
                                Your browser does not support the audio element.
                            </audio>
                        </div>
                        <div class="playlist">
                            <ul class="list-group" id="songs_list">
                                <asp:UpdatePanel ID="upnl_songs" UpdateMode="Conditional" runat="server">
                                    <ContentTemplate>
                                        <asp:Repeater ID="rpt_playlist" runat="server">
                                            <ItemTemplate>
                                                <li class='<%# "list-group-item text-left "+Eval("is_playing") %>' data-id='<%# Eval("song_id") %>' data-url='<%# Eval("song_url") %>'><%# Eval("song_name") %></li>
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
        <script src="../js/jquery.js"></script>
        <script>
            var audio = document.getElementById("audio_player");
            audio.src = "../songs/"+$("#songs_list li:first").data("url");
            audio.play();            
            var options = {
                type: "POST",
                url: "default.aspx/song_status",
                data: '{"song_id":"' + $("#songs_list li:first").data("id") + '","status":"1"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $("#songs_list li:first").addClass("playing");
                }
            };
            $.ajax(options);

            audio.onended = function () {

                var options = {
                    type: "POST",
                    url: "default.aspx/song_status",
                    data: '{"song_id":"' + $("#songs_list li.playing").data("id") + '","status":"2"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {                       
                    }
                };
                $.ajax(options);

                $next = $("#songs_list li.playing").next("li");
                $("#songs_list li.playing").removeClass("playing");
                audio.src = "../songs/" + $next.data("url");
                audio.play();
               

               var options = {
                   type: "POST",
                   url: "default.aspx/song_status",
                   data: '{"song_id":"' + $next.data("id") + '","status":"1"}',
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   success: function (data) {
                       $next.addClass("playing");
                   }
               };
               $.ajax(options);



            }

        </script>
    </form>
</body>
</html>
