using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Jasmin_WP2_Project.branches
{
    public partial class AssignEmployees : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            List<int> empIds = new List<int>();
            foreach (ListItem item in ChkBxEmps.Items)
            {
                if (item.Selected)
                {
                    empIds.Add(int.Parse(item.Value));
                }
            }
            string empIdsParam = string.Join(",", empIds);

            string connectionString = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
            string query = "UPDATE personal_information SET store_id = @store_id WHERE id IN (@emp_ids)";
            
            using (SqlConnection conn = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@store_id", Convert.ToInt32(ddlBranches.SelectedValue));
                cmd.Parameters.AddWithValue("@emp_ids", empIdsParam);
                conn.Open();
                int affectedRows = cmd.ExecuteNonQuery();

                if (affectedRows > 0)
                {
                    ChkBxEmps.DataBind();
                    lblStatusMessage.Text = "Employees assigned successfully.";
                } else
                {
                    lblStatusMessage.Text = "No employees were assigned.";
                }
            }
        }
    }
}