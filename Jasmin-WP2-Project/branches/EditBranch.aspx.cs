using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Jasmin_WP2_Project.branches
{
    public partial class EditBranch : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"].ToString() != "employee")
                Response.Redirect("~/branches/Home.aspx");

            if (IsPostBack)
            {
                return;
            }

            int id = Convert.ToInt32(Request.QueryString["id"]);

            string connectionString = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT TOP (1000) stores.[id]," +
                    "stores.[name]," +
                    "stores.[city]," +
                    "stores.[address]," +
                    "stores.[phone]," +
                    "stores.[manager_id]," +
                    "personal_information.[first_name] + ' ' + personal_information.last_name as ManagerName " +
                    "FROM [STORE_DB].[dbo].[stores] JOIN personal_information ON stores.manager_id = personal_information.user_id " +
                    "WHERE stores.[id] = @ID ;";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Prepare();
                cmd.Parameters.AddWithValue("@ID", id);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.HasRows)
                {
                    reader.Read();
                    txtName.Text = reader["name"].ToString();
                    txtCity.Text = reader["city"].ToString();
                    txtAddress.Text = reader["address"].ToString();
                    txtPhone.Text = reader["phone"].ToString();
                    ddlManager.SelectedValue = reader["manager_id"].ToString();
                }
            }
        }
        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] == null)
            {
                lblStatusMessage.Text = "Missing store ID.";
                return;
            }

            int storeId = Convert.ToInt32(Request.QueryString["id"]);

            string brochureFilePath = null;


            if (fileUploadBrochure.HasFile)
            {
                string folder = Server.MapPath("~/storage/file/brochures/");
                if (!Directory.Exists(folder))
                    Directory.CreateDirectory(folder);

                string fileName = storeId + "_" + fileUploadBrochure.FileName;
                string fullPath = Path.Combine(folder, fileName);

                fileUploadBrochure.SaveAs(fullPath);
                brochureFilePath = "/storage/file/brochures/" + fileName;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
                    UPDATE stores SET
                    name = @name,
                    city = @city,
                    address = @address,
                    phone = @phone,
                    manager_id = @manager_id
                    " + (brochureFilePath != null ? ", file_url = @brochure_path" : "") + @"
                    WHERE id = @id";

                SqlCommand cmd = new SqlCommand(query, conn);

                cmd.Parameters.AddWithValue("@id", storeId);
                cmd.Parameters.AddWithValue("@name", txtName.Text.Trim());
                cmd.Parameters.AddWithValue("@city", txtCity.Text.Trim());
                cmd.Parameters.AddWithValue("@address", txtAddress.Text.Trim());
                cmd.Parameters.AddWithValue("@phone", txtPhone.Text.Trim());
                cmd.Parameters.AddWithValue("@manager_id", Convert.ToInt32(ddlManager.SelectedValue));

                if (brochureFilePath != null)
                    cmd.Parameters.AddWithValue("@brochure_path", brochureFilePath);

                conn.Open();
                int affectedRows = cmd.ExecuteNonQuery();

                if (affectedRows > 0)
                {
                    lblStatusMessage.Text = "Store updated successfully!";
                }
            }
        }
    }
}