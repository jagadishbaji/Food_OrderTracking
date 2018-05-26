using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

/// <summary>
/// Manage songs to play in the hotel
/// </summary>
public partial class admin_add_songs : System.Web.UI.Page
{
    string st = "";
    mydb db = new mydb();
    /// <summary>
    /// Display songs added in the Databse
    /// </summary>
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
    /// Save the selected song to the database, songs will be saved in songs folder in project with random name
    /// </summary>
    protected void lnk_save_Click(object sender, EventArgs e)
    {
        if (fu_songs.HasFile)
        {
            string ext = Path.GetExtension(fu_songs.PostedFile.FileName).ToLower();
            if (ext == ".mp3")
            {
               
                string filepath = "";

                filepath = Guid.NewGuid().ToString() + ext;
                fu_songs.SaveAs(Server.MapPath("~/songs/") + filepath);
                st = "insert into tbl_songs (song_name,song_url) output inserted.song_id values('" + txt_name.Text + "','" + filepath + "')";
                int song_id = db.return_affectedID(st);
                if(song_id>0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "showalert('success','Song added successfully.');", true);
                    fill_data();
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "showalert('error','Only MP3 files allowed.');", true);
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "showalert('error','Please select file to upload.');", true);
        }
    }
/// <summary>
/// Delete the selected song from the database
/// </summary>
    protected void lnk_delete_Click(object sender, EventArgs e)
    {
        LinkButton lnk = sender as LinkButton;
        st = "delete from tbl_songs where song_id = " + (sender as LinkButton).CommandArgument;
        int x = db.ExeQuery(st);
        if (x > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "showalert('success','Song deleted successfully.');", true);
            fill_data();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "showalert('error','Unable to delete, please try later.');", true);
        }
    }

    /// <summary>
    /// Select all the songs from database and display in repeater
    /// </summary>
    private void fill_data()
    {
        st = "select * from tbl_songs";
        db.fill_rptr_ret_sqlda(st, rpt_items);
    }
}