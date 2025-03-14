<%-- 
    Document   : profile
    Created on : Feb 11, 2025, 3:54:46 PM
    Author     : Vu Quang Duc - CE181221
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;600;800&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="../../css/dashboard.css">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">

                <!-- SIDEBAR -->
                <jsp:include page="sidebar.jsp"/>


                <!-- MAIN -->
                <div class="col" id="main" style="padding: 0 40px;">
                    <div class="row pt-4">
                        <div class="d-flex align-items-center justify-content-between" style="padding: 0;">
                            <div>
                                <h1>Profile Settings</h1>
                            </div>
                            <div class="dropdown d-flex align-items-center gap-2">
                                <span>${staff.email}</span>
                                <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <img class="profile-img" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTf74k9hxcTCkLN2gyhCr9lzuzZax5iy0uDOA&s" alt="">
                                </button>
                                <ul class="dropdown-menu ps-2 pe-2 pt-2 pb-2">
                                    <div class="d-grid gap-2">
                                        <li class="profile-img-switch-employee d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-repeat"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="/dashboard/staff/dashboard.jsp">Switch to employee</a>
                                        </li>
                                        <li class="profile-img-switch-store d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-store"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="#">Go to store</a>
                                        </li>
                                        <hr style="margin: 0;">
                                        <li class="profile-img-info1 d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-user-pen"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="adminprofile">Profile</a>
                                        </li>
                                        <li class="profile-img-info2 d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-right-from-bracket" style="font-size: 20px;"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="logoutadmin">Logout</a>
                                        </li>
                                    </div>
                                </ul>
                            </div>                                                              
                        </div>
                    </div>

                    <div class="row mt-2">
                        <nav style="--bs-breadcrumb-divider: '>'; padding: 0 5px;" aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item" style="color: #6c757d;">Dashboard</li>
                                <li class="breadcrumb-item"><a href="dashboard">Home</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Profile</li>
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
                                    <button type="button" class="btn btn-link text-decoration-none" data-bs-toggle="modal" data-bs-target="#changePassModal">
                                        Đổi mật khẩu
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Modal Change Password -->
                        <div class="modal fade" id="changePassModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="changePassModalLabel" aria-hidden="true">
                            <form action="changeadminpassword" method="POST" onsubmit="return validatePassword()">
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
                                    <span>Update</span>
                                </button>

                                <!-- Modal of Update -->
                                <div class="modal fade" id="exampleModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                    <form action="adminprofile" method="POST" onsubmit="return validateStaffForm()">
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
        </script>
        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
        <script>
            const exampleModal = document.getElementById('exampleModal')
            if (exampleModal) {
                exampleModal.addEventListener('show.bs.modal', event => {
                    // Button that triggered the modal
                    const button = event.relatedTarget
                    // Extract info from data-bs-* attributes
                    const recipient = button.getAttribute('data-bs-whatever')
                    // If necessary, you could initiate an Ajax request here
                    // and then do the updating in a callback.

                    // Update the modal's content.
                    const modalTitle = exampleModal.querySelector('.modal-title')
                    const modalBodyInput = exampleModal.querySelector('.modal-body input')

                    modalTitle.textContent = `New message to ${recipient}`
                    modalBodyInput.value = recipient
                })
            }
        </script>
    </body>
</html>
