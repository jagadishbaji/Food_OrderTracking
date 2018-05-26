using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_logout : System.Web.UI.Page
{
    /// <summary>
    /// logout and clears session
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        Session.Clear();
        Response.Redirect("default.aspx");
    }
}