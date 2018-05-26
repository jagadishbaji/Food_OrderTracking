using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


public class From
{
    public string id { get; set; }
    public string name { get; set; }
    public string category { get; set; }
}

public class FBImage
{
    public int height { get; set; }
    public string source { get; set; }
    public int width { get; set; }
}

public class Datum2
{
    public string id { get; set; }
    public string name { get; set; }
    public string created_time { get; set; }
    public double x { get; set; }
    public double y { get; set; }
}

public class Cursors
{
    public string before { get; set; }
    public string after { get; set; }
}

public class Paging
{
    public Cursors cursors { get; set; }
}

public class Tags
{
    public List<Datum2> data { get; set; }
    public Paging paging { get; set; }
}

public class Datum3
{
    public string id { get; set; }
    public string name { get; set; }
}

public class Cursors2
{
    public string before { get; set; }
    public string after { get; set; }
}

public class Paging2
{
    public Cursors2 cursors { get; set; }
    public string next { get; set; }
}

public class Likes
{
    public List<Datum3> data { get; set; }
    public Paging2 paging { get; set; }
}

public class From2
{
    public string id { get; set; }
    public string name { get; set; }
}

public class Datum4
{
    public string id { get; set; }
    public bool can_remove { get; set; }
    public string created_time { get; set; }
    public From2 from { get; set; }
    public int like_count { get; set; }
    public string message { get; set; }
    public bool user_likes { get; set; }
}

public class Cursors3
{
    public string before { get; set; }
    public string after { get; set; }
}

public class Paging3
{
    public Cursors3 cursors { get; set; }
}

public class Comments
{
    public List<Datum4> data { get; set; }
    public Paging3 paging { get; set; }
}

public class Location
{
    public double latitude { get; set; }
    public double longitude { get; set; }
    public string zip { get; set; }
}

public class Place
{
    public string name { get; set; }
    public Location location { get; set; }
    public string id { get; set; }
}

public class Datum
{
    public string id { get; set; }
    public string created_time { get; set; }
    public From from { get; set; }
    public int height { get; set; }
    public string icon { get; set; }
    public List<FBImage> images { get; set; }
    public string link { get; set; }
    public string picture { get; set; }
    public string source { get; set; }
    public string updated_time { get; set; }
    public int width { get; set; }
    public Tags tags { get; set; }
    public Likes likes { get; set; }
    public Comments comments { get; set; }
    public string name { get; set; }
    public Place place { get; set; }
}

public class Cursors4
{
    public string before { get; set; }
    public string after { get; set; }
}

public class Paging4
{
    public Cursors4 cursors { get; set; }
    public string next { get; set; }
}

public class RootObject
{
    public List<Datum> data { get; set; }
    public Paging4 paging { get; set; }
}