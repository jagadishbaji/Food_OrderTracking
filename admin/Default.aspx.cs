using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_Default : System.Web.UI.Page
{
    mydb db = new mydb();
    string st = "";
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            if (db.chk_data("select 1 from tbl_hoteldetails") <= 0)
            {
                Response.Redirect("set-up.aspx");
            }
            if (Request.Cookies["OTA_emailid"] != null && Request.Cookies["QTA_password"] != null)
            {
                txt_emailid.Text = Request.Cookies["OTA_emailid"].Value;
                txt_pwd.Attributes["value"] = Request.Cookies["QTA_password"].Value;
                chk_remember.Checked = true;
            }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void lnk_login_Click(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        st = "select admin_id,profile_pic,is_superadmin,offers_combos,inform_before_activate,item_details,admin_name from tbl_admin where emailid='" + txt_emailid.Text + "' and admin_password='" + txt_pwd.Text + "'";
        dt = db.get_datatable(st);
        if (dt.Rows.Count > 0)
        {
            Session["admin_id"] = dt.Rows[0][0].ToString();
            Adminlogin_details objAdminlogin_details = new Adminlogin_details();
           objAdminlogin_details.inform_before_activate = Boolean.Parse(dt.Rows[0]["inform_before_activate"].ToString());
            objAdminlogin_details.is_superadmin = Boolean.Parse(dt.Rows[0]["is_superadmin"].ToString());
            objAdminlogin_details.item_details = Boolean.Parse(dt.Rows[0]["item_details"].ToString());
            objAdminlogin_details.offers_combos = Boolean.Parse(dt.Rows[0]["offers_combos"].ToString());
            objAdminlogin_details.profile_pic = dt.Rows[0]["profile_pic"].ToString();
            objAdminlogin_details.fullname = dt.Rows[0]["admin_name"].ToString();
            Session["Adminlogin_details"] = objAdminlogin_details;
            if (chk_remember.Checked)
            {                
                Response.Cookies["OTA_emailid"].Value = txt_emailid.Text;
                Response.Cookies["QTA_password"].Value = txt_pwd.Text;
                Response.Cookies["OTA_emailid"].Expires = DateTime.Now.AddDays(30);
                Response.Cookies["QTA_password"].Expires = DateTime.Now.AddDays(30);
            }   
            else
            {   
                Response.Cookies["OTA_emailid"].Expires = DateTime.Now.AddDays(-1);
                Response.Cookies["QTA_password"].Expires = DateTime.Now.AddDays(-1);
            }
            Response.Redirect("dashboard.aspx");
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "showalert('error','Login failed');", true);
        }
    }
}