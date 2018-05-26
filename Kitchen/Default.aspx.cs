using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Kitchen_Default : System.Web.UI.Page
{
    string st = "";
    mydb db = new mydb();
    /// <summary>
    /// On page load dispaly all the tables which are open for order
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            st = "select tablenumber,order_id from tbl_orders where isClosed=0 ";
            db.fill_rptr_ret_sqlda(st, rpt_tables);
        }
    }

    /// <summary>
    /// To display the orders placed by customer
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void rpt_tables_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        RepeaterItem ritem = e.Item;
        if(ritem.ItemType == ListItemType.Item || ritem.ItemType == ListItemType.AlternatingItem)
        {
            HiddenField hf_id = ritem.FindControl("hf_orderid") as HiddenField;
            Repeater rpt_items = ritem.FindControl("rpt_items") as Repeater;
            st = "SELECT case when tbl_items.item_name IS NULL then '(Combo) '+tbl_combos.title else tbl_items.item_name end as itemname, tbl_order_details.qty FROM  tbl_order_details  LEFT OUTER JOIN tbl_items ON tbl_order_details.item_id = tbl_items.item_id LEFT OUTER JOIN tbl_combos ON tbl_order_details.combo_id = tbl_combos.Combo_id  where order_id=" + hf_id.Value;
            db.fill_rptr_ret_sqlda(st, rpt_items);
        }
    }
}