using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_update_details : System.Web.UI.Page
{
    string st = "";
    mydb db=new mydb();
    /// <summary>
    /// 
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
    /// Updates the Admin details
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void lnk_save_Click(object sender, EventArgs e)
    {
        st = "update tbl_admin set admin_name='"+txt_fullname.Text+"',emailid='"+txt_emailid.Text+"' where admin_id='"+Session["admin_id"].ToString()+"'";
        int x=db.ExeQuery(st);
        if(x>0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "showalert('success','Details Updated successfully.');", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "showalert('error','Updation failed please try later.');", true);
        }
    }
}