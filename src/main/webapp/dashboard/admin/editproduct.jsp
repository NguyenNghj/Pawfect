<%-- 
    Document   : product
    Created on : Feb 11, 2025, 3:54:05 PM
    Author     : Vu Quang Duc - CE181221
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
                                <h1>Chỉnh sửa thông tin sản phẩm</h1>
                            </div>
                            <div class="dropdown d-flex align-items-center gap-2">
                                <span>Username2025 (Admin)</span>
                                <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <img class="profile-img" src="https://img.freepik.com/foto-gratis/hombre-tiro-medio-peinado-afro_23-2150677136.jpg" alt="">
                                </button>
                                <ul class="dropdown-menu ps-2 pe-2 pt-2 pb-2">
                                    <div class="d-grid gap-2">
                                        <li class="profile-img-switch-employee d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-repeat"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="#">Switch to employee</a>
                                        </li>
                                        <li class="profile-img-switch-store d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-store"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="#">Go to store</a>
                                        </li>
                                        <hr style="margin: 0;">
                                        <li class="profile-img-info1 d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-user-pen"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="profile.jsp">Profile</a>
                                        </li>
                                        <li class="profile-img-info2 d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-right-from-bracket" style="font-size: 20px;"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="#">Logout</a>
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
                                <li class="breadcrumb-item"><a href="#">Home</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Product</li>
                            </ol>
                        </nav>
                    </div>   

                    <!--                    <div class="row">
                                            <div class="col-3 p-0" style="margin-top: 60px;">
                                                <button type="button" class="btn btn-primary">
                                                    <i class="fa-solid fa-plus"></i>
                                                    New Product
                                                </button>
                                            </div>        
                                        </div>-->


                    <div class="row" style="margin-top: 20px; margin-bottom: 50px;">
                        <form id="editProductForm" action = "/dashboard/admin/editproduct" method="post" enctype ="multipart/form-data">

                            <input type="hidden" name="productId" value="${product.productId}">
                            <input type="hidden" name="existingImage" value="${product.productImage}">

                            <div class="mb-3">
                                <label for="editProductImage" class="form-label">Hình ảnh</label>
                                <div style="display: flex; gap: 10px;">
                                    <img id="previewImage" class="img-thumbnail" style="width: 220px; height: 220px; display: ${not empty product.productImage ? 'block' : 'none'};" src="/img/products/${product.productImage}" alt="Ảnh sản phẩm">
                                    <input type="file" id="editProductImage" name="productImage" accept="image/*" style="display: none;" onchange="previewFile()">
                                    <div class="image-box" onclick="document.getElementById('editProductImage').click()" style="cursor: pointer; border: 1px dashed #ccc; padding: 20px; text-align: center; width: 220px; height: 220px; display: flex; align-items: center; justify-content: center;">
                                        <span id="uploadText">Thêm ảnh</span>
                                    </div>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="editProductCategory">Thể loại</label>
                                <select class="form-select" name="categoryId">
                                    <c:forEach var="category" items="${categories}">
                                        <option value="${category.categoryId}" 
                                                <c:if test="${category.categoryId == product.categoryId}">selected="selected"</c:if>>
                                            ${category.categoryName}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="editProductName" class="form-label">Tên sản phẩm</label>
                                <input type="text" class="form-control" name="productName" value="${product.productName}" required>
                            </div>

                            <div class="mb-3">
                                <label for="editProductPetType">Dành cho</label>
                                <select class="form-select" name="productPetType">
                                    <option value="Chó" ${product.productPetType == 'Chó' ? 'selected' : ''}>Chó</option>
                                    <option value="Mèo" ${product.productPetType == 'Mèo' ? 'selected' : ''}>Mèo</option>
                                    <option value="Chó và Mèo" ${product.productPetType == 'Chó và Mèo' ? 'selected' : ''}>Chó và Mèo</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="editProductPrice" class="form-label">Giá</label>
                                <input type="number" class="form-control" name="productPrice" value="${product.productPrice}" required>
                            </div>

                            <div class="mb-3">
                                <label for="editProductStock" class="form-label">Tồn kho</label>
                                <input type="number" class="form-control" name="stock" value="${product.stock}" required>
                            </div>

                            <div class="mb-3">
                                <label for="editProductStatus">Trạng thái</label>
                                <select class="form-select" name="productActive">
                                    <option value="true" ${product.active ? 'selected' : ''}>Đang bán</option>
                                    <option value="false" ${!product.active ? 'selected' : ''}>Ngừng bán</option>
                                </select>
                            </div>


                            <div class="mb-3">
                                <label for="editProductDescription" class="form-label">Mô tả sản phẩm</label>
                                <textarea class="form-control" name="description" rows="5" required>${product.description}</textarea>
                            </div>
                            <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                            <a href="<c:url value='/dashboard/admin/product'/>" class="btn btn-secondary" id="back">Trở về</a>
                        </form>

                        <script>
                            function previewFile() {
                                const fileInput = document.getElementById('editProductImage');
                                const previewImage = document.getElementById('previewImage');
                                const uploadText = document.getElementById('uploadText');

                                const file = fileInput.files[0];

                                if (file) {
                                    // Kiểm tra nếu file lớn hơn 10MB
                                    const maxSize = 5 * 1024 * 1024; // 10MB
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

                    </div>
                </div>
            </div>
        </div>


        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>

    </body>
</html>

