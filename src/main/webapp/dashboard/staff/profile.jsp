<%-- 
    Document   : profile
    Created on : Feb 11, 2025, 4:54:08 PM
    Author     : Vu Quang Duc - CE181221
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;600;800&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="../../css/dashboard.css">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">

                <!-- SIDEBAR -->
                <jsp:include page="sidebar.jsp"/>
                <%
                    Cookie[] cookies = request.getCookies();
                    String staffRole = "";
                    String staffName = "";

                    if (cookies != null) {
                        for (Cookie cookie : cookies) {
                            String name = cookie.getName();
                            String value = cookie.getValue();

                            if ("staffRole".equals(name)) {
                                staffRole = value;
                            } else if ("staffName".equals(name)) {
                                staffName = value;
                            }

                            // Nếu đã lấy được cả hai giá trị thì thoát vòng lặp
                            if (!staffRole.isEmpty() && !staffName.isEmpty()) {
                                break;
                            }
                        }
                    }
                %>      

                <!-- MAIN -->
                <div class="col" id="main" style="padding: 0 40px;">
                    <div class="row pt-4">
                        <div class="d-flex align-items-center justify-content-between" style="padding: 0;">
                            <div>
                                <h1>Hồ sơ người dùng</h1>
                            </div>
                            <div class="dropdown d-flex align-items-center gap-2">
                                <span style = "color: #D3A376; font-weight: bold;"><%= staffName%></span>
                                <a href="staffprofile">
                                    <button class="btn" type="button">
                                        <img class="profile-img" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTf74k9hxcTCkLN2gyhCr9lzuzZax5iy0uDOA&s" alt="">
                                    </button>
                                </a>
                            </div>                                                             
                        </div>
                    </div>

                    <div class="row mt-2 bg-white p-3 d-flex align-items-center justify-content-center" 
                         style="border-radius: 20px; height: 60px;">
                        <nav style="--bs-breadcrumb-divider: '>'; padding: 0 5px;" aria-label="breadcrumb">
                            <ol class="breadcrumb mb-0" style ="font-weight: bold;">
                                <li class="breadcrumb-item">Bảng điều khiển</li>
                                <li class="breadcrumb-item">Nhân viên</li>
                                <li class="breadcrumb-item active" aria-current="page">Hồ sơ</li>
                            </ol>
                        </nav>
                    </div>                     

                    <div class="container">
                        <h5 class="card-title mb-4 justify-content-center text-center">Thông tin tài khoản</h5>  
                        <div class="row">
                            <div class="col-lg-4">
                                <div class="card mb-4">
                                    <div class="card-body text-center">
                                        <img src="/img/staff/${staff.image}" alt="avatar"
                                             class="rounded-circle img-fluid" style="width: 150px; height: 150px; object-fit: cover;">
                                        <h5 class="my-3" style="font-weight: bold;">${empty staff.fullName ? 'Chưa có thông tin' : staff.fullName}</h5>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-8">
                                <div class="card mb-4">
                                    <div class="card-body">                                                     
                                        <div class="row">
                                            <div class="col-sm-3 account-info-title"><p class="mb-0">Email</p></div>
                                            <div class="col-sm-9">
                                                <c:choose>
                                                    <c:when test="${not empty staff.email and fn:contains(staff.email, '@')}">
                                                        <p class="mb-0">${staff.email}</p>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <p class="mb-0">Đăng nhập bằng Google</p>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                        <hr>
                                        <div class="row">
                                            <div class="col-sm-3 account-info-title"><p class="mb-0">Điện thoại</p></div>
                                            <div class="col-sm-9"><p class="mb-0">${empty staff.phone ? 'Chưa có thông tin' : staff.phone}</p></div>
                                        </div>
                                        <hr>
                                        <div class="row">
                                            <div class="col-sm-3 account-info-title"><p class="mb-0">Ngày sinh</p></div>
                                            <div class="col-sm-9"><p class="mb-0">${empty staff.birthDate ? 'Chưa có thông tin' : staff.birthDate}</p></div>
                                        </div>
                                        <hr>
                                        <div class="row">
                                            <div class="col-sm-3 account-info-title"><p class="mb-0">Địa chỉ</p></div>
                                            <div class="col-sm-9"><p class="mb-0">${empty staff.address ? 'Chưa có thông tin' : staff.address}</p></div>
                                        </div>
                                        <hr>
                                        <div class="row">
                                            <div class="col-sm-3 account-info-title"><p class="mb-0">Giới tính</p></div>
                                            <div class="col-sm-9"><p class="mb-0">${empty staff.gender ? 'Chưa có thông tin' : staff.gender}</p></div>
                                        </div>
                                    </div>
                                </div>
                                <button type="button" class="btn btn-info mt-2" data-bs-toggle="modal" data-bs-target="#changePassModal">
                                    Đổi mật khẩu
                                </button>
                            </div>
                        </div>
                    </div>  


                    <!-- Modal Change Password -->
                    <div class="modal fade" id="changePassModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="changePassModalLabel" aria-hidden="true">
                        <form action="changestaffpassword" method="POST" onsubmit="return validatePassword()">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h1 class="modal-title fs-5" id="changePassModalLabel">Đổi mật khẩu</h1>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="mb-2">
                                            <label for="oldPassword" class="form-label">Mật khẩu cũ <span class="text-danger">*</span></label>
                                            <input type="password" name="password" class="form-control" id="oldPassword" required>
                                            <div class="text-danger" id="oldPasswordError"></div>
                                        </div>
                                        <div class="mb-2">
                                            <label for="newPassword" class="form-label">Mật khẩu mới <span class="text-danger">*</span></label>
                                            <input type="password" name="newPassword" class="form-control" id="newPassword" required>
                                            <div class="text-danger" id="newPasswordError"></div>
                                        </div>
                                        <div class="mb-2">
                                            <label for="confirmPassword" class="form-label">Xác nhận lại mật khẩu <span class="text-danger">*</span></label>
                                            <input type="password" name="newPassword2" class="form-control" id="confirmPassword" required>
                                            <div class="text-danger" id="confirmPasswordError"></div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                        <button type="submit" class="btn btn-primary">Đổi mật khẩu</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>

                </div>

            </div>
        </div>
        <script>
            function validateForm() {
                let isValid = true;

                // Lấy giá trị input và loại bỏ khoảng trắng đầu cuối
                let fullName = document.getElementsByName("name")[0].value.trim();
                let birthDate = document.getElementsByName("birthdate")[0].value.trim();
                let phoneNumber = document.getElementsByName("phone")[0].value.trim();
                let address = document.getElementsByName("address")[0].value.trim();

                // Định dạng kiểm tra
                let phonePattern = /^[0-9]{10,11}$/;
                let today = new Date().toISOString().split("T")[0];

                // Xóa thông báo lỗi cũ
                document.getElementById("nameError").innerHTML = "";
                document.getElementById("birthdateError").innerHTML = "";
                document.getElementById("phoneError").innerHTML = "";
                document.getElementById("addressError").innerHTML = "";

                // Kiểm tra Họ tên (không được chỉ có khoảng trắng và phải có ít nhất 3 ký tự)
                if (fullName.length < 3 || fullName.replace(/\s/g, "").length === 0) {
                    document.getElementById("nameError").innerHTML = "Họ tên phải có ít nhất 3 ký tự và không được chỉ có khoảng trắng!";
                    isValid = false;
                }

                // Kiểm tra Ngày sinh
                if (!birthDate) {
                    document.getElementById("birthdateError").innerHTML = "Vui lòng chọn ngày sinh!";
                    isValid = false;
                } else if (birthDate > today) {
                    document.getElementById("birthdateError").innerHTML = "Ngày sinh không thể lớn hơn ngày hiện tại!";
                    isValid = false;
                }

                // Kiểm tra Số điện thoại (phải có 10-11 chữ số)
                if (!phonePattern.test(phoneNumber)) {
                    document.getElementById("phoneError").innerHTML = "Số điện thoại không hợp lệ!";
                    isValid = false;
                }

                // Kiểm tra Địa chỉ (không được chỉ có khoảng trắng và phải có ít nhất 5 ký tự)
                if (address.length < 5 || address.replace(/\s/g, "").length === 0) {
                    document.getElementById("addressError").innerHTML = "Địa chỉ phải có ít nhất 5 ký tự và không được chỉ có khoảng trắng!";
                    isValid = false;
                }

                return isValid;
            }

            function validatePassword() {
                let isValid = true;
                let oldPassword = document.getElementById("oldPassword").value.trim();
                let newPassword = document.getElementById("newPassword").value.trim();
                let confirmPassword = document.getElementById("confirmPassword").value.trim();


                document.getElementById("oldPasswordError").innerHTML = "";
                document.getElementById("newPasswordError").innerHTML = "";
                document.getElementById("confirmPasswordError").innerHTML = "";


                if (oldPassword === "") {
                    document.getElementById("oldPasswordError").innerHTML = "Vui lòng nhập mật khẩu cũ!";
                    isValid = false;
                }


                if (newPassword.length < 6) {
                    document.getElementById("newPasswordError").innerHTML = "Mật khẩu mới phải có ít nhất 6 ký tự!";
                    isValid = false;
                }


                if (newPassword !== confirmPassword) {
                    document.getElementById("confirmPasswordError").innerHTML = "Mật khẩu xác nhận không khớp!";
                    isValid = false;
                }

                return isValid;
            }
        </script>

        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    </body>
</html>
