<%@ Page Language="C#" AutoEventWireup="true" CodeFile="service-test.aspx.cs" Inherits="service_test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8"/>
	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>            
</head>
<body>
    <form id="form1" runat="server">
        <div id="Div1"></div>
    
        <script src="js/jquery.js"></script>
        <script>
            
            $(function () {
                //$.support.cors = true;
                $.ajax({
                    type: "GET",
                    url: "http://localhost:50573/Service1.svc/GetPersonsDataPOST",
                    data: '{"id":"1"}',
                    headers: {
                        'Access-Control-Allow-Origin': '*'
                    },
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        alert(response);
                    },
                    error: function (msg) {
                        alert(msg.toString);
                    }
                });

            });


            
        </script>
    </form>
</body>
</html>
