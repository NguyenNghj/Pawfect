<%-- 
    Document   : createproduct
    Created on : Mar 1, 2025, 4:28:13 PM
    Author     : Nguyen Tri Nghi - CE180897
--%>

<%@page import="dao.CategoryDAO"%>
<%@page import="model.Category"%>
<%@page import="model.Product"%>
<%@page import="dao.ProductDAO"%>
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
        <title>Thêm sản phẩm mới</title>
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
                                <h1>Thêm sản phẩm mới</h1>
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

                    <div class="row mt-2 bg-white p-3 d-flex align-items-center justify-content-center" 
                         style="border-radius: 20px; height: 60px;">
                        <nav style="--bs-breadcrumb-divider: '>'; padding: 0 5px;" aria-label="breadcrumb">
                            <ol class="breadcrumb mb-0" style ="font-weight: bold;">
                                <li class="breadcrumb-item">Bảng điều khiển</li>
                                <li class="breadcrumb-item">Quản trị viên</li>
                                <li class="breadcrumb-item"><a href="/dashboard/admin/product">Quản lý sản phẩm</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Tạo sản phẩm</li>
                            </ol>
                        </nav>
                    </div>      
                    <div class="row" style="margin-top: 20px; margin-bottom: 50px;">
                        <form id="createProductForm" action="/dashboard/admin/createproduct" method="post" enctype="multipart/form-data">

                            <div class="mb-3">
                                <label for="createProductImage" class="form-label">Hình ảnh</label>
                                <div style="display: flex; gap: 10px;">
                                    <img id="previewImage" class="img-thumbnail" style="width: 220px; height: 220px; display: none;" src="#" alt="Ảnh sản phẩm">
                                    <input type="file" id="createProductImage" name="productImage" accept="image/*" style="display: none;" onchange="previewFile()">
                                    <div class="image-box" onclick="document.getElementById('createProductImage').click()" style="cursor: pointer; border: 1px dashed #ccc; padding: 20px; text-align: center; width: 220px; height: 220px; display: flex; align-items: center; justify-content: center;">
                                        <span id="uploadText">Thêm ảnh</span>
                                    </div>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="createProductCategory" class="form-label">Thể loại</label>
                                <select class="form-select" name="categoryId" id="categoryId" onchange="updateProductStatusOptions()">
                                    <c:forEach var="category" items="${categories}">
                                        <option value="${category.categoryId}" data-is-active="${category.active}">
                                            ${category.categoryName}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="createProductName" class="form-label">Tên sản phẩm</label>
                                <input type="text" class="form-control" name="productName" >
                            </div>

                            <div class="mb-3">
                                <label for="createProductPetType" class="form-label">Dành cho</label>
                                <select class="form-select" name="productPetType">
                                    <option value="Chó">Chó</option>
                                    <option value="Mèo">Mèo</option>
                                    <option value="Chó và Mèo">Chó và Mèo</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="createProductPrice" class="form-label">Giá</label>
                                <input type="number" class="form-control" name="productPrice" >                        
                            </div>

                            <div class="mb-3">
                                <label for="createProductStock" class="form-label">Tồn kho</label>
                                <input type="number" class="form-control" name="stock" >
                            </div>

                            <div class="mb-3">
                                <label for="createProductStatus" class="form-label">Trạng thái</label>
                                <select class="form-select" name="productActive" id="productActive">
                                    <option value="true">Đang bán</option>
                                    <option value="false">Ngừng bán</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="createProductDescription" class="form-label">Mô tả sản phẩm</label>
                                <textarea class="form-control" name="description" rows="5" ></textarea>
                            </div>

                            <button type="submit" class="btn btn-primary">Thêm sản phẩm</button>
                            <a href="<c:url value='/dashboard/admin/product'/>" class="btn btn-secondary" id="back">Trở về</a>

                        </form>

                        <script>
                            document.getElementById("createProductForm").addEventListener("submit", function (event) {
                                event.preventDefault(); // Ngăn chặn submit mặc định

                                Swal.fire({
                                    title: "Xác nhận!",
                                    text: "Bạn có chắc muốn thêm sản phẩm?",
                                    icon: "question",
                                    showCancelButton: true,
                                    confirmButtonText: "Đồng ý",
                                    cancelButtonText: "Hủy"
                                }).then((result) => {
                                    if (result.isConfirmed) {
                                        event.target.submit(); // Gửi form nếu người dùng xác nhận
                                    }
                                });
                            });
                        </script>

                        <script>
                            document.addEventListener("DOMContentLoaded", function () {
                                // Lấy thông báo thành công từ session
                                var successMessage = "<c:out value='${sessionScope.successMessage}' />";
                                if (successMessage && successMessage.trim() !== "") {
                                    Swal.fire({
                                        icon: "success",
                                        title: "Thành công!",
                                        text: successMessage,
                                        confirmButtonText: "OK"
                                    });

                                    // Xóa session sau khi hiển thị
                                    fetch('clear-session.jsp');
                                }

                                // Lấy thông báo lỗi từ session
                                var errorMessage = "<c:out value='${sessionScope.errorMessage}' />";
                                if (errorMessage && errorMessage.trim() !== "") {
                                    Swal.fire({
                                        icon: "error",
                                        title: "Lỗi!",
                                        text: errorMessage,
                                        confirmButtonText: "OK"
                                    });

                                    // Xóa session sau khi hiển thị
                                    fetch('clear-session.jsp');
                                }
                            });
                        </script>

                        <%
                            session.removeAttribute("successMessage");
                            session.removeAttribute("errorMessage");
                        %>

                        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
                        <script>
                            function previewFile() {
                                const fileInput = document.getElementById('createProductImage');
                                const previewImage = document.getElementById('previewImage');
                                const uploadText = document.getElementById('uploadText');

                                const file = fileInput.files[0];

                                if (file) {
                                    // Kiểm tra nếu file lớn hơn 5MB
                                    const maxSize = 5 * 1024 * 1024; // 5MB
                                    if (file.size > maxSize) {
                                        alert("File ảnh quá lớn! Vui lòng chọn ảnh nhỏ hơn 5MB.");
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
                                } else {
                                    previewImage.src = "#";
                                    previewImage.style.display = "none";
                                    uploadText.innerText = "Thêm ảnh";
                                }
                            }

                            // Function to update the product status options based on selected category
                            function updateProductStatusOptions() {
                                const categorySelect = document.getElementById('categoryId');
                                const selectedOption = categorySelect.options[categorySelect.selectedIndex];
                                const isActive = selectedOption.getAttribute('data-is-active') === 'true';
                                const productActiveSelect = document.getElementById('productActive');
                                const activeOption = productActiveSelect.querySelector('option[value="true"]');

                                // If the category is inactive, disable "Đang bán"
                                if (!isActive) {
                                    activeOption.disabled = true;
                                    if (activeOption.selected) {
                                        // If "Đang bán" is selected, select "Ngừng bán" instead
                                        productActiveSelect.value = 'false';
                                    }
                                } else {
                                    activeOption.disabled = false;
                                }
                            }

                            // Call the function on page load to set the correct state based on the initial category
                            window.onload = function () {
                                updateProductStatusOptions();
                            };
                        </script>
                    </div>

                </div>
            </div>
        </div>


        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>

    </body>
</html>

