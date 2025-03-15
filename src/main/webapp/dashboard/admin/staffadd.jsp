<%-- 
    Document   : createcategory
    Created on : Mar 1, 2025, 6:00:11 PM
    Author     : Nguyen Tri Nghi - CE180897
--%>

<%@page import="model.Staff"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;600;800&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="../../css/dashboard.css">

        <meta charset="UTF-8">
        <title>Thêm Nhân Viên Mới</title>
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
                                <h1>Thêm nhân viên mới</h1>
                            </div>
                            <div class="dropdown d-flex align-items-center gap-2">
                                <span style="color: #D3A376; font-weight: bold;"><%= staffName%></span>
                                <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <img class="profile-img" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTf74k9hxcTCkLN2gyhCr9lzuzZax5iy0uDOA&s" alt="">
                                </button>
                                <ul class="dropdown-menu ps-2 pe-2 pt-2 pb-2">
                                    <div class="d-grid gap-2">
                                        <li class="profile-img-switch-employee d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-repeat"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="/dashboard/staff/statistics">Chuyển qua giao diện nhân viên</a>
                                        </li>
                                    </div>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="row mt-2">
                        <nav style="--bs-breadcrumb-divider: '>'; padding: 0 5px;" aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item">Dashboard</li>
                                <li class="breadcrumb-item"><a href="/dashboard/admin/staff">Quản lý nhân viên</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Thêm nhân viên mới</li>
                            </ol>
                        </nav>
                    </div>

                    <div class="row" style="margin-top: 20px; margin-bottom: 50px;">
                        <form id="createStaffForm" action="staffadd" method="post" enctype="multipart/form-data">
                            <div class="mb-3">
                                <label for="staffImage" class="form-label">Hình ảnh</label>
                                <div style="display: flex; gap: 10px;">
                                    <img id="previewImage" class="img-thumbnail" style="width: 220px; height: 220px; display: none;" src="#" alt="Ảnh nhân viên">
                                    <input type="file" id="staffImage" name="staffImage" accept="image/*" style="display: none;" onchange="previewFile()">
                                    <div class="image-box" onclick="document.getElementById('staffImage').click()" style="cursor: pointer; border: 1px dashed #ccc; padding: 20px; text-align: center; width: 220px; height: 220px; display: flex; align-items: center; justify-content: center;">
                                        <span id="uploadText">Thêm ảnh</span>
                                    </div>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Vai Trò</label>
                                <select class="form-select" name="roleName">
                                    <option value="Admin">Admin</option>
                                    <option value="Staff">Nhân viên</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Họ và Tên</label>
                                <input type="text" class="form-control" name="fullName" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Mật Khẩu</label>
                                <input type="password" class="form-control" name="password" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control" name="email" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Số Điện Thoại</label>
                                <input type="text" class="form-control" name="phone" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Địa Chỉ</label>
                                <input type="text" class="form-control" name="address">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Giới Tính</label>
                                <select class="form-select" name="gender">
                                    <option value="Male">Nam</option>
                                    <option value="Female">Nữ</option>
                                    <option value="Others">Khác</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Ngày Sinh</label>
                                <input type="date" class="form-control" name="birthDate">
                            </div>

                            <button type="submit" class="btn btn-primary">Thêm nhân viên</button>
                            <a href="/dashboard/admin/staff" class="btn btn-secondary">Trở về</a>
                        </form>

                        <script>
                            function previewFile() {
                                const fileInput = document.getElementById('staffImage');
                                const previewImage = document.getElementById('previewImage');
                                const uploadText = document.getElementById('uploadText');
                                const file = fileInput.files[0];

                                if (file) {
                                    const maxSize = 5 * 1024 * 1024;
                                    if (file.size > maxSize) {
                                        alert("File ảnh quá lớn! Vui lòng chọn ảnh nhỏ hơn 5MB.");
                                        fileInput.value = "";
                                        return;
                                    }
                                    const reader = new FileReader();
                                    reader.onload = function (e) {
                                        previewImage.src = e.target.result;
                                        previewImage.style.display = "block";
                                        uploadText.innerText = "Đổi ảnh";
                                    };
                                    reader.readAsDataURL(file);
                                } else {
                                    previewImage.src = "#";
                                    previewImage.style.display = "none";
                                    uploadText.innerText = "Thêm ảnh";
                                }
                            }
                        </script>

                        <c:if test="${not empty param.success}">
                            <div class="alert alert-success mt-3">Thêm nhân viên thành công!</div>
                        </c:if>

                        <c:if test="${not empty param.error}">
                            <div class="alert alert-danger mt-3">Thêm nhân viên thất bại. Vui lòng thử lại!</div>
                        </c:if>
                    </div>
                </div>
                <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
                <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>

                </body>
                </html>

