<%@ Page Title="" Language="C#" MasterPageFile="~/branches/MasterPage.Master" AutoEventWireup="true" CodeBehind="ViewBranch.aspx.cs" Inherits="Jasmin_WP2_Project.branches.ViewBranch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-white border-0 pb-0">
                        <p class="text-uppercase text-muted mb-1">Branch Overview</p>
                        <h2 class="h4 text-dark mb-0">Branch Details</h2>
                    </div>
                    <div class="card-body">
                        <div class="row g-4">
                            <div class="col-md-6">
                                <label for="<%= BranchNameLabel.ClientID %>" class="form-label text-muted">Branch Name</label>
                                <asp:Label ID="BranchNameLabel" runat="server" CssClass="form-control-plaintext fw-semibold text-dark">undefined</asp:Label>
                            </div>
                            <div class="col-md-6">
                                <label for="<%= WarehouseNameLabel.ClientID %>" class="form-label text-muted">Related Store Name</label>
                                <asp:Label ID="WarehouseNameLabel" runat="server" CssClass="form-control-plaintext text-dark">No related warehouses</asp:Label>
                            </div>
                            <div class="col-md-6">
                                <label for="<%= CityLabel.ClientID %>" class="form-label text-muted">City</label>
                                <asp:Label ID="CityLabel" runat="server" CssClass="form-control-plaintext text-dark">undefined</asp:Label>
                            </div>
                            <div class="col-md-6">
                                <label for="<%= AddressLabel.ClientID %>" class="form-label text-muted">Address</label>
                                <asp:Label ID="AddressLabel" runat="server" CssClass="form-control-plaintext text-dark">undefined</asp:Label>
                            </div>
                            <div class="col-md-6">
                                <label for="<%= PhoneLabel.ClientID %>" class="form-label text-muted">Phone</label>
                                <asp:Label ID="PhoneLabel" runat="server" CssClass="form-control-plaintext text-dark">undefined</asp:Label>
                            </div>
                            <div class="col-md-6">
                                <label for="<%= ManagerNameLabel.ClientID %>" class="form-label text-muted">Manager Name</label>
                                <asp:Label ID="ManagerNameLabel" runat="server" CssClass="form-control-plaintext text-dark">undefined</asp:Label>
                            </div>
                            <div class="col-md-6">
                                <label for="<%= ProductsCountLabel.ClientID %>" class="form-label text-muted">Number of Products</label>
                                <asp:Label ID="ProductsCountLabel" runat="server" CssClass="form-control-plaintext text-dark">No products where found</asp:Label>
                            </div>
                            <div class="col-md-6">
                                <label for="<%= BrochureUrlLabel.ClientID %>" class="form-label text-muted">Brochure File URL</label>
                                <asp:Label ID="BrochureUrlLabel" runat="server" CssClass="form-control-plaintext text-dark">undefined</asp:Label>
                            </div>
                        </div>
                        <div class="mt-4 d-flex justify-content-end">
                            <a id="LnkDownloadBrochure" href="#" runat="server" class="btn btn-outline-primary px-4" download="">Download Brochure</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
