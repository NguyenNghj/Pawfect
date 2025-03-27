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
                                    Vui lòng nhập họ tên và không được có ký tự đặc biệt.
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
                                    Mật khẩu phải có ít nhất 1 số 1 ký tự đặc biệt và 1 chữ cái
                                </div>
                            </div>

                            <!-- Nhập lại mật khẩu -->
                            <div class="mb-3 position-relative">
                                <label for="confirmPassword" class="form-label">Nhập lại mật khẩu</label>
                                <input type="Password" class="form-control" name="confirmPassword" id="confirmPassword" placeholder="Nhập lại mật khẩu" required>
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
                                <div class="invalid-feedb   Vui lòng chọn ngày sinhack">
                                    Vui lòng chọn ngày sinh và bạn phải trên 18 tuổi.
                                </div>
                            </div>

                            <!-- Địa chỉ -->
                            <div class="mb-3">
                                <label for="address" class="form-label">Địa chỉ</label>
                                <textarea class="form-control" id="address" name="address" rows="3" placeholder="Nhập địa chỉ đầy đủ" required></textarea>
                                <div class="invalid-feedback">
                                    Vui lòng nhập địa chỉ và địa chỉ không được có ký tự đặc biệt.
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
                            document.addEventListener("DOMContentLoaded", function () {
                                const form = document.querySelector("form");
                                form.addEventListener("submit", function (event) {
                                    let isValid = true;

                                    // Kiểm tra họ tên
                                    const fullName = document.getElementById("fullName");
                                    const namePattern = /^[A-Za-zÀ-Ỹà-ỹ\s]+$/; // Chỉ cho phép chữ cái và dấu cách

                                    if (fullName.value.trim() === "" || !namePattern.test(fullName.value)) {
                                        fullName.classList.add("is-invalid");
                                        isValid = false;
                                    } else {
                                        fullName.classList.remove("is-invalid");
                                    }

                                    // Kiểm tra email hợp lệ
                                    const email = document.getElementById("email");
                                    const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                                    if (!emailPattern.test(email.value)) {
                                        email.classList.add("is-invalid");
                                        isValid = false;
                                    } else {
                                        email.classList.remove("is-invalid");
                                    }

                                    // Kiểm tra số điện thoại
                                    const phone = document.getElementById("phone");
                                    const phonePattern = /^[0-9]{10,11}$/;
                                    if (!phonePattern.test(phone.value)) {
                                        phone.classList.add("is-invalid");
                                        isValid = false;
                                    } else {
                                        phone.classList.remove("is-invalid");
                                    }

                                    // Kiểm tra mật khẩu
                                    const password = document.getElementById("password");
                                    const passwordPattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{6,}$/;
                                    if (!passwordPattern.test(password.value)) {
                                        password.classList.add("is-invalid");
                                        isValid = false;
                                    } else {
                                        password.classList.remove("is-invalid");
                                    }

                                    // Kiểm tra nhập lại mật khẩu
                                    const confirmPassword = document.getElementById("confirmPassword");
                                    if (confirmPassword.value !== password.value) {
                                        confirmPassword.classList.add("is-invalid");
                                        isValid = false;
                                    } else {
                                        confirmPassword.classList.remove("is-invalid");
                                    }

                                    // Kiểm tra ngày sinh
                                    const birthDate = document.getElementById("birthdate");
                                    const today = new Date();
                                    const birthDateValue = new Date(birthDate.value);
                                    const minDate = new Date("1900-01-01");
                                    const age = today.getFullYear() - birthDateValue.getFullYear();
                                    const monthDiff = today.getMonth() - birthDateValue.getMonth();
                                    const dayDiff = today.getDate() - birthDateValue.getDate();
                                    const isUnder18 = age < 18 || (age === 18 && (monthDiff < 0 || (monthDiff === 0 && dayDiff < 0)));

                                    if (birthDate.value.trim() === "" || birthDateValue > today || birthDateValue < minDate || isUnder18) {
                                        birthDate.classList.add("is-invalid");
                                        isValid = false;
                                    } else {
                                        birthDate.classList.remove("is-invalid");
                                    }

                                    // Kiểm tra địa chỉ
                                    const address = document.getElementById("address");
                                    const addressPattern = /^[A-Za-zÀ-Ỹà-ỹ0-9\s,.-]+$/; 

                                    if (address.value.trim() === "") {
                                        address.classList.add("is-invalid");
                                        isValid = false;
                                    } else if (!addressPattern.test(address.value)) {
                                        address.classList.add("is-invalid");
                                        isValid = false;
                                    } else {
                                        address.classList.remove("is-invalid");
                                    }

                                    if (!isValid) {
                                        event.preventDefault();
                                    }
                                });

                                // Hiện/ẩn mật khẩu
                                document.getElementById("togglePassword").addEventListener("click", function () {
                                    togglePasswordVisibility("password", this);
                                });

                                document.getElementById("toggleConfirmPassword").addEventListener("click", function () {
                                    togglePasswordVisibility("confirmPassword", this);
                                });

                                function togglePasswordVisibility(inputId, icon) {
                                    const input = document.getElementById(inputId);
                                    if (input.type === "password") {
                                        input.type = "text";
                                        icon.classList.remove("bi-eye-slash");
                                        icon.classList.add("bi-eye");
                                    } else {
                                        input.type = "password";
                                        icon.classList.remove("bi-eye");
                                        icon.classList.add("bi-eye-slash");
                                    }
                                }
                            });
        </script>
    </body>
</html>
