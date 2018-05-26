using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class customer_Default : System.Web.UI.Page
{
    mydb db = new mydb();
    public static string background = "";
    string st = "";
    /// <summary>
    /// Page Load Event 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            st = "select top(1) image_url from tbl_themes where is_active = 1";
            background = db.read_val(st);

            if (Request.Cookies["tableNumber"] != null)
            {
                st = "select order_id,amount from tbl_orders where tableNumber=" + Request.Cookies["tableNumber"].Value + " and isClosed=0";

                SqlDataReader dr = db.readall(st);
                if (dr.Read())
                {
                    hf_orderid.Value = dr[0].ToString();
                lnk_cart.Text = dr[1].ToString();
                    pnl_neworder.Visible = false;
                    pnl_page.Visible = true;
                }
                else
                {
                    ScriptManager.RegisterStartupScript(UpdatePanel3, UpdatePanel3.GetType(), "", "$('#processing-modal').modal('show');", true);
                    pnl_neworder.Visible = true;
                    pnl_page.Visible = false;
                }
                pnl_table.Visible = false;
                dr.Close();                           
            }
            else
            {
                pnl_page.Visible = false;
                pnl_table.Visible = true;
                btn_neworder.Visible = false;
            }
            st = "select category_id,category_name from tbl_category where is_active=1";
            db.fill_rptr_ret_sqlda(st,rpt_category);

            st = "SELECT [Combo_id],[title],[description],[price],[combo_picture] FROM [dbo].[tbl_combos]";
            db.fill_rptr_ret_sqlda(st, rpt_combos);

            st = @"SELECT tbl_player.song_id,tbl_songs.song_name,tbl_songs.song_url,case is_playing when 1 then 'playing' else '' end as is_playing,
                case when is_requested =1 or is_playing = 1 then 'display:none' else '' end as is_requested
                from tbl_player inner join tbl_songs on tbl_player.song_id = tbl_songs.song_id where is_played = 0 and is_played=0 order by order_number,requested_time";
            db.fill_rptr_ret_sqlda(st, rpt_playlist);
        }        
        
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void lnk_combos_Click(object sender, EventArgs e)
    {
        pnl_combo.Visible = true;
        pnl_items.Visible = false;
    }
   /// <summary>
   /// 
   /// </summary>
   /// <param name="source"></param>
   /// <param name="e"></param>
    protected void rpt_combos_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        RepeaterItem ritem = e.Item;
        LinkButton lnk = ritem.FindControl("lnk_okcombo") as LinkButton;
        TextBox txt = ritem.FindControl("txt_qty") as TextBox;
        HiddenField hf_price = ritem.FindControl("hf_price") as HiddenField;
        st = "insert into tbl_order_details(order_id,combo_id,price,qty) values(" + hf_orderid.Value + "," + lnk.CommandArgument + "," + hf_price.Value + "," + txt.Text + ")";
        int x = db.ExeQuery(st);
        if(x>0)
        {
            st = "update tbl_orders set amount=(select sum(amount) from tbl_order_details where order_id=" + hf_orderid.Value + ") where  order_id=" + hf_orderid.Value + "";
            db.ExeQuery(st);
        }
        txt.Text = "";
        st = "select amount from tbl_orders where order_id=" + hf_orderid.Value;
        lnk_cart.Text = db.read_val(st);
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void lnk_category_Click(object sender, EventArgs e)
    {
        LinkButton lnk=sender as LinkButton;
        st = @"SELECT [item_id]
      ,[item_name]
      ,[category_id]
      ,[price]
      ,[item_image]
      ,[item_desc]
      ,[qty]
      ,[added_by]
      ,[is_active]
  FROM [dbo].[tbl_items] where is_active=1 and category_id=" + lnk.CommandArgument;
        db.fill_rptr_ret_sqlda(st, rpt_items);
        lbl_category.Text = lnk.CommandName;
        pnl_combo.Visible = false;
        pnl_items.Visible = true;
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="source"></param>
    /// <param name="e"></param>
    protected void rpt_items_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        RepeaterItem ritem = e.Item;
        LinkButton lnk = ritem.FindControl("lnk_okItem") as LinkButton;
        TextBox txt = ritem.FindControl("txt_qty") as TextBox;
        HiddenField hf_price = ritem.FindControl("hf_price") as HiddenField;
        st = "insert into tbl_order_details(order_id,item_id,price,qty) values(" + hf_orderid.Value + "," + lnk.CommandArgument + "," + hf_price.Value + "," + txt.Text + ")";
        int x = db.ExeQuery(st);



        if (x > 0)
        {
            st = "update tbl_orders set amount=(select sum(amount) from tbl_order_details where order_id=" + hf_orderid.Value + ") where  order_id=" + hf_orderid.Value + "";
            db.ExeQuery(st);
        }
        txt.Text = "";
        st = "select amount from tbl_orders where order_id=" + hf_orderid.Value;
        lnk_cart.Text = db.read_val(st);
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btn_table_Click(object sender, EventArgs e)
    {
        Response.Cookies["tableNumber"].Value = txt_table.Text;
        pnl_page.Visible = true;
        pnl_table.Visible = false;
        Response.Redirect("default.aspx");
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btn_neworder_Click(object sender, EventArgs e)
    {
        st = "insert into tbl_orders(tableNumber) output inserted.order_id values(" + Request.Cookies["tableNumber"].Value + ")";
        hf_orderid.Value = db.return_affected(st);
        if (hf_orderid.Value.Length > 0)
        {
            pnl_neworder.Visible = false;
            pnl_page.Visible = true;
            Response.Redirect("default.aspx");
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void tmr_new_Tick(object sender, EventArgs e)
    {
        if (hf_orderid.Value.Length > 0)
        {
            pnl_neworder.Visible = false;
            pnl_page.Visible = true;
        }
        else
        {
            pnl_neworder.Visible = true;
            pnl_page.Visible = false;
            ScriptManager.RegisterStartupScript(UpdatePanel3, UpdatePanel3.GetType(), "", "$('#processing-modal').modal('show');", true);
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void lnk_search_Click(object sender, EventArgs e)
    {
        if(txt_search.Text=="Close Table")
        {
            Response.Cookies["tableNumber"].Expires = DateTime.Now.AddDays(-1);
            Response.Redirect("default.aspx");
        }
        else
        {

        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void tmr_songs_Tick(object sender, EventArgs e)
    {
        st = @"SELECT tbl_player.song_id,tbl_songs.song_name,tbl_songs.song_url,case is_playing when 1 then 'playing' else '' end as is_playing,
                case when is_requested =1 or is_playing = 1 then 'display:none' else '' end as is_requested
                from tbl_player inner join tbl_songs on tbl_player.song_id = tbl_songs.song_id where is_played = 0 and is_played=0 order by order_number,requested_time";
        db.fill_rptr_ret_sqlda(st, rpt_playlist);
        upnl_songs.Update();
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="orderid"></param>
    /// <returns></returns>
    [WebMethod]
    public static string isClosed(string orderid)
    {
        mydb db = new mydb();
        string st = "";
        st = "select isClosed from tbl_orders where order_id=" + orderid;
        return db.read_val(st);
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="songid"></param>
    /// <returns></returns>
    [WebMethod]
    public static string play_song(string songid)
    {
        mydb db = new mydb();
        string st = "";

        st = "select order_number from tbl_player where song_id = (select max(isnull(song_id,1)) from tbl_player where is_playing =1 or is_requested = 1)";
        string val = db.read_val(st);

        st = "update tbl_player set is_requested=1 , requested_time = getdate(),order_number="+val+" where song_id="+songid;
        db.ExeQuery(st);
        return "done";
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void lnk_cart_Click(object sender, EventArgs e)
    {
        st = "SELECT case when tbl_items.item_name IS NULL then '(Combo) '+tbl_combos.title else tbl_items.item_name end as itemname,tbl_order_details.price, tbl_order_details.order_detailid,tbl_order_details.qty, tbl_order_details.amount FROM  tbl_order_details  LEFT OUTER JOIN tbl_items ON tbl_order_details.item_id = tbl_items.item_id LEFT OUTER JOIN tbl_combos ON tbl_order_details.combo_id = tbl_combos.Combo_id  where order_id=" + hf_orderid.Value;
        db.fill_rptr_ret_sqlda(st, rpt_invoice);
        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "$('#modalCart').modal('show');calc();", true);
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        LinkButton l=sender as LinkButton;
      //  st="select * from tbl_order_details where order"
        st = "delete from tbl_order_details where order_detailid=" + l.CommandArgument;
        int d=db.ExeQuery(st);
        if (d > 0)
        {
            st = "update tbl_orders set amount=(select sum(amount) from tbl_order_details where order_id=" + hf_orderid.Value + ") where  order_id=" + hf_orderid.Value + "";
            db.ExeQuery(st);
        }
        st = "select amount from tbl_orders where order_id=" + hf_orderid.Value;
        lnk_cart.Text = db.read_val(st);

    }
}