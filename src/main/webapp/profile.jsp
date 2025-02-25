<%-- 
    Document   : profile
    Created on : Feb 17, 2025, 2:54:05 PM
    Author     : Vu Quang Duc - CE181221
--%>

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
            <nav aria-label="breadcrumb" class="mb-4">
                <ol class="breadcrumb p-3" style="background-color: white; border-radius: 5px;">
                    <li class="breadcrumb-item"><a href="#" class="text-decoration-none">Trang chủ</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Tài khoản</li>
                </ol>
            </nav>

            <div class="row g-4">
                <!-- Main Content -->
                <div class="col-md-8">
                    <!-- Top Cards -->
                    <div class="row g-4 mb-4">

                        <!-- Lịch sử đơn hàng -->
                        <div class="col-md-4">
                            <div class="card h-100">
                                <div class="card-body d-flex align-items-center gap-3">
                                    <i class="bi bi-clipboard-check fs-4 text-primary"></i>
                                    <a href="#" class="text-decoration-none text-dark">
                                        Lịch sử đơn hàng
                                    </a>
                                </div>
                            </div>
                        </div>
                        <!-- Lịch sử đật lịch -->
                        <div class="col-md-4">
                            <div class="card h-100">
                                <div class="card-body d-flex align-items-center gap-3">
                                    <i class="bi bi-calendar-date fs-4 text-primary"></i>
                                    <a href="#" class="text-decoration-none text-dark">Lịch sử đặt lịch</a>
                                </div>
                            </div>
                        </div>
                        <!-- Xin chào khách hàng -->
                        <div class="col-md-4">
                            <div class="card h-100">
                                <div class="card-body d-flex align-items-center gap-3">
                                    <i class="bi bi-person-circle fs-4"></i>
                                    <span>Xin chào, <span class="text-primary">[${customer.fullName}]</span></span>
                                </div>
                            </div>
                        </div>
                    </div>
<% 
    String message = (String) session.getAttribute("message");
    String messageType = (String) session.getAttribute("messageType");
    if (message != null) { 
%>
    <div class="alert alert-<%= "success".equals(messageType) ? "success" : "danger" %>">
        <%= message %>
    </div>
<% 
    session.removeAttribute("message");
    session.removeAttribute("messageType");
    } 
%>

                    <!-- Orders Section -->
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title mb-4">Thông tin tài khoản</h5>
                            <div class="d-grid gap-2 account-info">
                                <span><span class="account-info-title">Họ tên:</span> ${customer.fullName} / <span class="account-info-title">Giới tính:</span> ${customer.gender}</span>
                                <span><span class="account-info-title">Ngày sinh:</span> ${customer.birthDate}</span>
                                <span><span  class="account-info-title">Email:</span> ${customer.email}</span>
                                <span><span class="account-info-title">Điện thoại:</span> ${customer.phoneNumber}</span>
                                <span><span class="account-info-title">Địa chỉ:</span> ${customer.address}</span>
                            </div>
                            <div class="mt-3">
                                <button type="button" class="btn btn-success" 
                                        data-bs-toggle="modal" data-bs-target="#exampleModal"
                                        >
                                    Chỉnh sửa thông tin
                                </button>
                                <form action="Profile" method="POST" onsubmit="return validateForm()">
                                    <!-- Modal -->
                                    <div class="modal fade" id="exampleModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h1 class="modal-title fs-5" id="exampleModalLabel">Chỉnh sửa thông tin</h1>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="d-flex justify-content-between">
                                                        <!-- Họ tên -->
                                                        <div class="mb-2 col-8">
                                                            <label class="form-label">Họ tên</label>
                                                            <input type="text" value="${customer.fullName}" name="fullName" class="form-control">
                                                            <small id="fullNameError" class="text-danger"></small>
                                                        </div>                                                        <!-- Giới tính -->
                                                        <div class="mb-2 col-3">
                                                            <label for="formGroupExampleInput2" class="form-label">Giới tính</label>
                                                            <select class="form-select" name="gender" aria-label="Default select example">
                                                                <option value="Khác" ${customer.gender == 'Khác' ? "selected" : ""}>Khác</option>
                                                                <option value="Nam" ${customer.gender == 'Nam' ? "selected" : ""}>Nam</option>
                                                                <option value="Nữ" ${customer.gender == 'Nữ' ? "selected" : ""}>Nữ</option>
                                                            </select>
                                                        </div>                         
                                                    </div>

                                                    <!-- Ngày sinh -->
                                                    <div class="mb-2">
                                                        <label class="form-label">Ngày sinh</label>
                                                        <input type="date" value="${customer.birthDate}" name="birthDate" class="form-control">
                                                        <small id="birthDateError" class="text-danger"></small>
                                                    </div>
                                                    <!-- Email -->
                                                    <div class="mb-2">
                                                        <label class="form-label">Email</label>
                                                        <input type="password" value="${customer.email}" name="email" class="form-control" readonly>
                                                        
                                                    </div>

                                                    <div class="mb-2">
                                                        <label for="formGroupExampleInput4" class="form-label">Mật khẩu</label>
                                                        <input type="password" value="${customer.password}" name="password" class="form-control" id="formGroupExampleInput4"  readonly>
                                                    </div>
                                                    <!-- Điện thoại -->
                                                    <div class="mb-2">
                                                        <label class="form-label">Điện thoại</label>
                                                        <input type="tel" value="${customer.phoneNumber}" name="phoneNumber" class="form-control">
                                                        <small id="phoneError" class="text-danger"></small>
                                                    </div>
                                                    <!-- Địa chỉ -->
                                                    <div class="mb-2">
                                                        <label class="form-label">Địa chỉ</label>
                                                        <input type="text" value="${customer.address}" name="address" class="form-control">
                                                        <small id="addressError" class="text-danger"></small>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                    <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>

                        </div>
                    </div>
                </div>

                <!-- Sidebar -->
                <div class="col-md-4">
                    <div class="list-group account-action">

                        <!-- Thông tin cá nhân -->
                        <a href="Profile" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="fa-regular fa-user fa-lg" style="color: #0062ad;"></i>
                            <span style="color: #1c49c2;"><b>Thông tin cá nhân</b></span>
                        </a>
                        <!-- Thú cưng của tôi -->
                        <a href="PetController" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="fa-solid fa-paw fa-lg" style="color: #8C6E63;"></i>
                            <span>Thú cưng của tôi</span>
                        </a>
                        <!-- Đổi mật khẩu -->
                        <a href="ChangePassword" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="fa-solid fa-key fa-lg" style="color: #eabd1a;"></i>
                            <span>Đổi mật khẩu</span>
                        </a>
                        <!-- Đăng xuất -->
                        <a href="Logout" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="fa-solid fa-arrow-right-from-bracket fa-lg" style="color: #d01616;"></i>
                            <span>Đăng xuất</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <script>
            function validateForm() {
                let isValid = true;

                // Lấy giá trị input
                let fullName = document.getElementsByName("fullName")[0].value.trim();
                let birthDate = document.getElementsByName("birthDate")[0].value;
               
                let password = document.getElementsByName("password")[0].value;
                let phoneNumber = document.getElementsByName("phoneNumber")[0].value.trim();
                let address = document.getElementsByName("address")[0].value.trim();

                // Định dạng kiểm tra
                
                let phonePattern = /^[0-9]{9,}$/;
                let today = new Date().toISOString().split("T")[0];

                // Xóa thông báo lỗi cũ
                document.getElementById("fullNameError").innerHTML = "";
                document.getElementById("birthDateError").innerHTML = "";
               
                document.getElementById("phoneError").innerHTML = "";
                document.getElementById("addressError").innerHTML = "";

                // Kiểm tra Họ tên
                if (fullName.length < 3) {
                    document.getElementById("fullNameError").innerHTML = "Họ tên phải có ít nhất 3 ký tự!";
                    isValid = false;
                }

                // Kiểm tra Ngày sinh
                if (!birthDate) {
                    document.getElementById("birthDateError").innerHTML = "Vui lòng chọn ngày sinh!";
                    isValid = false;
                } else if (birthDate > today) {
                    document.getElementById("birthDateError").innerHTML = "Ngày sinh không thể lớn hơn ngày hiện tại!";
                    isValid = false;
                }

                // Kiểm tra Email
               

                // Kiểm tra Số điện thoại
                if (!phonePattern.test(phoneNumber)) {
                    document.getElementById("phoneError").innerHTML = "Số điện thoại phải có ít nhất 9 chữ số!";
                    isValid = false;
                }

                // Kiểm tra Địa chỉ
                if (address.length < 5) {
                    document.getElementById("addressError").innerHTML = "Địa chỉ phải có ít nhất 5 ký tự!";
                    isValid = false;
                }

                return isValid;
            }
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
    </body>
</html>
