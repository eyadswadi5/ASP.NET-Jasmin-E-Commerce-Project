<%@ Page Title="" Language="C#" MasterPageFile="~/branches/MasterPage.Master" AutoEventWireup="true" CodeBehind="AssignEmployees.aspx.cs" Inherits="Jasmin_WP2_Project.branches.AssignEmployees" %>
<%@ MasterType VirtualPath="~/branches/MasterPage.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="card my-4" style="border: 1px solid rgb(200,200,200);">
            <div class="card-header border-bottom border-secondary-subtle py-3">
                <h3 class="text-secondary mb-0">
                    <i class="fas fa-store me-2 text-primary"></i>Assign Employees to branches
                </h3>
            </div>
            <div class="card-body p-4 p-md-4">

                <div class="mb-4">
                    <asp:Label ID="lblStatusMessage" runat="server" CssClass="d-block"></asp:Label>
                </div>

                <div class="mb-5">
                    <label for="<%= ddlBranches.ClientID %>" class="form-label text-light-emphasis">Branch</label>
                    <asp:DropDownList CssClass="form-select" ID="ddlBranches" runat="server" DataSourceID="Branches_SQL_DS" DataTextField="name" DataValueField="id"></asp:DropDownList>
                    <asp:SqlDataSource runat="server" ID="Branches_SQL_DS" ConnectionString='<%$ ConnectionStrings:DBConnectionString %>' SelectCommand="SELECT [id], [name] FROM [stores]"></asp:SqlDataSource>
                    <asp:RequiredFieldValidator ID="BranchIdValidator" runat="server" ControlToValidate="ddlBranches"
                        ErrorMessage="Branch is required." CssClass="text-danger small mt-1" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:Label ID="lblBranchStatus" CssClass="text-danger" Text="" runat="server" />
                </div>

                <div class="mb-5">
                    <label for="<%= ChkBxEmps.ClientID %>" class="form-label text-light-emphasis">Unhired Employees</label>
                    <asp:CheckBoxList ID="ChkBxEmps" runat="server" DataSourceID="UnhiredEmployees" DataTextField="emp_name" DataValueField="id">
                    </asp:CheckBoxList>
                    <asp:SqlDataSource runat="server" ID="UnhiredEmployees" ConnectionString='<%$ ConnectionStrings:DBConnectionString %>' SelectCommand="SELECT TOP (1000) peri.[id]
      ,(peri.[first_name] + ' ' + peri.[last_name]) as emp_name
  FROM [STORE_DB].[dbo].[personal_information] as peri
  JOIN roles ON roles.id = peri.role_id
  JOIN departments as deps ON deps.id = peri.department_id
  WHERE peri.store_id IS NULL
  AND roles.type = 'employee'
  AND deps.name = 'branches';"></asp:SqlDataSource>
                </div>

                <asp:Button ID="SubmitButton" runat="server" Text="Apply"
                    CssClass="btn btn-primary w-100 py-3" OnClick="SubmitButton_Click"/>
            </div>
        </div>

    </div>

</asp:Content>
