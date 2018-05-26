using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manager_Default : System.Web.UI.Page
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
            st = "select tablenumber,order_id,amount from tbl_orders where isClosed=0 ";
            db.fill_rptr_ret_sqlda(st, rpt_tables);

            st = "exec [dbo].[CreatePlayList]";
            DataTable dt = db.get_datatable(st);
            rpt_playlist.DataSource = dt;
            rpt_playlist.DataBind();
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void rpt_tables_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        RepeaterItem ritem = e.Item;
        if (ritem.ItemType == ListItemType.Item || ritem.ItemType == ListItemType.AlternatingItem)
        {
            HiddenField hf_id = ritem.FindControl("hf_orderid") as HiddenField;
            Repeater rpt_items = ritem.FindControl("rpt_items") as Repeater;
            st = "SELECT case when tbl_items.item_name IS NULL then '(Combo) '+tbl_combos.title else tbl_items.item_name end as itemname, tbl_order_details.qty,tbl_order_details.price, tbl_order_details.amount FROM  tbl_order_details  LEFT OUTER JOIN tbl_items ON tbl_order_details.item_id = tbl_items.item_id LEFT OUTER JOIN tbl_combos ON tbl_order_details.combo_id = tbl_combos.Combo_id  where order_id=" + hf_id.Value;
            db.fill_rptr_ret_sqlda(st, rpt_items);           
        }
        
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void lnkCheckout_Click(object sender, EventArgs e)
    {
        LinkButton lnk = sender as LinkButton;
        st = "update tbl_orders set isclosed=1 where order_id="+lnk.CommandArgument;
        db.ExeQuery(st);

        st = "select tablenumber,order_id,amount from tbl_orders where isClosed=0 ";
        db.fill_rptr_ret_sqlda(st, rpt_tables);

        upnl_repeater.Update();
    }  
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void tm_list_Tick(object sender, EventArgs e)
    {
        st = "select tablenumber,order_id,amount from tbl_orders where isClosed=0 ";
        db.fill_rptr_ret_sqlda(st, rpt_tables);
        upnl_repeater.Update();
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void tmr_songs_Tick(object sender, EventArgs e)
    {
        st = @"SELECT tbl_player.song_id,tbl_songs.song_name,tbl_songs.song_url,case is_playing when 1 then 'playing' else '' end as is_playing,
                case when is_requested =1 then 'display:none' else '' end as is_requested
                from tbl_player inner join tbl_songs on tbl_player.song_id = tbl_songs.song_id where is_played = 0 and is_played=0 order by order_number,requested_time";
        db.fill_rptr_ret_sqlda(st, rpt_playlist);
        upnl_songs.Update();
    }

    /// <summary>
    /// Update the song status in the playlist, played songs will be removed from playlist
    /// </summary>
    [WebMethod]
    public static string song_status(int song_id,int status)
    {
        // 1 = playing, 2- finished
        mydb db = new mydb();
        string st = "";
        if (status == 1)
        {
            st = "update tbl_player set is_playing = 1 where song_id = " + song_id;
            db.ExeQuery(st);
        }
        else
        {
            st = "update tbl_player set is_played = 1 where song_id = " + song_id;
            db.ExeQuery(st);
        }
        return "";
    }
}