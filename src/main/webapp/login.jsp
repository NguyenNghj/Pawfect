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
                    <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6KYofPjHBJzD0wDz_YLzcTZySiyqzSWXRRw&s" alt="E-commerce illustration" class="img-fluid">
                </div>
                <div class="col-md-6 form-side position-relative">
                    <div class="login-form">
                       <h1 class="title">Pawfect - Đăng nhập</h1>
<p style="text-align: center;">Xin chào, vui lòng nhập thông tin đăng nhập</p>

                        <% if (request.getAttribute("error") != null) { %>
                        <p style="color: red;"><%= request.getAttribute("error") %></p>
                        <% } %>

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
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-google text-danger" viewBox="0 0 16 16">
                                <path d="M15.545 6.558a9.42 9.42 0 0 1 .139 1.626c0 2.434-.87 4.492-2.384 5.885h.002C11.978 15.292 10.158 16 8 16A8 8 0 1 1 8 0a7.689 7.689 0 0 1 5.352 2.082l-2.284 2.284A4.347 4.347 0 0 0 8 3.166c-2.087 0-3.86 1.408-4.492 3.304a4.792 4.792 0 0 0 0 3.063h.003c.635 1.893 2.405 3.301 4.492 3.301 1.078 0 2.004-.276 2.722-.764h-.003a3.702 3.702 0 0 0 1.599-2.431H8v-3.08h7.545z" />
                            </svg>
                            Đăng nhập bằng Google
                        </a>

                        <div class="divider">Hoặc</div>
                        <a href="register" class="btn btn-primary w-100 mb-3">Đăng ký tài khoản</a>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
