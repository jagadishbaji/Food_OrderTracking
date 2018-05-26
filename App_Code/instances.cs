using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for instances
/// </summary>
public class instances
{
	public instances()
	{
		//
		// TODO: Add constructor logic here
		//
	}
}

public class Adminlogin_details
{
    public string profile_pic { get; set; }
    public string fullname { get; set; }
    public bool is_superadmin {get;set;}
    public bool offers_combos{get;set;}
    public bool inform_before_activate{get;set;}
    public bool item_details { get; set; }
}