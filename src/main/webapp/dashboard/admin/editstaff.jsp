<%@page import="model.Staff"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Cập Nhật Nhân Viên</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="../../css/dashboard.css">
        <style>
            .container {
                width: 70%;
                margin: 0 auto;
            }
            form {
                background: #f8f9fa;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            }
        </style>
    </head>
    <body>
        <div class="container mt-5">
            <h2 class="text-center">Cập Nhật Nhân Viên</h2>

            <c:if test="${not empty param.error}">
                <div class="alert alert-danger">${param.error}</div>
            </c:if>
            <c:if test="${not empty param.success}">
                <div class="alert alert-success">Cập nhật thành công!</div>
            </c:if>

            <div class="card">
                <div class="card-body">
                    <c:if test="${not empty staff}">
                        <form action="editstaff" method="post">
                            <!-- ID Nhân Viên (ẩn) -->
                            <input type="hidden" name="staffId" value="${staff.staffId}">

                            <div class="mb-3">
                                <label class="form-label">Vai Trò</label>
                                <select class="form-control" name="roleName" required>
                                    <option value="Admin" ${staff.roleName eq 'Admin' ? 'selected' : ''}>Admin</option>
                                    <option value="Staff" ${staff.roleName eq 'Staff' ? 'selected' : ''}>Staff</option>
                                </select>
                            </div>


                            <div class="mb-3">
                                <label class="form-label">Mật Khẩu</label>
                                <input type="password" class="form-control" name="password" placeholder="Enter password" >
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Họ và Tên</label>
                                <input type="text" class="form-control" name="fullName" value="${staff.fullName}" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control" name="email" value="${staff.email}" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Số Điện Thoại</label>
                                <input type="text" class="form-control" name="phone" value="${staff.phone}" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Địa Chỉ</label>
                                <input type="text" class="form-control" name="address" value="${staff.address}">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Giới Tính</label>
                                <select class="form-select" name="gender">
                                    <option value="Male" ${staff.gender == 'Male' ? 'selected' : ''}>Nam</option>
                                    <option value="Female" ${staff.gender == 'Female' ? 'selected' : ''}>Nữ</option>
                                    <option value="Others" ${staff.gender == 'Others' ? 'selected' : ''}>Khác</option>
                                </select>
                            </div>
<div class="mb-3">
    <label class="form-label">Ngày Sinh</label>
    <input type="date" class="form-control" name="birthDate" 
           value="${staff.birthDate}" id="birthDate" required>
    <small id="ageError" style="color: red; display: none;">Nhân viên phải đủ 16 tuổi trở lên.</small>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        let birthDateInput = document.getElementById("birthDate");
        let ageError = document.getElementById("ageError");

        // Tính toán ngày tối đa để đảm bảo tuổi ≥ 16
        let today = new Date();
        let minAgeDate = new Date();
        minAgeDate.setFullYear(today.getFullYear() - 16); // Lùi 16 năm

        // Chặn người dùng chọn ngày sinh nhỏ hơn 16 năm trước
        birthDateInput.setAttribute("max", minAgeDate.toISOString().split("T")[0]);

        birthDateInput.addEventListener("change", function () {
            let selectedDate = new Date(birthDateInput.value);
            if (selectedDate > minAgeDate) {
                ageError.style.display = "block"; // Hiển thị thông báo lỗi
                birthDateInput.value = ""; // Xóa giá trị nhập sai
            } else {
                ageError.style.display = "none"; // Ẩn thông báo lỗi
            }
        });
    });
</script>

                            <c:if test="${param.error eq 'underage'}">
                                <div class="alert alert-danger">Nhân viên phải trên 16 tuổi!</div>
                            </c:if>
                            <div class="mb-3">
                                <label class="form-label">Ảnh (URL)</label>
                                <input type="text" class="form-control" name="image" value="${staff.image}">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Trạng Thái</label>
                                <select class="form-select" name="isActive">
                                    <option value="true" ${staff.active ? 'selected' : ''}>Hoạt động</option>
                                    <option value="false" ${!staff.active ? 'selected' : ''}>Không hoạt động</option>
                                </select>
                            </div>

                            <button type="submit" class="btn btn-success w-100">Cập Nhật</button>
                        </form>
                    </c:if>

                    <c:if test="${empty staff}">
                        <div class="alert alert-danger text-center">Không tìm thấy nhân viên!</div>
                    </c:if>
                </div>
            </div>

            <a href="staff" class="btn btn-secondary mt-3">Quay lại danh sách nhân viên</a>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
