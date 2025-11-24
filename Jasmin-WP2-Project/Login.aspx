<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Jasmin_WP2_Project.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login | E-Commerce Dashboard</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="~/lib/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="~/styles/style.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-12">
                    <div class="login-card">
                        <h1 class="text-center">Dashboard Login</h1>
                        
                        <div class="mb-3">
                            <asp:Label ID="lblMessage" runat="server" CssClass="text-danger"></asp:Label>
                        </div>

                        <div class="mb-4">
                            <label for="<%= txtUsername.ClientID %>" class="form-label text-light-emphasis">Username</label>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Enter you username" required="required"></asp:TextBox>
                        </div>

                        <div class="mb-4">
                            <label for="<%= txtPassword.ClientID %>" class="form-label text-light-emphasis">Password</label>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter your password" required="required"></asp:TextBox>
                        </div>
                        
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div class="form-check">
                                <asp:CheckBox ID="RememberMeCheckBox" runat="server" CssClass="form-check-input" />
                                <label class="form-check-label text-light-emphasis" for="<%= RememberMeCheckBox.ClientID %>">
                                    Remember me
                                </label>
                            </div>
                            <div class="forgot-password">
                                <a href="#">Forgot Password?</a>
                            </div>
                        </div>

                        <asp:Button ID="btnLogin" runat="server" Text="Sign In to Dashboard"
                                    CssClass="btn btn-primary w-100 py-2" OnClick="btnLogin_Click" />

                        <p class="mt-4 text-center text-secondary">
                            &copy; 2025 E-Commerce Dashboard
                        </p>
                    </div>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var emailInput = document.getElementById('<%= txtUsername.ClientID %>');
                if (emailInput) {
                    emailInput.focus();
                }
            });
        </script>
    </form>
    
    <script src="lib/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
