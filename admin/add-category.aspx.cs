using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_add_category : System.Web.UI.Page
{
    string st = "";
    mydb db = new mydb();
    /// <summary>
    /// Page Load Event Checking Session, if not loged in then redirecting to Login page else display Login person related data
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["admin_id"] == null)
        {
            Response.Redirect("default.aspx");
        }
        if(!IsPostBack)
        {
            fill_data();
        }
    }
    /// <summary>
    /// Creates the Category and before creating checks the image type
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void lnk_save_Click(object sender, EventArgs e)
    {
        int isactive = (chk_isactive.Checked)?1:0;
        string filepath = "";
        string ext = Path.GetExtension(fu_picture.PostedFile.FileName).ToLower();
        if (fu_picture.HasFile)
        {
            if (ext == ".jpg" || ext == ".jpeg" || ext == ".png" || ext == ".gif")
            {
                filepath = Guid.NewGuid().ToString() + ext;
                fu_picture.SaveAs(Server.MapPath("~/project_files/categories/") + filepath);
            }
        }
        st = "insert into tbl_category([category_name],[category_image],[description],[added_by],is_active) values('" + txt_name.Text + "','" + filepath + "','" + txt_desc.Text + "'," + Session["admin_id"].ToString() + "," + isactive + ")";
        int x = db.ExeQuery(st);
        if(x>0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "showalert('success','Added successfully.');", true);
            txt_desc.Text = txt_name.Text = "";
            fill_data();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "showalert('error','Unable to add, please try later.');", true);
        }
    }

    /// <summary>
    /// Selects the categories and display with the status
    /// </summary>
    private void fill_data()
    {
        st = "SELECT [category_id],[category_name],[category_image],[description],[added_by],case is_active when 1 then 'Active' else 'Inactive' End is_active FROM [tbl_category]";
        db.fill_rptr_ret_sqlda(st, rpt_categories);
    }
    /// <summary>
    /// deletes the Category 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void lnk_delete_Click(object sender, EventArgs e)
    {
        st = "delete from tbl_category where category_id = " + (sender as LinkButton).CommandArgument;
        int x = db.ExeQuery(st);
        if (x > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "showalert('success','Category deleted successfully.');", true);
            fill_data();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "showalert('error','Unable to delete, please try later.');", true);
        }
    }
}