using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_manage_themes : System.Web.UI.Page
{
    string st = "";
    mydb db = new mydb();
    /// <summary>
    /// Loads Themes
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
    /// Theme Insertion
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void lnk_save_Click(object sender, EventArgs e)
    {
        if (fu_image.HasFile)
        {
            string ext = Path.GetExtension(fu_image.PostedFile.FileName).ToLower();
            if (ext.ToLower() == ".jpg" || ext.ToLower() == ".jpeg")
            {

                string filepath = "";

                filepath = Guid.NewGuid().ToString() + ext;
                fu_image.SaveAs(Server.MapPath("~/themes/") + filepath);
                st = "insert into tbl_themes (theme_name,image_url) output inserted.theme_id values('" + txt_name.Text + "','" + filepath + "')";
                int song_id = db.return_affectedID(st);
                if (song_id > 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "showalert('success','theme added successfully.');", true);
                    fill_data();
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "showalert('error','Only JPG/JPEG files allowed.');", true);
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "showalert('error','Please select file to upload.');", true);
        }
    }
    /// <summary>
    /// deletes Theme
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void lnk_delete_Click(object sender, EventArgs e)
    {
        LinkButton lnk = sender as LinkButton;
        st = "delete from tbl_themes where theme_id = " + (sender as LinkButton).CommandArgument;
        int x = db.ExeQuery(st);
        if (x > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "showalert('success','theme deleted successfully.');", true);
            fill_data();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "showalert('error','Unable to delete, please try later.');", true);
        }
    }
    /// <summary>
    /// Selects all the themes from table
    /// </summary>
    private void fill_data()
    {
        st = "select * from tbl_themes";
        db.fill_rptr_ret_sqlda(st, rpt_items);


        st = "select theme_id,theme_name,is_active from tbl_themes";
        DataTable dt = new DataTable();
        dt = db.get_datatable(st);
        ddl_themes.DataSource = dt;
        ddl_themes.DataTextField = "theme_name";
        ddl_themes.DataValueField = "theme_id";
        ddl_themes.DataBind();

        bool isThemeSet = false;
        foreach(DataRow dr in dt.Rows)
        {
            if(dr["is_active"].ToString() == "True" || dr["is_active"].ToString() == "1")
            {
                ddl_themes.SelectedValue = dr["theme_id"].ToString();
                isThemeSet = true;
                break;
            }
        }
        if(!isThemeSet)
        {
            ddl_themes.Items.Insert(0, "Select theme");
            ddl_themes.SelectedIndex = 0;
        }

    }
    /// <summary>
    /// updates current theme
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void lnk_settheme_Click(object sender, EventArgs e)
    {
        st = "update tbl_themes set is_active = 0 ";
        db.ExeQuery(st);

        st = "update tbl_themes set is_active =1 where theme_id = "+ddl_themes.SelectedValue;
        db.ExeQuery(st);

        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "showalert('success','Theme applied successfully.');", true);
    }
}