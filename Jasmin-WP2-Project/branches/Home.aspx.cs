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
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SearchButton_Click(object sender, EventArgs e)
        {
            string searchTerm = SearchTextBox.Text.Trim();

            if (string.IsNullOrEmpty(searchTerm))
            {
                Stores_SQL_DS.SelectCommand = @"SELECT TOP (1000) stores.[id]
                    ,stores.[name]
                    ,stores.[city]
                    ,stores.[address]
                    ,stores.[phone]
                    ,personal_information.[first_name] + ' ' + personal_information.last_name as ManagerName
                FROM [STORE_DB].[dbo].[stores] 
                JOIN personal_information ON stores.manager_id = personal_information.user_id";
                Stores_SQL_DS.SelectParameters.Clear();
            }
            else
            {
                Stores_SQL_DS.SelectCommand = @"SELECT TOP (1000) stores.[id]
                    ,stores.[name]
                    ,stores.[city]
                    ,stores.[address]
                    ,stores.[phone]
                    ,personal_information.[first_name] + ' ' + personal_information.last_name as ManagerName
                FROM [STORE_DB].[dbo].[stores] 
                JOIN personal_information ON stores.manager_id = personal_information.user_id
                WHERE stores.[name] LIKE '%' + @SearchTerm + '%'
                    OR stores.[city] LIKE '%' + @SearchTerm + '%'
                    OR stores.[address] LIKE '%' + @SearchTerm + '%'
                    OR CAST(stores.manager_id AS VARCHAR) LIKE '%' + @SearchTerm + '%'
                    OR (personal_information.[first_name] + ' ' + personal_information.last_name) LIKE '%' + @SearchTerm + '%'";

                Stores_SQL_DS.SelectParameters.Clear();
                Stores_SQL_DS.SelectParameters.Add("SearchTerm", searchTerm);
            }

            BranchesGridView.DataBind();
        }

        protected void BranchesGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }

        protected void BranchesGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteStore")
            {

                if (Session["Role"].ToString() != "manager")
                {
                    lblErrorMessage.InnerText = "You do not have permission to delete stores.";
                    return;
                }

                int id = Convert.ToInt32(e.CommandArgument);

                string query = "SELECT COUNT(*) FROM warehouse_store WHERE store_id = @id";
                
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString))
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@id", id);
                    conn.Open();
                    int count = (int)cmd.ExecuteScalar();
                    if (count > 0)
                    {
                        lblErrorMessage.InnerText = "Cannot delete store. There are warehouses associated with this store.";
                        return;
                    }

                    query = "SELECT COUNT(*) FROM product_store WHERE store_id = @id";
                    cmd.CommandText = query;
                    count = (int)cmd.ExecuteScalar();
                    if (count > 0)
                    {
                        lblErrorMessage.InnerText = "Cannot delete store. There are products associated with this store.";
                        return;
                    }

                    query = "DELETE FROM stores WHERE id = @id";
                    cmd.CommandText = query;

                    cmd.ExecuteNonQuery();
                }

                BranchesGridView.DataBind();
            }
        }

    }
}