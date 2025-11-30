<%@ Page Title="" Language="C#" MasterPageFile="~/branches/MasterPage.Master" AutoEventWireup="true" CodeBehind="EditBranch.aspx.cs" Inherits="Jasmin_WP2_Project.branches.EditBranch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row justify-content-center">
        <div class="col-lg-8 col-xl-7">
            
            <div class="card my-4" style="border: 1px solid rgb(200,200,200);">
                <div class="card-header border-bottom border-secondary-subtle py-3">
                    <h3 class="text-secondary mb-0">
                        <i class="fas fa-store me-2 text-primary"></i> Update Branch Store
                    </h3>
                </div>
                <div class="card-body p-4 p-md-4">
                    
                    <div class="mb-4">
                        <asp:Label ID="lblStatusMessage" runat="server" CssClass="d-block"></asp:Label>
                    </div>

                    <div class="mb-4">
                        <label for="<%= txtName.ClientID %>" class="form-label text-light-emphasis">Branch Name</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="e.g., Downtown Flagship Store" required="required"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="NameValidator" runat="server" ControlToValidate="txtName" 
                            ErrorMessage="Branch Name is required." CssClass="text-danger small mt-1" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>

                    <div class="mb-4">
                        <label for="<%= txtCity.ClientID %>" class="form-label text-light-emphasis">City</label>
                        <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" placeholder="e.g., New York" required="required"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="CityValidator" runat="server" ControlToValidate="txtCity"
                            ErrorMessage="City is required." CssClass="text-danger small mt-1" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>

                    <div class="mb-4">
                        <label for="<%= txtAddress.ClientID %>" class="form-label text-light-emphasis">Full Address</label>
                        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Street, Neighborhood, Postal Code" required="required"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="AddressValidator" runat="server" ControlToValidate="txtAddress" 
                            ErrorMessage="Address is required." CssClass="text-danger small mt-1" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>

                    <div class="mb-4">
                        <label for="<%= txtPhone.ClientID %>" class="form-label text-light-emphasis">Phone Number</label>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" TextMode="Phone" placeholder="(555) 555-1234" required="required"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="PhoneValidator" runat="server" ControlToValidate="txtPhone" 
                            ErrorMessage="Phone Number is required." CssClass="text-danger small mt-1" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>

                    <div class="mb-4">
                        <label for="<%= fileUploadBrochure.ClientID %>" class="form-label text-light-emphasis">Prochoure File</label>
                        <asp:FileUpload CssClass="form-control" ID="fileUploadBrochure" runat="server" />
                        <asp:Label ID="lblFileUploadMessage" CssClass="text-danger" Text="" runat="server" />
                    </div>

                    <div class="mb-5">
                        <label for="<%= ddlManager.ClientID %>" class="form-label text-light-emphasis">Manager</label>
                        <asp:DropDownList CssClass="form-select" ID="ddlManager" runat="server" DataSourceID="Managers_Sql_DS" DataTextField="full_name" DataValueField="id"></asp:DropDownList>
                        <asp:SqlDataSource runat="server" ID="Managers_Sql_DS" ConnectionString='<%$ ConnectionStrings:DBConnectionString %>' SelectCommand="SELECT personal_information.id, (first_name + last_name) as full_name FROM personal_information Join roles ON personal_information.role_id = roles.id WHERE roles.type = 'manager'"></asp:SqlDataSource>
                        <asp:RequiredFieldValidator ID="ManagerIdValidator" runat="server" ControlToValidate="ddlManager" 
                            ErrorMessage="Manager is required." CssClass="text-danger small mt-1" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:Label ID="lblMangerStatus" CssClass="text-danger" Text="" runat="server" />
                    </div>
                    
                    <asp:Button ID="SubmitButton" runat="server" Text="Save" 
                                CssClass="btn btn-primary w-100 py-3" OnClick="SubmitButton_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
