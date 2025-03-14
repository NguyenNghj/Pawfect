<%-- 
    Document   : regiser
    Created on : Feb 19, 2025, 4:12:43 PM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Pawfect - Đăng ký</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;600;800&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="./css/register.css">

    </head>
    <body>
        <div class="container-fluid p-0">
            <div class="row g-0 register-container">
                <!-- Illustration Side -->
                <div class="col-md-6 illustration-side">
                    <!--                    <img src="img/login/img.png" 
                                             alt="E-commerce illustration" class="img-fluid">-->
                </div>

                <!-- Form Side -->
                <div class="col-md-6 form-side position-relative">
                    <div class="register-form">
                        <h1 class="h4 mb-2 text-center title" style="font-weight: bold;">Pawfect - Đăng ký</h1>
                        <p style="text-align: center;">Xin chào, vui lòng nhập thông tin đăng ký</p>
                        <form action="register" method="POST"class="needs-validation" novalidate  onsubmit="return validateForm()">
                            <!-- Họ tên -->
                            <div class="mb-3">
                                <label for="fullName" class="form-label">Họ tên</label>
                                <input type="text" name="fullName"class="form-control" id="fullName" placeholder="Nhập họ tên đầy đủ" required>
                                <div class="invalid-feedback">
                                    Vui lòng nhập họ tên.
                                </div>
                            </div>
                            <% if (request.getAttribute("error") != null) {%>
                            <p style="color: black;"><%= request.getAttribute("error")%></p>
                            <% }%>
                            <!-- Email -->
                            <div class="mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" name="email" class="form-control" id="email" placeholder="Nhập email của bạn" required>
                                <div class="invalid-feedback">
                                    Vui lòng nhập email hợp lệ.
                                </div>
                            </div>

                            <!-- Số điện thoại -->
                            <div class="mb-3">
                                <label for="phone" class="form-label">Số điện thoại</label>
                                <input type="tel" class="form-control" name="phoneNumber" id="phone" placeholder="Nhập số điện thoại của bạn" required>
                                <div class="invalid-feedback">
                                    Vui lòng nhập số điện thoại.
                                </div>
                            </div>

                            <!-- Mật khẩu -->
                            <div class="mb-3 position-relative">
                                <label for="password" class="form-label">Mật khẩu</label>
                                <input type="password" class="form-control" name="password" id="password" placeholder="Nhập mật khẩu" required>
                                <i class="bi bi-eye-slash password-toggle" id="togglePassword"></i>
                                <div class="form-text">Mật khẩu phải có ít nhất 6 ký tự.</div>
                                <div class="invalid-feedback">
                                    Vui lòng nhập mật khẩu.
                                </div>
                            </div>

                            <!-- Nhập lại mật khẩu -->
                            <div class="mb-3 position-relative">
                                <label for="confirmPassword" class="form-label">Nhập lại mật khẩu</label>
                                <input type="confirmPassword" class="form-control" name="confirmPassword" id="confirmPassword" placeholder="Nhập lại mật khẩu" required>
                                <i class="bi bi-eye-slash password-toggle" id="toggleConfirmPassword"></i>
                                <div class="form-text">Mật khẩu phải có ít nhất 6 ký tự.</div>
                                <div class="invalid-feedback">
                                 Mật khẩu nhập lại không khớp
                                </div>

                            </div>

                            <!-- Ngày tháng năm sinh -->
                            <div class="mb-3">
                                <label for="birthdate" class="form-label">Ngày tháng năm sinh</label>
                                <input type="date" class="form-control" name="birthDate" id="birthdate" required>
                                <div class="invalid-feedback">
                                    Vui lòng chọn ngày sinh.
                                </div>
                            </div>

                            <!-- Địa chỉ -->
                            <div class="mb-3">
                                <label for="address" class="form-label">Địa chỉ</label>
                                <textarea class="form-control" id="address" name="address" rows="3" placeholder="Nhập địa chỉ đầy đủ" required></textarea>
                                <div class="invalid-feedback">
                                    Vui lòng nhập địa chỉ.
                                </div>
                            </div>

                            <!-- Giới tính -->
                            <div class="mb-4">
                                <label class="form-label">Giới tính</label>
                                <div class="d-flex gap-4">
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="gender" id="male" value="Nam" checked>
                                        <label class="form-check-label" for="male">
                                            Nam
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="gender" id="female" value="Nữ">
                                        <label class="form-check-label" for="female">
                                            Nữ
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="gender" id="other" value="Khác">
                                        <label class="form-check-label" for="other">
                                            Khác
                                        </label>
                                    </div>
                                </div>
                            </div>


                            <button type="submit" class="btn btn-primary w-100 mb-3">Đăng ký</button>
                        </form>
                        <div class="login-link">
                            Đã có tài khoản? <a href="login" class="text-decoration-none" style="color: var(--primary-color);">Đăng nhập</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Custom JavaScript -->
        <script>
           function validateForm() {
    let isValid = true;

    // Lấy giá trị từ các input
    let fullName = document.getElementById("fullName").value.trim();
    let email = document.getElementById("email").value.trim();
    let password = document.getElementById("password").value.trim();
    let confirmPassword = document.getElementById("confirmPassword").value.trim();
    let phoneNumber = document.getElementById("phone").value.trim();
    let birthDate = document.getElementById("birthdate").value;
    let address = document.getElementById("address").value.trim();

    // Xóa thông báo lỗi trước đó
    document.getElementById("fullName").classList.remove("is-invalid");
    document.getElementById("email").classList.remove("is-invalid");
    document.getElementById("password").classList.remove("is-invalid");
    document.getElementById("confirmPassword").classList.remove("is-invalid");
    document.getElementById("phone").classList.remove("is-invalid");
    document.getElementById("birthdate").classList.remove("is-invalid");
    document.getElementById("address").classList.remove("is-invalid");

    // Kiểm tra họ tên
    if (fullName === "") {
        document.getElementById("fullName").classList.add("is-invalid");
        isValid = false;
    }

    // Kiểm tra email
    let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    if (!emailPattern.test(email)) {
        document.getElementById("email").classList.add("is-invalid");
        isValid = false;
    }

    // Kiểm tra mật khẩu (tối thiểu 6 ký tự)
    if (password.length < 6) {
        document.getElementById("password").classList.add("is-invalid");
        isValid = false;
    }

    // Kiểm tra nhập lại mật khẩu
    if (confirmPassword !== password) {
        document.getElementById("confirmPassword").classList.add("is-invalid");
        isValid = false;
    }

    // Kiểm tra số điện thoại (chỉ cho phép số và 10-11 chữ số)
    let phonePattern = /^[0-9]{10,11}$/;
    if (!phonePattern.test(phoneNumber)) {
        document.getElementById("phone").classList.add("is-invalid");
        isValid = false;
    }

    // Kiểm tra ngày sinh (không được lớn hơn ngày hiện tại)
    let today = new Date().toISOString().split("T")[0];
    if (birthDate === "" || birthDate > today) {
        document.getElementById("birthdate").classList.add("is-invalid");
        isValid = false;
    }

    // Kiểm tra địa chỉ
    if (address === "") {
        document.getElementById("address").classList.add("is-invalid");
        isValid = false;
    }

    return isValid;
}


        </script>
    </body>
</html>
