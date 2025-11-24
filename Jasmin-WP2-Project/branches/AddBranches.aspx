<%@ Page Title="" Language="C#" MasterPageFile="~/branches/MasterPage.Master" AutoEventWireup="true" CodeBehind="AddBranches.aspx.cs" Inherits="Jasmin_WP2_Project.branches.AddBranches" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row justify-content-center">
        <div class="col-lg-8 col-xl-7">
            
            <!-- Form Card for "Add New Branch" -->
            <div class="card my-4" style="border: 1px solid rgb(200,200,200);">
                <div class="card-header border-bottom border-secondary-subtle py-3">
                    <h3 class="text-secondary mb-0">
                        <i class="fas fa-store me-2 text-primary"></i> Add New Branch Store
                    </h3>
                </div>
                <div class="card-body p-4 p-md-4">
                    
                    <!-- Confirmation/Error Message Placeholder -->
                    <div class="mb-4">
                        <asp:Label ID="MessageLabel" runat="server" CssClass="d-block"></asp:Label>
                    </div>

                    <!-- 1. Branch Name (name) -->
                    <div class="mb-4">
                        <label for="<%= BranchNameTextBox.ClientID %>" class="form-label text-light-emphasis">Branch Name</label>
                        <asp:TextBox ID="BranchNameTextBox" runat="server" CssClass="form-control" placeholder="e.g., Downtown Flagship Store" required="required"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="NameValidator" runat="server" ControlToValidate="BranchNameTextBox" 
                            ErrorMessage="Branch Name is required." CssClass="text-danger small mt-1" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>

                    <!-- 2. City (city) -->
                    <div class="mb-4">
                        <label for="<%= CityTextBox.ClientID %>" class="form-label text-light-emphasis">City</label>
                        <asp:TextBox ID="CityTextBox" runat="server" CssClass="form-control" placeholder="e.g., New York" required="required"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="CityValidator" runat="server" ControlToValidate="CityTextBox" 
                            ErrorMessage="City is required." CssClass="text-danger small mt-1" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>

                    <!-- 3. Address (address) -->
                    <div class="mb-4">
                        <label for="<%= AddressTextBox.ClientID %>" class="form-label text-light-emphasis">Full Address</label>
                        <asp:TextBox ID="AddressTextBox" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Street, Neighborhood, Postal Code" required="required"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="AddressValidator" runat="server" ControlToValidate="AddressTextBox" 
                            ErrorMessage="Address is required." CssClass="text-danger small mt-1" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>

                    <!-- 4. Phone (phone) -->
                    <div class="mb-4">
                        <label for="<%= PhoneTextBox.ClientID %>" class="form-label text-light-emphasis">Phone Number</label>
                        <asp:TextBox ID="PhoneTextBox" runat="server" CssClass="form-control" TextMode="Phone" placeholder="(555) 555-1234" required="required"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="PhoneValidator" runat="server" ControlToValidate="PhoneTextBox" 
                            ErrorMessage="Phone Number is required." CssClass="text-danger small mt-1" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>

                    <!-- 5. Logo URL (file_url) -->
                    <div class="mb-4">
                        <label for="<%= fu_prochoure.ClientID %>" class="form-label text-light-emphasis">Prochoure File</label>
                        <asp:FileUpload CssClass="form-control" ID="fu_prochoure" runat="server" />

                    </div>

                    <!-- 6. Manager ID (manager_id) -->
                    <div class="mb-5">
                        <label for="<%= ddlManager.ClientID %>" class="form-label text-light-emphasis">Manager</label>
                        <asp:DropDownList CssClass="form-select" ID="ddlManager" runat="server" DataSourceID="Managers_Sql_DS" DataTextField="full_name" DataValueField="id"></asp:DropDownList>
                        <asp:SqlDataSource runat="server" ID="Managers_Sql_DS" ConnectionString='<%$ ConnectionStrings:DBConnectionString %>' SelectCommand="SELECT personal_information.id, (first_name + last_name) as full_name FROM personal_information Join roles ON personal_information.role_id = roles.id WHERE roles.type = 'manager'"></asp:SqlDataSource>
                        <asp:RequiredFieldValidator ID="ManagerIdValidator" runat="server" ControlToValidate="ddlManager" 
                            ErrorMessage="Manager is required." CssClass="text-danger small mt-1" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                    
                    <!-- Submit Button -->
                    <asp:Button ID="SubmitButton" runat="server" Text="Save New Branch" 
                                CssClass="btn btn-primary w-100 py-3" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
