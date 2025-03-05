<%-- 
    Document   : newlogin
    Created on : Mar 5, 2025, 8:34:06 AM
    Author     : Nguyen Tri Nghi - CE180897
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Haravan - Đăng nhập</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;600;800&display=swap" rel="stylesheet">

        <link rel="stylesheet" href="./css/login.css">
    </head>
    <body>
        <div class="container-fluid p-0">
            <div class="row g-0 login-container">
                <!-- Illustration Side -->
                <div class="col-md-6 illustration-side">
                    <img src="https://hebbkx1anhila5yf.public.blob.vercel-storage.com/Screenshot%202025-03-05%20082433-IvPrhb0jUUfuVyPuJ76OdBkIQmpiSA.png" alt="E-commerce illustration" class="img-fluid">
                </div>

                <!-- Form Side -->
                <div class="col-md-6 form-side position-relative">

                    <div class="login-form">
                        <h1 class="h4 mb-2">Pawfect - Đăng nhập</h1>
                        <p class="text-muted mb-4">Xin chào, vui lòng nhập thông tin đăng nhập</p>

                        <form>
                            <div class="mb-3">
                                <input type="text" class="form-control" placeholder="Tên đăng nhập" required>
                            </div>

                            <div class="mb-3">
                                <input type="password" class="form-control" placeholder="Mật khẩu" required>
                            </div>

                            <div class="text-end mb-3">
                                <a href="#" class="text-decoration-none" style="color: var(--primary-color);">Quên mật khẩu</a>
                            </div>

                            <button type="submit" class="btn btn-primary w-100 mb-3">Đăng nhập</button>
                        </form>



                        <button class="btn btn-google w-100">
                            <svg class="google-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48" width="20px" height="20px">
                            <path fill="#FFC107" d="M43.611,20.083H42V20H24v8h11.303c-1.649,4.657-6.08,8-11.303,8c-6.627,0-12-5.373-12-12c0-6.627,5.373-12,12-12c3.059,0,5.842,1.154,7.961,3.039l5.657-5.657C34.046,6.053,29.268,4,24,4C12.955,4,4,12.955,4,24c0,11.045,8.955,20,20,20c11.045,0,20-8.955,20-20C44,22.659,43.862,21.35,43.611,20.083z"/>
                            <path fill="#FF3D00" d="M6.306,14.691l6.571,4.819C14.655,15.108,18.961,12,24,12c3.059,0,5.842,1.154,7.961,3.039l5.657-5.657C34.046,6.053,29.268,4,24,4C16.318,4,9.656,8.337,6.306,14.691z"/>
                            <path fill="#4CAF50" d="M24,44c5.166,0,9.86-1.977,13.409-5.192l-6.19-5.238C29.211,35.091,26.715,36,24,36c-5.202,0-9.619-3.317-11.283-7.946l-6.522,5.025C9.505,39.556,16.227,44,24,44z"/>
                            <path fill="#1976D2" d="M43.611,20.083H42V20H24v8h11.303c-0.792,2.237-2.231,4.166-4.087,5.571c0.001-0.001,0.002-0.001,0.003-0.002l6.19,5.238C36.971,39.205,44,34,44,24C44,22.659,43.862,21.35,43.611,20.083z"/>
                            </svg>
                            Đăng nhập bằng Google
                        </button>
                        <div class="divider">Hoặc</div>
                        <button type="submit" class="btn btn-primary w-100 mb-3">Đăng ký tài khoản</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

