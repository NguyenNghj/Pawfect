<%-- 
    Document   : Login
    Created on : Feb 17, 2025, 10:27:58 PM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Pawfect - Đăng nhập</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;600;800&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="./css/login.css">
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
        <div class="container-fluid p-0">
            <div class="row g-0 login-container">
                <div class="col-md-6 illustration-side">
  <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6KYofPjHBJzD0wDz_YLzcTZySiyqzSWXRRw&s" alt="E-commerce illustration" class="img-fluid">                </div>
                <div class="col-md-6 form-side d-flex align-items-center justify-content-center">
                    <div class="login-form text-center">
                        <h1 class="mb-4">Đăng nhập cho nhân viên</h1>
                        <% if (request.getParameter("error") != null) { %>
                        <p class="text-danger">Sai email hoặc mật khẩu. Vui lòng thử lại.</p>
                        <% } %>
                        <form action="loginstaff" method="POST" onsubmit="return validateForm()">
                            <div class="mb-3">
                                <input type="text" id="email" name="email" class="form-control" placeholder="Email">
                                <span id="emailError" class="text-danger"></span>
                            </div>
                            <div class="mb-3">
                                <input type="password" id="password" name="password" class="form-control" placeholder="Mật khẩu">
                                <span id="passwordError" class="text-danger"></span>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">Đăng nhập</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>