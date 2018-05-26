using Facebook;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Dynamic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
/// <summary>
/// Screen which is displayed in hotel to show promotions and event pictures
/// </summary>
public partial class _Default : System.Web.UI.Page
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
            //Fetch the details of the event when it is triggered at scheduled time.
            if (Request.QueryString["id"] != null)
            {
                st = "SELECT tbl_events.event_title title, tbl_events.Message description, tbl_events.event_id, tbl_eventpictures.picture_url combo_picture FROM tbl_events INNER JOIN tbl_eventpictures ON tbl_events.event_id = tbl_eventpictures.event_id where tbl_events.event_id =" + Request.QueryString["id"].ToString();
                DataTable dt = db.get_datatable(st);
                Repeater1.DataSource = dt;
                Repeater1.DataBind();
                Repeater2.DataSource = dt;
                Repeater2.DataBind();
                isevent.Value = "True";
            }
            else
            {
                //Display yhe combo pictures from database and display in the hotel screen
                st = "SELECT [Combo_id] ,[title],[description],[price],'project_files/combos/'+[combo_picture] as combo_picture FROM  tbl_combos";
                DataTable dt = db.get_datatable(st);
                Repeater1.DataSource = dt;
                Repeater1.DataBind();
                Repeater2.DataSource = dt;
                Repeater2.DataBind();
            }
        }    
    }   

    /// <summary>
    /// Check for the events created in admin section and display at scheduled time
    /// </summary>
    /// <returns></returns>
    [WebMethod]
    public static string checkevents()
    {
        mydb db = new mydb();
        string st = "select event_id from tbl_events where event_date  between dateadd(MINUTE,-1,GETDATE()) and dateadd(MINUTE,1,GETDATE()) and is_displayed = 0";
        return db.read_val(st);        
    }
}