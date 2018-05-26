using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_change_password : System.Web.UI.Page
{
    string st = "";
    mydb db = new mydb();
    /// <summary>
    /// checking the Login Session
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["admin_id"] == null)
        {
            Response.Redirect("default.aspx");
        }
    }
    /// <summary>
    /// updates paasword in database
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void lnk_save_Click(object sender, EventArgs e)
    {
        st = "update tbl_admin set admin_password ='" + txt_newpassword.Text + "' where admin_id=" + Session["admin_id"].ToString() + " and admin_password='" + txt_oldpwd.Text + "'";
        if (db.ExeQuery(st) > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "showalert('success','Password updated successfully');", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "showalert('error','Old password doesn't match');", true);
        }
    }
}