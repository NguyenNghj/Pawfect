<%-- 
    Document   : profile
    Created on : Feb 11, 2025, 4:54:08 PM
    Author     : Vu Quang Duc - CE181221
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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

                                <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <img class="profile-img" src="${staff.image}" alt="">
                                </button>
                                <ul class="dropdown-menu ps-2 pe-2 pt-2 pb-2">
                                    <div class="d-grid gap-2">
                                        <% if ("Admin".equals(staffRole)) { %>
                                        <li class="profile-img-switch-employee d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-repeat"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="admin/dashboard.jsp">Switch to admin</a>
                                        </li>
                                        <% }%>
                                        <li class="profile-img-switch-store d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-store"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="#">Tới cửa hàng</a>
                                        </li>
                                        <hr style="margin: 0;">
                                        <li class="profile-img-info1 d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-user-pen"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="staffprofile">Hồ sơ</a>
                                        </li>
                                        <li class="profile-img-info2 d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-right-from-bracket" style="font-size: 20px;"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="logoutstaff">Đăng xuất</a>
                                        </li>
                                    </div>
                                </ul>
                            </div>                                                              
                        </div>
                    </div>

                    <div class="row mt-2 bg-white p-3 d-flex align-items-center justify-content-center" 
                         style="border-radius: 20px; height: 60px;">
                        <nav style="--bs-breadcrumb-divider: '>'; padding: 0 5px;" aria-label="breadcrumb">
                            <ol class="breadcrumb mb-0" style ="font-weight: bold;">
                                <li class="breadcrumb-item">Dashboard</li>
                                <li class="breadcrumb-item">Nhân viên</li>
                                <li class="breadcrumb-item active" aria-current="page">Hồ sơ người dùng</li>
                            </ol>
                        </nav>
                    </div>                     

                    <div class="row mt-3 align-items-center" style="background-color: white; padding: 20px; border-radius: 7px;">
                        <div class="col-4">
                            <div class="d-grid justify-content-center gap-3">
                                <img src="${staff.image}" alt=""
                                     style="width: 220px; height: 220px; border-radius: 50%; object-fit: cover;">
                                <div class="d-grid gap-1" style="text-align: center;">
                                    <%
                                        String message = (String) session.getAttribute("message");
                                        String messageType = (String) session.getAttribute("messageType");
                                        if (message != null) {
                                    %>
                                    <div class="alert <%= "success".equals(messageType) ? "alert-success" : "alert-danger"%>">
                                        <%= message%>
                                    </div>
                                    <%
                                            session.removeAttribute("message");
                                            session.removeAttribute("messageType");
                                        }
                                    %>
                                    <button type="button" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#changePassModal">
                                        Đổi mật khẩu
                                    </button>                                   
                                </div>
                            </div>
                        </div>
                        <input type="hidden" name="password" value="${staff.password}">
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

                        <div class="col d-grid gap-3">
                            <div class="d-grid gap-3 profile-info">
                                <h3 style="margin: 0;">Thông tin người dùng</h3>
                                <span><b>Họ tên:</b> ${staff.fullName}</span>
                                <span><b>Email:</b> ${staff.email}</span>
                                <span><b>Điện thoại:</b> ${staff.phone}</span>
                                <span><b>Địa chỉ:</b> ${staff.address}</span>
                                <span><b>Giới tính:</b> ${staff.gender}</span>
                                <span><b>Sinh nhật:</b> ${staff.birthDate}</span>
                            </div>
                            <div>
                                <button type="button" class="btn btn-success d-flex align-items-center gap-2"
                                        data-bs-toggle="modal" data-bs-target="#exampleModal"
                                        >
                                    <i class="fa-solid fa-pen"></i>
                                    <span>Sửa đổi</span>
                                </button>

                                <!-- Modal of Update User Info -->

                                <div class="modal fade" id="exampleModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                    <form action="staffprofile" method="POST" onsubmit="return validateStaffForm()">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h1 class="modal-title fs-5" id="exampleModalLabel">Chỉnh sửa thông tin</h1>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="form-floating mb-3">
                                                        <input type="text" class="form-control" name="name" value="${staff.fullName}" placeholder="Họ và tên">
                                                        <label>Full name</label>
                                                        <span id="nameError" class="text-danger"></span>
                                                    </div>

                                                    <div class="form-floating mb-3">
                                                        <input type="tel" class="form-control" name="phone" value="${staff.phone}" placeholder="Số điện thoại">
                                                        <label>Phone</label>
                                                        <span id="phoneError" class="text-danger"></span>
                                                    </div>

                                                    <div class="form-floating mb-3">
                                                        <input type="text" class="form-control" name="address" value="${staff.address}" placeholder="Địa chỉ">
                                                        <label>Address</label>
                                                        <span id="addressError" class="text-danger"></span>
                                                    </div>

                                                    <div class="form-floating mb-3">
                                                        <select class="form-select" name="gender">
                                                            <option value="Nam" ${staff.gender == 'Nam' ? "selected" : ""}>Nam</option>
                                                            <option value="Nữ" ${staff.gender == 'Nữ' ? "selected" : ""}>Nữ</option>
                                                        </select>
                                                        <label>Gender</label>
                                                    </div>

                                                    <div class="form-floating mb-3">
                                                        <input type="date" class="form-control" name="birthdate" value="${staff.birthDate}">
                                                        <label>Birthday</label>
                                                        <span id="birthdateError" class="text-danger"></span>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                    <input type="submit" value="Lưu" class="btn btn-primary">
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <script>
            function validateStaffForm() {
                let isValid = true;

                let name = document.getElementsByName("name")[0].value.trim();
                let phone = document.getElementsByName("phone")[0].value.trim();
                let address = document.getElementsByName("address")[0].value.trim();
                let birthdate = document.getElementsByName("birthdate")[0].value.trim();

                document.getElementById("nameError").innerHTML = "";
                document.getElementById("phoneError").innerHTML = "";
                document.getElementById("addressError").innerHTML = "";
                document.getElementById("birthdateError").innerHTML = "";

                // Kiểm tra Họ và Tên
                if (name === "") {
                    document.getElementById("nameError").innerHTML = "Vui lòng nhập họ và tên!";
                    isValid = false;
                }

                // Kiểm tra Số điện thoại (chỉ chấp nhận số, ít nhất 10 số)
                let phonePattern = /^[0-9]{10,11}$/;
                if (!phonePattern.test(phone)) {
                    document.getElementById("phoneError").innerHTML = "Số điện thoại không hợp lệ!";
                    isValid = false;
                }

                // Kiểm tra Địa chỉ
                if (address === "") {
                    document.getElementById("addressError").innerHTML = "Vui lòng nhập địa chỉ!";
                    isValid = false;
                }

                // Kiểm tra Ngày sinh
                if (birthdate === "") {
                    document.getElementById("birthdateError").innerHTML = "Vui lòng chọn ngày sinh!";
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
