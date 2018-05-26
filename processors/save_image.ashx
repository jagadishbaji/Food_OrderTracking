<%@ WebHandler Language="C#" Class="save_image" %>

using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Web;
using Newtonsoft.Json;

public class save_image : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        HttpPostedFile up = context.Request.Files[0];
        System.Drawing.Image upimg = System.Drawing.Image.FromStream(up.InputStream);

        string newFilename = System.IO.Path.GetRandomFileName() + System.IO.Path.GetExtension(up.FileName);
        up.SaveAs(context.Server.MapPath("~/temp_files/"+newFilename));

        successmsg s = new successmsg
        {
            status = "success",
            url = "../temp_files/" + newFilename,
            width = upimg.Width,
            height = upimg.Height
        };

        context.Response.Write(JsonConvert.SerializeObject(s));
    }

    public bool IsReusable
    {
        get { return false; }
    }

}

public class successmsg
{
    public string status;
    public string url;
    public int width;
    public int height;
}
