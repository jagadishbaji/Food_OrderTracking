using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Drawing;

public partial class admin_demo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-8TVC6LE;Initial Catalog=order_tracking_latest;Persist Security Info=True;User ID=sa;Password=2020");
        con.Open();
        string st = "insert into demo values ('" + name.Text + "','" + email.Text + "'," + mobile.Text + ")";
        cmd = new SqlCommand(st, con);
        int x = cmd.ExecuteNonQuery();
        if (x > 0)
        {
            Label1.Text = "SUCCESS";
            Label1.ForeColor = Color.Green;
        }
        else
        {
            Label1.Text = "FAILD";
            Label1.ForeColor = Color.Red;
        }

    }
}