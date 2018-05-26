using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

/// <summary>
/// Page to add items to the tbl_items in the database, with respect to their category
/// </summary>
public partial class admin_add_items : System.Web.UI.Page
{
    string st = "";
    mydb db = new mydb();
    /// <summary>
    /// Fill the category to the dropdown for adding the items to particular category
    /// </summary>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["admin_id"] == null)
        {
            Response.Redirect("default.aspx");
        }
        if (!IsPostBack)
        {
            st = "select category_id,category_name from tbl_category where is_active = 1";
            db.fill_drop_with_id(st, ddl_category);
            fill_data();
        }
    }

    /// <summary>
    /// Save the details of Item to the database
    /// </summary>
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
                fu_picture.SaveAs(Server.MapPath("~/project_files/items/") + filepath);
            }
        }
        st = "insert into tbl_items([item_name],[price],[item_image],[item_desc],[qty],[added_by],[is_active],[category_id]) values" +
             "('"+txt_name.Text+"', "+txt_price.Text+",'"+filepath+"','"+txt_desc.Text+"',"+txt_qty.Text+","+Session["admin_id"].ToString()+","+isactive+","+ddl_category.SelectedValue+")";
        int x = db.ExeQuery(st);
        if (x > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "showalert('success','Item added successfully.');", true);
            txt_desc.Text = txt_name.Text = "";
            fill_data();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "showalert('error','Unable to add, please try later.');", true);
        }
    }

    /// <summary>
    /// Select all items from database and show in repeater control
    /// </summary>
    private void fill_data()
    {
        st = @"SELECT [item_id],[item_name],[price],
                [item_image],[item_desc],[qty],tbl_items.[added_by],
                case tbl_items.is_active when 1 then 'true' else 'false' End is_active,
                 category_name
                FROM [dbo].[tbl_items] inner join tbl_category 
                on tbl_items.category_id = tbl_category.category_id";
        db.fill_rptr_ret_sqlda(st, rpt_items);
    }

    /// <summary>
    /// Delete the selected item from list
    /// </summary>
    protected void lnk_delete_Click(object sender, EventArgs e)
    {
        LinkButton lnk = sender as LinkButton;
        st = "delete from tbl_items where item_id = " + (sender as LinkButton).CommandArgument;
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

    /// <summary>
    /// Change the active status of the selected item
    /// </summary>
    protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox chk = sender as CheckBox;
        int isactive = (chk.Checked) ? 1 : 0;
        st = "update tbl_items set is_active = " + isactive + " where item_id = " + chk.AccessKey;
        int x = db.ExeQuery(st);
        if (x > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "showalert('success','Visibility updated successfully.');", true);
            fill_data();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "showalert('error','Unable to update visibility, please try later.');", true);
        }
    }
    
}