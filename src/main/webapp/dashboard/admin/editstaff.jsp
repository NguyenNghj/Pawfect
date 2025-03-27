<%@page import="model.Staff"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;600;800&display=swap" rel="stylesheet">
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
                        <div class="d-flex align-items-center justify-content-between" style="padding: 0;">
                            <div>
                                <h1>Chỉnh sửa thông tin nhân viên</h1>
                            </div>
                            <div class="dropdown d-flex align-items-center gap-2">
                                <span style = "color: #D3A376; font-weight: bold;"><%= staffName%></span>
                                <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <img class="profile-img" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTf74k9hxcTCkLN2gyhCr9lzuzZax5iy0uDOA&s" alt="">
                                </button>
                                <ul class="dropdown-menu ps-2 pe-2 pt-2 pb-2">
                                    <div class="d-grid gap-2">
                                        <li class="profile-img-switch-employee d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-repeat"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="/dashboard/staff/viewcustomersforStaff">Chuyển qua giao diện nhân viên</a>
                                        </li>
                                    </div>
                                </ul>
                            </div>                                                              
                        </div>
                    </div>

                    <!-- Breadcrumb -->
                    <div class="row mt-2 bg-white p-3 d-flex align-items-center justify-content-center" 
                         style="border-radius: 20px; height: 60px;">
                        <nav style="--bs-breadcrumb-divider: '>'; padding: 0 5px;" aria-label="breadcrumb">
                            <ol class="breadcrumb mb-0" style ="font-weight: bold;">
                                <li class="breadcrumb-item">Bảng điều khiển</li>
                                <li class="breadcrumb-item">Quản trị viên</li>
                                <li class="breadcrumb-item"><a href="/dashboard/admin/staff">Quản trị nhân viên</a></li>
                                <li class="breadcrumb-item active" aria-current="page">${staff.fullName}</li>
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
                                    <label for="editStaffImage" class="form-label">Ảnh nhân viên</label>
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
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
                                            document.getElementById("editStaffForm").addEventListener("submit", function (event) {
                                                event.preventDefault(); // Ngăn form submit ngay lập tức

                                                // Lấy dữ liệu từ form
                                                const fullName = document.getElementsByName("fullName")[0].value.trim();
                                                const email = document.getElementsByName("email")[0].value.trim();
                                                const password = document.getElementsByName("password")[0].value;
                                                const phone = document.getElementsByName("phone")[0].value.trim();
                                                const address = document.getElementsByName("address")[0].value.trim();
                                                const birthDate = document.getElementsByName("birthDate")[0].value;

                                                // Biểu thức regex
                                                const nameRegex = /^[\p{L} ]+$/u; // Chỉ chứa chữ cái và dấu cách
                                                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                                                const phoneRegex = /^[0-9]{10}$/;
                                                const addressRegex = /^[\p{L}0-9 ,.-]+$/u; // Chữ, số, dấu phẩy, dấu chấm, gạch ngang

                                                // Kiểm tra Họ và Tên
                                                if (fullName === "" || !nameRegex.test(fullName)) {
                                                    Swal.fire("Lỗi!", "Họ và Tên không hợp lệ! Chỉ chứa chữ cái và dấu cách.", "error");
                                                    return;
                                                }

                                                // Kiểm tra địa chỉ
                                                if (address === "" || !addressRegex.test(address)) {
                                                    Swal.fire("Lỗi!", "Địa chỉ không hợp lệ! Không chứa ký tự đặc biệt.", "error");
                                                    return;
                                                }

                                                // Kiểm tra email hợp lệ
                                                if (!emailRegex.test(email)) {
                                                    Swal.fire("Lỗi!", "Email không hợp lệ!", "error");
                                                    return;
                                                }

                                                // Kiểm tra mật khẩu có ít nhất 6 ký tự
                                                if (password.length < 6) {
                                                    Swal.fire("Lỗi!", "Mật khẩu phải có ít nhất 6 ký tự!", "error");
                                                    return;
                                                }

                                                // Kiểm tra số điện thoại (phải có 10 chữ số)
                                                if (!phoneRegex.test(phone)) {
                                                    Swal.fire("Lỗi!", "Số điện thoại phải gồm 10 chữ số và không có ký tự khác!", "error");
                                                    return;
                                                }

                                                // Kiểm tra tuổi (18 - 65)
                                                if (birthDate) {
                                                    let birthYear = new Date(birthDate).getFullYear();
                                                    let currentYear = new Date().getFullYear();
                                                    let age = currentYear - birthYear;
                                                    if (age < 18 || age > 65) {
                                                        Swal.fire("Lỗi!", "Nhân viên phải từ 18 đến 65 tuổi!", "error");
                                                        return;
                                                    }
                                                } else {
                                                    Swal.fire("Lỗi!", "Vui lòng chọn ngày sinh!", "error");
                                                    return;
                                                }

                                                // Nếu tất cả hợp lệ, xác nhận trước khi submit
                                                Swal.fire({
                                                    title: "Xác nhận!",
                                                    text: "Bạn có chắc muốn cập nhật thông tin nhân viên?",
                                                    icon: "question",
                                                    showCancelButton: true,
                                                    confirmButtonText: "Đồng ý",
                                                    cancelButtonText: "Hủy"
                                                }).then((result) => {
                                                    if (result.isConfirmed) {
                                                        event.target.submit(); // Submit form nếu người dùng xác nhận
                                                    }
                                                });
                                            });
        </script>

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
