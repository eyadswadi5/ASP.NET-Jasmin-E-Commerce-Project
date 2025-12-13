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
    public partial class ViewBranch : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int branchId = Convert.ToInt32(Request.QueryString["id"]);

            string connectionString = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
            string query = "SELECT * FROM stores WHERE id = @id;" +
                "SELECT warehouses.name as wh_name FROM warehouse_store JOIN warehouses ON warehouse_store.warehouse_id = warehouses.id WHERE warehouse_store.store_id = @id;" +
                "SELECT (peri.first_name + ' ' + peri.last_name) as manager_name FROM stores JOIN personal_information as peri ON stores.manager_id = peri.user_id WHERE stores.id = @id;" +
                "SELECT COUNT(products.id) as pro_num FROM product_store JOIN products ON product_store.product_id = products.id WHERE product_store.store_id = @id;";

            using (SqlConnection conn = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@id", branchId);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    BranchNameLabel.Text = reader["name"].ToString();
                    CityLabel.Text = reader["city"].ToString();
                    AddressLabel.Text = reader["address"].ToString();
                    PhoneLabel.Text = reader["phone"].ToString();
                    BrochureUrlLabel.Text = reader["file_url"].ToString();
                    LnkDownloadBrochure.HRef = "~/" + reader["file_url"].ToString();
                }

                reader.NextResult();

                if (reader.Read())
                {
                    WarehouseNameLabel.Text = reader["wh_name"].ToString();
                }

                reader.NextResult();

                if (reader.Read())
                {
                    ManagerNameLabel.Text = reader["manager_name"].ToString();
                }

                reader.NextResult();

                if (reader.Read())
                {
                    ProductsCountLabel.Text = reader["pro_num"].ToString();
                }

                reader.Close();
            }
        }
    }
}