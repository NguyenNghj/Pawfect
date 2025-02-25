<%-- 
    Document   : Login
    Created on : Feb 17, 2025, 10:27:58 PM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="./css/login.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <script>
        function validateForm() {
            let isValid = true;
            let email = document.getElementById("email").value;
            let password = document.getElementById("password").value;
            let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

            document.getElementById("emailError").innerHTML = "";
            document.getElementById("passwordError").innerHTML = "";

            if (!emailPattern.test(email)) {
                document.getElementById("emailError").innerHTML = "Email không hợp lệ!";
                isValid = false;
            }

            if (password.length < 6) {
                document.getElementById("passwordError").innerHTML = "Mật khẩu phải có ít nhất 6 ký tự!";
                isValid = false;
            }

            return isValid;
        }
    </script>
   
</head>
<body>
    <div class="wrapper">
        <form action="loginstaff" method="POST" onsubmit="return validateForm()">
            <h1>Login For Staff</h1>
            
            <% if (request.getParameter("error") != null) { %>
                <p style=" text-align: center;">Sai email hoặc mật khẩu. Vui lòng thử lại.</p>
            <% } %>
            
            <div class="input-box">
                <input type="text" id="email" name="email" placeholder="Email" >
                <i class='bx bxs-user icon'></i>
                <span id="emailError" class="error"></span>
            </div>
            
            <div class="input-box">
                <input type="password" id="password" name="password" placeholder="Password" >
                <i class='bx bx-lock-alt icon'></i>
                <span id="passwordError" class="error"></span>
            </div>
                  
            <button type="submit" class="btn">Login</button>

            
        </form>
              </div>
</body>
</html>
