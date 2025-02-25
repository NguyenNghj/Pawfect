<%-- 
    Document   : forgetpassword
    Created on : Feb 25, 2025, 7:57:10 AM
    Author     : LENOVO
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password</title>
    <link rel="stylesheet" href="./css/login.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <script>
        function validateEmail() {
            let email = document.getElementById("email").value;
            let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            document.getElementById("emailError").innerHTML = "";
            
            if (!emailPattern.test(email)) {
                document.getElementById("emailError").innerHTML = "Email không hợp lệ!";
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <div class="wrapper">
        <form action="ForgetPassword" method="POST" onsubmit="return validateEmail()">
            <h1>Forgot Password</h1>
            
            <% if (request.getAttribute("message") != null) { %>
                <p style="color:green; text-align: center;"><%= request.getAttribute("message") %></p>
            <% } %>

            <% if (request.getAttribute("error") != null) { %>
                <p style="color:red; text-align: center;"><%= request.getAttribute("error") %></p>
            <% } %>
            
            <div class="input-box">
                <input type="email" id="email" name="email" placeholder="Enter your email" required>
                <i class='bx bx-envelope icon'></i>
                <span id="emailError" class="error"></span>
            </div>
            
            <button type="submit" class="btn">Submit</button>
            
            <div class="register-link">
                <p>Remember your password? <a href="LoginServlet">Login</a></p>
            </div>
        </form>
    </div>
</body>
</html>