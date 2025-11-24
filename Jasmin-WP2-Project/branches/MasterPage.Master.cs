using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Jasmin_WP2_Project.branches
{
    public partial class MasterPage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Request.IsAuthenticated &&
    !Request.Url.AbsolutePath.ToLower().Contains("login.aspx"))
            {
                Response.Redirect("~/auth/Login.aspx");
            }

            lblUsername.Text = Session["FirstName"] + " " + Session["LastName"];
            lblUserRole.Text = Session["Role"].ToString();
        }
    }
}