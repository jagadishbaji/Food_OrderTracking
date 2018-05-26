using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_add_combo : System.Web.UI.Page
{
    string st = "";
    mydb db = new mydb();
    /// <summary>
    /// Manage Combos in served in hotel
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["admin_id"] == null)
        {
            Response.Redirect("default.aspx");
        }
        if (!IsPostBack)
        {
            fill_data();
        }
    }

    /// <summary>
    /// Method to save the combos in tbl_combos table, image will be saved to "project_files/combos" folder
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void lnk_save_Click(object sender, EventArgs e)
    {
        string filepath = "";
        string ext = Path.GetExtension(fu_picture.PostedFile.FileName).ToLower();
        if(fu_picture.HasFile)
        {
            if(ext == ".jpg" || ext == ".jpeg" || ext == ".png" || ext == ".gif")
            {
                filepath = Guid.NewGuid().ToString() + ext;
                fu_picture.SaveAs(Server.MapPath("~/project_files/combos/") + filepath);
            }
        }
        st = "insert into tbl_combos(title,description,price,combo_picture) values('"+txt_title.Text+"','"+txt_desc.Text+"',"+txt_price.Text+",'"+filepath+"')";
        int x = db.ExeQuery(st);
        if (x > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "showalert('success','Combo added successfully.');", true);
            txt_desc.Text = txt_price.Text = txt_title.Text = "";
            fill_data();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "showalert('error','Unable to add, please try later.');", true);
        }
    }

    /// <summary>
    /// Delete the selected combo from the list
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void lnk_delete_Click(object sender, EventArgs e)
    {
        st = "delete from tbl_combos where combo_id = "+ (sender as LinkButton).CommandArgument ;
        int x = db.ExeQuery(st);
        if(x>0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "showalert('success','Combo deleted successfully.');", true);
            fill_data();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "showalert('error','Unable to delete, please try later.');", true);
        }
    }

    /// <summary>
    /// Method to select combos added and display in Repeater control
    /// </summary>
    private void fill_data()
    {
        st = "select * from tbl_combos";
        db.fill_rptr_ret_sqlda(st, rpt_combos);
    }
}