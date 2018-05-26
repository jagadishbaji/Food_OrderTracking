<%@ WebHandler Language="C#" Class="crop" %>


using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Web;
using System.Drawing;
using System.Drawing.Drawing2D;

public class crop : IHttpHandler
{

	public void ProcessRequest(HttpContext context)
	{
        string imgUrl = context.Server.MapPath("~/" + context.Request["imgUrl"].Replace("../",""));
        int imgInitW = int.Parse(context.Request["imgInitW"]);
        int imgInitH = int.Parse(context.Request["imgInitH"]);
        int imgW = int.Parse(float.Parse(context.Request["imgW"], System.Globalization.CultureInfo.InvariantCulture.NumberFormat).ToString("0"));
        int imgH = int.Parse(float.Parse(context.Request["imgH"], System.Globalization.CultureInfo.InvariantCulture.NumberFormat).ToString("0"));
        int imgY1 = int.Parse(context.Request["imgY1"]);
        int imgX1 = int.Parse(context.Request["imgX1"]);
        int cropW = int.Parse(context.Request["cropW"]);
        int cropH = int.Parse(context.Request["cropH"]);

		using (Bitmap bmp = new Bitmap(imgUrl)) {
			using (Bitmap newbmp = new Bitmap(resizeImage(bmp, new Size {Height = imgH,Width = imgW}))) {
				using (Bitmap bmpcrop = newbmp.Clone(new System.Drawing.Rectangle {Height = cropH,Width = cropW,X = imgX1,Y = imgY1}, newbmp.PixelFormat)) {
					string croppedFilename = "cropped_" + System.IO.Path.GetRandomFileName() + System.IO.Path.GetExtension(imgUrl);
                    string croppedUrl = context.Server.MapPath("~/project_files/") + croppedFilename;
					bmpcrop.Save(croppedUrl);
                    if (context.Request["instance_id"] != null && context.Request["profile_pic"] != null)
                    {
                        mydb db = new mydb();
                        string query = "update tbl_admin set profile_pic='" + croppedFilename + "' where admin_id=" + context.Request["instance_id"];
                        db.ExeQuery(query);
                    }
					context.Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(new successmsg_crop {
						status = "success",
                        url = "../project_files/" + croppedFilename
					}));
				}
			}
		}
	}


    private static System.Drawing.Image resizeImage(System.Drawing.Image imgToResize, Size size)
	{
		int sourceWidth = imgToResize.Width;
		int sourceHeight = imgToResize.Height;

		float nPercent = 0;
		float nPercentW = 0;
		float nPercentH = 0;

		nPercentW = (Convert.ToSingle(size.Width) / Convert.ToSingle(sourceWidth));
		nPercentH = (Convert.ToSingle(size.Height) / Convert.ToSingle(sourceHeight));

		if (nPercentH < nPercentW) {
			nPercent = nPercentH;
		} else {
			nPercent = nPercentW;
		}

		int destWidth = Convert.ToInt32(sourceWidth * nPercent);
		int destHeight = Convert.ToInt32(sourceHeight * nPercent);

		Bitmap b = new Bitmap(destWidth, destHeight);
		Graphics g = Graphics.FromImage((System.Drawing.Image)b);
		g.InterpolationMode = InterpolationMode.HighQualityBicubic;

		g.DrawImage(imgToResize, 0, 0, destWidth, destHeight);
		g.Dispose();

		return (System.Drawing.Image)b;
	}


	public bool IsReusable {
		get { return false; }
	}

}

public class successmsg_crop
{
	public string status;
	public string url;
}
