<%-- 
    Document   : forgetpassword
    Created on : Feb 25, 2025, 7:57:10 AM
    Author     : LENOVO
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên Mật Khẩu</title>
    <link rel="stylesheet" href="./css/login.css">
    <link rel="stylesheet" href="./css/forgetpassword.css">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    

    <script>
        function validateEmail() {
            let emailField = document.getElementById("email");
            let emailError = document.getElementById("emailError");
            let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            
            emailError.innerHTML = "";
            emailField.style.borderColor = "#ced4da";

            if (!emailPattern.test(emailField.value)) {
                emailError.innerHTML = "Email không hợp lệ!";
                emailField.style.borderColor = "red";
                return false;
            }
            return true;
        }

        document.addEventListener("DOMContentLoaded", function () {
            document.getElementById("email").addEventListener("input", function () {
                document.getElementById("emailError").innerHTML = "";
                this.style.borderColor = "#ced4da";
            });
        });
    </script>
</head>
<body>
    <div class="wrapper">
        <form action="forgetpassword" method="POST" onsubmit="return validateEmail()">
            <h1>Quên Mật Khẩu</h1>
            
           <% if (request.getAttribute("message") != null) { %>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        Swal.fire({
            icon: 'success',
            title: 'Thành công!',
            text: "<%= request.getAttribute("message") %>",
            showConfirmButton: false,
            timer: 2000
        });
    </script>
<% } %>

<% if (request.getAttribute("error") != null) { %>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        Swal.fire({
            icon: 'error',
            title: 'Lỗi!',
            text: "<%= request.getAttribute("error") %>",
            confirmButtonText: 'OK'
        });
    </script>
<% } %>
            
            <div class="input-box">
                <input type="email" id="email" name="email" placeholder="Nhập email của bạn" required>
                <i class='bx bx-envelope icon'></i>
                <span id="emailError" class="error"></span>
            </div>
            
            <button type="submit" class="btn">Gửi Yêu Cầu</button>
            
            <div class="register-link">
                <p>Nhớ mật khẩu? <a href="login">Đăng nhập</a></p>
            </div>
        </form>
    </div>
</body>
</html>
