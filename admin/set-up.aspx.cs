using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_set_up : System.Web.UI.Page
{
    string st = "";
    mydb db = new mydb();
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (db.chk_data("select 1 from tbl_hoteldetails") > 0)
            {
                Response.Redirect("default.aspx");
            }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void lnk_setup_Click(object sender, EventArgs e)
    {
        st = "insert into tbl_hoteldetails(hotel_name,sub_title,admin_emailid,password,hotel_address) output inserted.hotel_id values('"+txt_hotelname.Text+"','"+txt_subtittle.Text+"','"+txt_emailid.Text+"','"+txt_pwd.Text+"','"+txt_address.Text+"')";
        int x = db.return_affectedID(st);
        if(x>0)
        {
            st = "insert into tbl_admin(emailid,admin_password,is_superadmin,is_active,created_by) output inserted.admin_id values('" + txt_emailid.Text + "','" + txt_pwd.Text + "',1,1,0)";
            Session["admin_id"] = db.return_affectedID(st);
            Response.Redirect("default.aspx");
        }
    }
}