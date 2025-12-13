using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace Jasmin_WP2_Project.branches
{
    public partial class AddBranches : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"].ToString() != "employee")
                Response.Redirect("~/branches/Home.aspx");
        }

        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            string branchName = txtName?.Text.Trim() ?? string.Empty;
            string city = txtCity?.Text.Trim() ?? string.Empty;
            string address = txtAddress?.Text.Trim() ?? string.Empty;
            string phoneNumber = txtPhone?.Text.Trim() ?? string.Empty;
            int managerId = Convert.ToInt32(ddlManager?.SelectedValue);

            string uploadedFileName = null;
            string[] allowedExtensions = { ".pdf" };
            string[] allowedContentTypes = { "application/pdf" };

            if (fileUploadBrochure != null && fileUploadBrochure.HasFile)
            {
                uploadedFileName = Path.GetFileName(fileUploadBrochure.FileName);
                string uploadedFileExtention = Path.GetExtension(uploadedFileName).ToLower();
                string uploadedContentType = fileUploadBrochure.PostedFile.ContentType;

                if (!allowedExtensions.Contains(uploadedFileExtention) || !allowedContentTypes.Contains(uploadedContentType))
                {
                    lblFileUploadMessage.Text = "Only PDF file are allowed.";
                    return;
                }

                var saveDir = Server.MapPath("~/storage/file/brochures");
                Directory.CreateDirectory(saveDir);
                var savePath = Path.Combine(saveDir, uploadedFileName);
                fileUploadBrochure.SaveAs(savePath);
            }

            string connectionString = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) as num FROM personal_information JOIN roles ON personal_information.role_id = roles.id WHERE personal_information.id = @Manager_ID AND roles.type = 'manager'";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Prepare();
                cmd.Parameters.AddWithValue("@Manager_ID", managerId);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (!reader.HasRows)
                {
                    lblMangerStatus.Text = "Error: The provided id didn't belongs to a manager.";
                    return;
                }

                reader.Close();
                cmd.Parameters.Clear();
                
                query = "INSERT INTO stores VALUES (@Name, @City, @Address, @Phone, @File_url, @Manager_ID);";
                cmd.CommandText = query;
                cmd.Prepare();

                cmd.Parameters.AddWithValue("@Name", branchName);
                cmd.Parameters.AddWithValue("@City", city);
                cmd.Parameters.AddWithValue("@Address", address);
                cmd.Parameters.AddWithValue("@Phone", phoneNumber);
                cmd.Parameters.AddWithValue("@Manager_ID", managerId);

                string filePath = string.Empty;
                if (!string.IsNullOrEmpty(uploadedFileName))
                {
                    filePath = "/storage/file/brochures/" + uploadedFileName;
                }
                cmd.Parameters.AddWithValue("@File_url", filePath);

                int created = cmd.ExecuteNonQuery();

                if (created > 0)
                {
                    lblStatusMessage.Text = "Store created successfully!";
                }
                else
                {
                    lblStatusMessage.Text = "Error Creating store branch";
                }
                return;
            }
        }
    }
}