<%@ Control Language="C#" AutoEventWireup="true" CodeFile="sidemenu.ascx.cs" Inherits="admin_sidemenu" %>
<aside class="left-side sidebar-offcanvas">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
        <!-- Sidebar user panel -->
        <div class="user-panel">
            <div class="pull-left image">
                <img src="../project_files/<%= (Session["Adminlogin_details"] as Adminlogin_details).profile_pic%>" class="img-circle" alt="User Image" />
            </div>
            <div class="pull-left info">
                <p>Hello, <%= (Session["Adminlogin_details"] as Adminlogin_details).fullname%></p>

            </div>
        </div>
        <!-- search form -->
        <div class="sidebar-form">
            <div class="input-group">
                <input type="text" name="q" class="form-control" placeholder="Search..." />
                <span class="input-group-btn">
                    <button type='submit' name='seach' id='search-btn' class="btn btn-flat"><i class="fa fa-search"></i></button>
                </span>
            </div>
        </div>
        <!-- /.search form -->
        <!-- sidebar menu: : style can be found in sidebar.less -->
        <ul class="sidebar-menu">
            <li>
                <a href="dashboard.aspx">
                    <i class="fa fa-dashboard"></i><span>Dashboard</span>
                </a>
            </li>            
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-bar-chart-o"></i>
                    <span>My Settings</span>
                    <i class="fa fa-angle-left pull-right"></i>
                </a>
                <ul class="treeview-menu">
                    <li><a href="update-details.aspx"><i class="fa fa-angle-double-right"></i>Update Details</a></li>
                    <li><a href="change-password.aspx"><i class="fa fa-angle-double-right"></i>Change Password</a></li>                    
                </ul>
            </li>     
            <li class="treeview">
                 <a href="#">
                    <i class="fa fa-bar-chart-o"></i>
                    <span>Main Settings</span>
                    <i class="fa fa-angle-left pull-right"></i>
                </a>
                <ul class="treeview-menu">
                    <li><a href="add-category.aspx"><i class="fa fa-angle-double-right"></i>Manage Category</a></li>
                    <li><a href="add-items.aspx"><i class="fa fa-angle-double-right"></i>Manage Items </a></li>
                    <li><a href="add-combo.aspx"><i class="fa fa-angle-double-right"></i>Manage Combos</a></li>  
                    <li><a href="add-songs.aspx"><i class="fa fa-angle-double-right"></i>Manage Songs</a></li> 
                   
                    <li><a href="manage-themes.aspx"><i class="fa fa-angle-double-right"></i>Manage Themes</a></li>        
                </ul>
            </li>       
        </ul>
    </section>
    <!-- /.sidebar -->
</aside>
