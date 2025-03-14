<%-- 
    Document   : changepassword
    Created on : Feb 17, 2025, 2:55:46 PM
    Author     : Vu Quang Duc - CE181221
--%>

<%@include file="./components/header.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="./css/account.css">
    </head>
    <body>
        <div class="container py-4">
            <!-- Breadcrumb -->
            <div class="row mt-2 bg-white p-3 mb-4 d-flex align-items-center justify-content-center" 
                 style="border-radius: 20px; height: 60px;">
                <nav padding: 0 5px;" aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0" style ="font-weight: bold;">
                        <li class="breadcrumb-item"><a href="pawfect" class="text-decoration-none">Trang chủ</a></li>
                        <li class="breadcrumb-item"><a href="profile" class="text-decoration-none">Tài khoản</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Thay đổi mật khẩu</li>
                    </ol>
                </nav>
            </div>

            <div class="row g-4">
                <!-- Main Content -->
                <div class="col-md-8">
                    <!-- Top Cards -->
                    <form action="changepassword" method="POST" onsubmit="return validatePasswordForm()">
                        <!-- Orders Section -->
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title mb-2">Đổi mật khẩu</h5>
                                <%
                                    String message = (String) session.getAttribute("message");
                                    String messageType = (String) session.getAttribute("messageType");
                                    if (message != null) {
                                %>
                                <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
                                <script>
                        Swal.fire({
                            icon: '<%= "success".equals(messageType) ? "success" : "error"%>',
                            title: '<%= "success".equals(messageType) ? "Thành công!" : "Lỗi!"%>',
                            text: "<%= message%>",
                            showConfirmButton: <%= "success".equals(messageType) ? "false" : "true"%>,
                            timer: <%= "success".equals(messageType) ? "2000" : "null"%>
                        }).then(() => {
                                    <% if ("success".equals(messageType)) { %>
                            window.location.href = "logout";
                                    <% } %>
                        });
                                </script>
                                <%
                                        session.removeAttribute("message");
                                        session.removeAttribute("messageType");
                                    }
                                %>

                                <p style="color: #4c4c4c;">Để đảm bảo tính bảo mật vui lòng đặt mật khẩu với ít nhất 6 kí tự</p>
                                <div class="d-grid gap-2 account-info">
                                    <div class="mb-2 mt-2">
                                        <label class="form-label">Mật khẩu cũ <span style="color: red;">*</span></label>
                                        <input type="password" class="form-control" name="password" id="oldPassword">
                                        <small id="oldPasswordError" class="text-danger"></small>
                                    </div>
                                    <div class="mb-2">
                                        <label class="form-label">Mật khẩu mới <span style="color: red;">*</span></label>
                                        <input type="password" name="newPassword" class="form-control" id="newPassword">
                                        <small id="newPasswordError" class="text-danger"></small>
                                    </div>
                                    <div class="mb-2">
                                        <label class="form-label">Xác nhận lại mật khẩu <span style="color: red;">*</span></label>
                                        <input type="password" class="form-control" id="confirmPassword">
                                        <small id="confirmPasswordError" class="text-danger"></small>
                                    </div>
                                </div>
                                <div class="mt-2">
                                    <button type="submit" class="btn btn-primary" >Đổi mật khẩu</button>
                                </div>                        
                            </div>
                        </div>
                    </form>
                </div>

                <!-- Sidebar -->
                <div class="col-md-4">
                    <div class="list-group account-action">
                        <!-- Thông tin cá nhân -->
                        <a href="profile" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="fa-regular fa-user fa-lg" style="color: #0062ad;"></i>
                            <span>Thông tin cá nhân</b</span>
                        </a>
                        <!-- Thú cưng của tôi -->
                        <a href="viewpet" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="fa-solid fa-paw fa-lg" style="color: #8C6E63;"></i>
                            <span>Thú cưng của tôi</span>
                        </a>
                        <!-- Đổi mật khẩu -->
                        <a href="changepassword" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="fa-solid fa-key fa-lg" style="color: #eabd1a;"></i>
                            <span style="color: #D3A376;"><b>Đổi mật khẩu</b></span>
                        </a>
                        <a href="order?&action=view&status=tc" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="bi bi-clipboard-check fs-4" style="color: #008080;"></i>
                            <span>Lịch sử đơn hàng</span>
                        </a>
                        <a href="bookinghistory" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="bi bi-calendar-date fs-4" style="color: #808000;"></i>
                            <span>Lịch sử đặt lịch</span>
                        </a>
                        <!-- Đăng xuất -->
                        <a href="logout" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="fa-solid fa-arrow-right-from-bracket fa-lg" style="color: #d01616;"></i>
                            <span>Đăng xuất</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
    </body>
    <script>
                        function validatePasswordForm() {
                            let isValid = true;

                            // Lấy giá trị input
                            let oldPassword = document.getElementById("oldPassword").value.trim();
                            let newPassword = document.getElementById("newPassword").value.trim();
                            let confirmPassword = document.getElementById("confirmPassword").value.trim();

                            // Xóa thông báo lỗi cũ
                            document.getElementById("oldPasswordError").innerHTML = "";
                            document.getElementById("newPasswordError").innerHTML = "";
                            document.getElementById("confirmPasswordError").innerHTML = "";

                            // Kiểm tra Mật khẩu cũ
                            if (oldPassword === "") {
                                document.getElementById("oldPasswordError").innerHTML = "Vui lòng nhập mật khẩu cũ!";
                                isValid = false;
                            }
                            if (oldPassword.length < 6) {
                                document.getElementById("oldPasswordError").innerHTML = "Mật khẩu phải có ít nhất 6 ký tự!";
                                isValid = false;
                            }

                            // Kiểm tra Mật khẩu mới
                            if (newPassword.length < 6) {
                                document.getElementById("newPasswordError").innerHTML = "Mật khẩu mới phải có ít nhất 6 ký tự!";
                                isValid = false;
                            }

                            // Kiểm tra Xác nhận mật khẩu
                            if (confirmPassword === "") {
                                document.getElementById("confirmPasswordError").innerHTML = "Vui lòng nhập lại mật khẩu!";
                                isValid = false;
                            } else if (confirmPassword !== newPassword) {
                                document.getElementById("confirmPasswordError").innerHTML = "Mật khẩu xác nhận không khớp!";
                                isValid = false;
                            }

                            // Nếu tất cả hợp lệ, hiển thị hộp thoại xác nhận
                            if (isValid) {
                                return confirm("Bạn có chắc chắn muốn đổi mật khẩu không?");
                            }

                            return false;
                        }

    </script>
</html>
