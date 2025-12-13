<%@ Page Title="" Language="C#" MasterPageFile="~/branches/MasterPage.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Jasmin_WP2_Project.branches.Home" %>
<%@ MasterType VirtualPath="~/branches/MasterPage.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <h1 class="text-dark mb-4">Branch Store Management</h1>
    
    <div class="row mb-5 justify-content-center">
        <div class="col-lg-10">
            <div class="input-group">
                <asp:TextBox ID="SearchTextBox" runat="server" CssClass="form-control" placeholder="Search by Branch Name, City, or Manager ID..." ></asp:TextBox>
                <asp:Button ID="SearchButton" runat="server" Text="Search" OnClick="SearchButton_Click"
                            CssClass="btn btn-primary" />
            </div>
        </div>
    </div>

    <div class="card" style="background-color: #161b22; border: 1px solid #30363d;">
        <div class="card-header border-bottom border-secondary-subtle py-3">
            <h5 class="text-light mb-0">All Branches</h5>
            <p runat="server" class="text-danger" id="lblErrorMessage"></p>
        </div>
        <div class="card-body p-0">
            
            <asp:GridView ID="BranchesGridView" runat="server" AutoGenerateColumns="False"
                DataKeyNames="id" OnRowDataBound="BranchesGridView_RowDataBound"
                OnRowCommand="BranchesGridView_RowCommand"
                CssClass="table table-dark table-hover mb-0"
                HeaderStyle-CssClass="text-light-emphasis text-uppercase"
                RowStyle-CssClass="text-secondary"
                AlternatingRowStyle-CssClass="table-dark-alt"
                EmptyDataText="No branch stores found matching the criteria." DataSourceID="Stores_SQL_DS">
                
                <Columns>
                    <asp:BoundField DataField="id" HeaderText="id" ItemStyle-Width="5%" ItemStyle-CssClass="fw-bold" InsertVisible="False" ReadOnly="True" SortExpression="id" />
                    
                    <asp:BoundField DataField="name" HeaderText="name" ItemStyle-Width="15%" SortExpression="name" />
                    
                    <asp:BoundField DataField="city" HeaderText="city" ItemStyle-Width="15%" SortExpression="city" />
                    
                    <asp:BoundField DataField="address" HeaderText="address" ItemStyle-Width="20%" SortExpression="address" />
                    
                    <asp:BoundField DataField="phone" HeaderText="phone" ItemStyle-Width="15%" SortExpression="phone" />
                    
                    <asp:BoundField DataField="ManagerName" HeaderText="ManagerName" ItemStyle-Width="10%" ReadOnly="True" SortExpression="ManagerName" />
                
                
                    <asp:TemplateField HeaderText="Actions" ItemStyle-Width="20%">
                        <ItemTemplate>

                            <asp:HyperLink 
                                ID="LnkViewStore"
                                runat="server"
                                Text="View"
                                CssClass="btn btn-sm btn-secondary text-light"
                                NavigateUrl='<%# "~/branches/ViewBranch.aspx?id=" + Eval("id") %>' />

                            <asp:HyperLink 
                                ID="LnkUpdateStore"
                                runat="server"
                                Text="Edit"
                                CssClass="btn btn-sm btn-primary text-light"
                                NavigateUrl='<%# "~/branches/EditBranch.aspx?id=" + Eval("id") %>' />

                            <asp:LinkButton 
                                ID="btnDeleteStore" 
                                runat="server" 
                                Text="Delete" 
                                CssClass="btn btn-sm btn-danger text-light"
                                CommandName="DeleteStore"
                                CommandArgument='<%# Eval("id") %>'
                                OnClientClick="return confirm('Are you sure you want to delete this store?');" />

                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>

                <HeaderStyle BackColor="#161b22" ForeColor="#c9d1d9" Font-Bold="True" HorizontalAlign="Left" />
                <RowStyle BackColor="#161b22" />
                <AlternatingRowStyle BackColor="#101317" />
                <SelectedRowStyle BackColor="#2a6080" Font-Bold="True" ForeColor="White" />
                <FooterStyle BackColor="#30363d" ForeColor="White" Font-Bold="True" />
                <PagerStyle BackColor="#161b22" ForeColor="#c9d1d9" HorizontalAlign="Center" />
                
            </asp:GridView>
            <asp:SqlDataSource ID="Stores_SQL_DS" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT TOP (1000) stores.[id]
      ,stores.[name]
      ,stores.[city]
      ,stores.[address]
      ,stores.[phone]
      ,personal_information.[first_name] + ' ' + personal_information.last_name as ManagerName
  FROM [STORE_DB].[dbo].[stores] JOIN personal_information ON stores.manager_id = personal_information.user_id;
"></asp:SqlDataSource>
        </div>
    </div>
</asp:Content>
