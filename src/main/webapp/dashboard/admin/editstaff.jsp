<%@page import="model.Staff"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="../../css/dashboard.css">
        <title>Cập Nhật Nhân Viên</title>
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

                            if (!staffRole.isEmpty() && !staffName.isEmpty()) {
                                break;
                            }
                        }
                    }
                %>

                <!-- MAIN CONTENT -->
                <div class="col" id="main" style="padding: 0 40px;">
                    <div class="row pt-4">
                        <div class="d-flex align-items-center justify-content-between">
                            <h1>Cập Nhật Nhân Viên</h1>
                            <div class="dropdown d-flex align-items-center gap-2">
                                <span><%= staffName%></span>
                                <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                    <img class="profile-img" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTf74k9hxcTCkLN2gyhCr9lzuzZax5iy0uDOA&s" alt="">
                                </button>
                                <ul class="dropdown-menu ps-2 pe-2 pt-2 pb-2">
                                    <div class="d-grid gap-2">
                                        <li class="profile-img-info1 d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-user-pen"></i>
                                            <a class="dropdown-item" href="adminprofile">Profile</a>
                                        </li>
                                        <li class="profile-img-info2 d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-right-from-bracket"></i>
                                            <a class="dropdown-item" href="logoutadmin">Logout</a>
                                        </li>
                                    </div>
                                </ul>
                            </div>                                                             
                        </div>
                    </div>

                    <!-- Breadcrumb -->
                    <div class="row mt-2">
                        <nav style="--bs-breadcrumb-divider: '>';">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item">Dashboard</li>
                                <li class="breadcrumb-item"><a href="staff">Quản lý Nhân Viên</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Cập Nhật Nhân Viên</li>
                            </ol>
                        </nav>
                    </div>

                    <div class="row" style="margin-top: 20px; margin-bottom: 50px;">
                        <c:if test="${not empty param.error}">
                            <div class="alert alert-danger">${param.error}</div>
                        </c:if>
                        <c:if test="${not empty param.success}">
                            <div class="alert alert-success">Cập nhật thành công!</div>
                        </c:if>

                        <c:if test="${not empty staff}">
                            <form id="editStaffForm" action="editstaff" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="staffId" value="${staff.staffId}">
                                <input type="hidden" name="existingImage" value="${staff.image}">

                                <!-- Ảnh nhân viên -->
                                <div class="mb-3">
                                    <label for="editStaffImage" class="form-label">Ảnh</label>
                                    <div style="display: flex; gap: 10px;">
                                        <img id="previewImage" class="img-thumbnail"
                                             style="width: 220px; height: 220px; display: ${not empty staff.image ? 'block' : 'none'};"
                                             src="<%= request.getContextPath()%>/img/staff/${staff.image}" alt="Ảnh nhân viên">
                                        <input type="file" id="editStaffImage" name="staffImage" accept="image/*" style="display: none;" onchange="previewFile()">
                                        <div class="image-box" onclick="document.getElementById('editStaffImage').click()" 
                                             style="cursor: pointer; border: 1px dashed #ccc; padding: 20px; text-align: center; width: 220px; height: 220px; display: flex; align-items: center; justify-content: center;">
                                            <span id="uploadText">Đổi ảnh</span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Họ và tên -->
                                <div class="mb-3">
                                    <label class="form-label">Họ và Tên</label>
                                    <input type="text" class="form-control" name="fullName" value="${staff.fullName}" required>
                                </div>

                                <!-- Email -->
                                <div class="mb-3">
                                    <label class="form-label">Email</label>
                                    <input type="email" class="form-control" name="email" value="${staff.email}" required>
                                </div>

                                <!-- Số điện thoại -->
                                <div class="mb-3">
                                    <label class="form-label">Số Điện Thoại</label>
                                    <input type="text" class="form-control" name="phone" value="${staff.phone}" required>
                                </div>

                                <!-- Vai trò -->
                                <div class="mb-3">
                                    <label class="form-label">Vai Trò</label>
                                    <select class="form-control" name="roleName" required>
                                        <option value="Admin" ${staff.roleName eq 'Admin' ? 'selected' : ''}>Admin</option>
                                        <option value="Staff" ${staff.roleName eq 'Staff' ? 'selected' : ''}>Staff</option>
                                    </select>
                                </div>

                                <!-- Mật khẩu -->
                                <div class="mb-3">
                                    <label class="form-label">Mật Khẩu</label>
                                    <input type="password" class="form-control" name="password" value="${staff.password}" required>
                                </div>

                                <!-- Ngày sinh -->
                                <div class="mb-3">
                                    <label class="form-label">Ngày sinh</label>
                                    <input type="date" class="form-control" name="birthDate" value="${staff.birthDate}">
                                </div>

                                <!-- Địa chỉ -->
                                <div class="mb-3">
                                    <label class="form-label">Địa chỉ</label>
                                    <input type="text" class="form-control" name="address" value="${staff.address}">
                                </div>

                                <!-- Giới tính -->
                                <div class="mb-3">
                                    <label class="form-label">Giới Tính</label>
                                    <select class="form-select" name="gender">
                                        <option value="Nam" ${staff.gender == 'Nam' ? 'selected' : ''}>Nam</option>
                                        <option value="Nữ" ${staff.gender == 'Nữ' ? 'selected' : ''}>Nữ</option>
                                        <option value="Khác" ${staff.gender == 'Khác' ? 'selected' : ''}>Khác</option>
                                    </select>
                                </div>

                                <!-- Trạng thái -->
                                <div class="mb-3">
                                    <label class="form-label">Trạng Thái</label>
                                    <select class="form-select" name="isActive">
                                        <option value="true" ${staff.active ? 'selected' : ''}>Hoạt động</option>
                                        <option value="false" ${!staff.active ? 'selected' : ''}>Không hoạt động</option>
                                    </select>
                                </div>

                                <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                <a href="staff" class="btn btn-secondary">Trở về</a>
                            </form>

                        </c:if>
                    </div>
                </div>
            </div>
        </div>
        <script>
            function previewFile() {
                const fileInput = document.getElementById('editStaffImage');
                const previewImage = document.getElementById('previewImage');
                const uploadText = document.getElementById('uploadText');

                const file = fileInput.files[0];

                if (file) {
                    // Kiểm tra nếu file lớn hơn 10MB
                    const maxSize = 10 * 1024 * 1024; // 10MB
                    if (file.size > maxSize) {
                        alert("File ảnh quá lớn! Vui lòng chọn ảnh nhỏ hơn 10MB.");
                        fileInput.value = ""; // Xóa file đã chọn
                        return;
                    }

                    const reader = new FileReader();
                    reader.onload = function (e) {
                        previewImage.src = e.target.result;
                        previewImage.style.display = "block";
                        uploadText.innerText = "Đổi ảnh";
                    };
                    reader.readAsDataURL(file);
                }
            }
        </script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                var errorMessage = "<c:out value='${errorMessage}' />";
                if (errorMessage && errorMessage.trim() !== "") {
                    Swal.fire({
                        icon: "error",
                        title: "Lỗi!",
                        text: errorMessage,
                        confirmButtonText: "OK"
                    });
                }
            });
        </script>
        <script src="https://kit.fontawesome.com/b3e08bd329.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
