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
 
        <img src="img/login/img.png" 
             alt="E-commerce illustration" class="img-fluid">
  
</div>
                <div class="col-md-6 form-side position-relative">
                    <div class="login-form">
                        <h1 class="title">Pawfect - Đăng nhập</h1>
                        <p style="text-align: center;">Xin chào, vui lòng nhập thông tin đăng nhập</p>

                        <% if (request.getAttribute("error") != null) {%>
                        <p style="color: red;"><%= request.getAttribute("error")%></p>
                        <% }%>

                        <form action="login" method="POST" onsubmit="return validateForm()">
                            <div class="mb-3">
                                <input type="text" id="email" name="email" class="form-control" placeholder="Email" required>
                                <span id="emailError" class="error text-danger"></span>
                            </div>

                            <div class="mb-3">
                                <input type="password" id="password" name="password" class="form-control" placeholder="Mật khẩu" required>
                                <span id="passwordError" class="error text-danger"></span>
                            </div>

                            <div class="text-end mb-3">
                                <a href="forgetpassword" class="text-decoration-none" style="color: var(--primary-color);">Quên mật khẩu?</a>
                            </div>

                            <button type="submit" class="btn btn-primary w-100 mb-3">Đăng nhập</button>
                        </form>

                        <a class="btn btn-google w-100" href="https://accounts.google.com/o/oauth2/auth?scope=email profile openid&redirect_uri=http://localhost:8080/GoogleLoginServlet&response_type=code&client_id=294264350287-37gq949okctp7k1mhet86u4h136c03vh.apps.googleusercontent.com&approval_prompt=force">
                            <svg class="google-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48" width="20px" height="20px">
                            <path fill="#FFC107" d="M43.611,20.083H42V20H24v8h11.303c-1.649,4.657-6.08,8-11.303,8c-6.627,0-12-5.373-12-12c0-6.627,5.373-12,12-12c3.059,0,5.842,1.154,7.961,3.039l5.657-5.657C34.046,6.053,29.268,4,24,4C12.955,4,4,12.955,4,24c0,11.045,8.955,20,20,20c11.045,0,20-8.955,20-20C44,22.659,43.862,21.35,43.611,20.083z"/>
                            <path fill="#FF3D00" d="M6.306,14.691l6.571,4.819C14.655,15.108,18.961,12,24,12c3.059,0,5.842,1.154,7.961,3.039l5.657-5.657C34.046,6.053,29.268,4,24,4C16.318,4,9.656,8.337,6.306,14.691z"/>
                            <path fill="#4CAF50" d="M24,44c5.166,0,9.86-1.977,13.409-5.192l-6.19-5.238C29.211,35.091,26.715,36,24,36c-5.202,0-9.619-3.317-11.283-7.946l-6.522,5.025C9.505,39.556,16.227,44,24,44z"/>
                            <path fill="#1976D2" d="M43.611,20.083H42V20H24v8h11.303c-0.792,2.237-2.231,4.166-4.087,5.571c0.001-0.001,0.002-0.001,0.003-0.002l6.19,5.238C36.971,39.205,44,34,44,24C44,22.659,43.862,21.35,43.611,20.083z"/>
                            </svg>
                            Đăng nhập bằng Google
                        </a>

                        <div class="divider">Hoặc</div>
                        <a href="register" class="btn btn-primary w-100 mb-3" style="align-content: center">Đăng ký tài khoản</a>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
