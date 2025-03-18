<%-- 
    Document   : petRoom
    Created on : Feb 11, 2025, 3:54:33 PM
    Author     : Nguyen Tien Thanh - CE181342
--%>

<%@page import="dao.PetHotelDAO"%>
<%@page import="model.PetHotel"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;600;800&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="../../css/dashboard.css">
        <title>Chỉnh sửa Pet Hotel</title>
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
                                <h1>Chỉnh sửa khách sạn thú cưng</h1>
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
                                <li class="breadcrumb-item"><a href="/dashboard/admin/pethotel">Quản lý khách sạn thú cưng</a></li>
                                <li class="breadcrumb-item active" aria-current="page">${room.roomName} dành cho ${room.roomType}</li>
                            </ol>
                        </nav>
                    </div>

                    <div class="row" style="margin-top: 20px; margin-bottom: 50px;">
                        <form id="editRoomForm" action="/dashboard/admin/editpethotel" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="roomId" value="${room.roomId}">
                            <input type="hidden" name="existingImage" value="${room.roomImage}">
                            <input type="hidden" name="page" id="currentPageInput">

                            <!-- Hình ảnh -->
                            <div class="mb-3">
                                <label for="editRoomImage" class="form-label">Hình ảnh</label>
                                <div style="display: flex; gap: 10px;">
                                    <img id="previewImage" class="img-thumbnail"
                                         style="width: 220px; height: 220px; display: ${not empty room.roomImage ? 'block' : 'none'};"
                                         src="<%= request.getContextPath()%>/img/pethotel/${room.roomImage}" alt="Ảnh phòng">
                                    <input type="file" id="editRoomImage" name="petHotelImage" accept="image/*" style="display: none;" onchange="previewFile()">
                                    <div class="image-box" onclick="document.getElementById('editRoomImage').click()" 
                                         style="cursor: pointer; border: 1px dashed #ccc; padding: 20px; text-align: center; width: 220px; height: 220px; display: flex; align-items: center; justify-content: center;">
                                        <span id="uploadText">Đổi ảnh</span>
                                    </div>
                                </div>
                            </div>

                            <!-- Tên phòng -->
                            <div class="mb-3">
                                <label for="editRoomName" class="form-label">Tên phòng</label>
                                <input type="text" class="form-control" name="roomName" value="${room.roomName}" required>
                            </div>

                            <!-- Loại phòng -->
                            <div class="mb-3">
                                <label for="editRoomType">Loại phòng</label>
                                <select class="form-select" name="roomType">
                                    <option value="Chó" ${room.roomType == 'Chó' ? 'selected' : ''}>Chó</option>
                                    <option value="Mèo" ${room.roomType == 'Mèo' ? 'selected' : ''}>Mèo</option>
                                </select>
                            </div>

                            <!-- Cân nặng tối thiểu -->
                            <div class="mb-3">
                                <label for="editMinWeight" class="form-label">Cân nặng tối thiểu (kg)</label>
                                <input type="number" class="form-control" name="minWeight" step="0.1" value="${room.minWeight}" required min="0.1">
                            </div>

                            <!-- Cân nặng tối đa -->
                            <div class="mb-3">
                                <label for="editMaxWeight" class="form-label">Cân nặng tối đa (kg)</label>
                                <input type="number" class="form-control" name="maxWeight" step="0.1" value="${room.maxWeight}" required min="0.1">
                            </div>

                            <!-- Số lượng phòng -->
                            <div class="mb-3">
                                <label for="editRoomQuantity" class="form-label">Số lượng</label>
                                <input type="number" class="form-control" name="quantity" value="${room.quantity}" required min="1">
                            </div>

                            <!-- Giá mỗi đêm -->
                            <div class="mb-3">
                                <label for="editPricePerNight" class="form-label">Giá mỗi đêm (VNĐ)</label>
                                <input type="number" class="form-control" name="pricePerNight" step="0.01" value="${room.pricePerNight}" required min="1">
                            </div>

                            <!-- Mô tả -->
                            <div class="mb-3">
                                <label for="editRoomDescription" class="form-label">Mô tả</label>
                                <textarea class="form-control" name="description" rows="5" required>${room.description}</textarea>
                            </div>

                            <!-- Trạng thái phòng -->
                            <div class="mb-3">
                                <label for="editRoomStatus">Trạng thái</label>
                                <select class="form-select" name="status">
                                    <option value="Còn phòng" ${room.status == 'Còn phòng' ? 'selected' : ''}>Còn phòng</option>
                                    <option value="Hết phòng" ${room.status == 'Hết phòng' ? 'selected' : ''}>Hết phòng</option>
                                </select>
                            </div>

                            <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                            <a href="<c:url value='/dashboard/admin/pethotel'/>" class="btn btn-secondary">Trở về</a>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function previewFile() {
                const fileInput = document.getElementById('editRoomImage');
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
        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    </body>
</html>
