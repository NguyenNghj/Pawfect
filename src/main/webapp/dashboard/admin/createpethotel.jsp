<%-- 
    Document   : petRoom
    Created on : Feb 11, 2025, 3:54:33 PM
    Author     : Nguyen Tien Thanh - CE181342
--%>

<%@page import="model.PetHotel"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;600;800&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="../../css/dashboard.css">
        <title>Thêm mới Pet Hotel</title>
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
                                <h1>Thêm khách sạn thú cưng</h1>
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
                                <li class="breadcrumb-item active" aria-current="page">Tạo phòng mới</li>
                            </ol>
                        </nav>
                    </div> 

                    <div class="mt-4 d-flex justify-content-center align-items-center gap-3 main-dashboard-table-header"
                         style="background-color: #8C6E63; color: white; border-top-left-radius: 6px; border-top-right-radius: 6px;">                                                 
                        <i class="fa-solid fa-hotel fa-lg"></i>
                        <h4 class="mb-0">Thêm phòng mới</h4>
                    </div>

                    <div class="row pb-4" style="margin-top: 20px; margin-bottom: 50px;">
                        <form id="createpethotel" action="createpethotel" method="post" enctype="multipart/form-data">
                            <!-- Hình ảnh -->
                            <div class="mb-3">
                                <label for="petHotelImage" class="form-label">Hình ảnh</label>
                                <div style="display: flex; gap: 10px;">
                                    <img id="previewImage" class="img-thumbnail" style="width: 220px; height: 220px; display: none;" src="#" alt="Ảnh phòng">
                                    <input type="file" id="petHotelImage" name="petHotelImage" accept="image/*" style="display: none;" onchange="previewFile()">
                                    <div class="image-box" onclick="document.getElementById('petHotelImage').click()" style="cursor: pointer; border: 1px dashed #ccc; padding: 20px; text-align: center; width: 220px; height: 220px; display: flex; align-items: center; justify-content: center;">
                                        <span id="uploadText">Thêm ảnh</span>
                                    </div>
                                </div>
                            </div>

                            <!-- Tên phòng -->
                            <div class="mb-3">
                                <label for="roomName" class="form-label">Tên phòng</label>
                                <input type="text" id="roomName" name="roomName" class="form-control" >
                            </div>

                            <!-- Loại phòng -->
                            <div class="mb-3">
                                <label class="form-label">Loại phòng</label>
                                <select class="form-select" name="roomType" >
                                    <option value="Chó">Chó</option>
                                    <option value="Mèo">Mèo</option>
                                </select>
                            </div>

                            <!-- Cân nặng tối thiểu -->
                            <div class="mb-3">
                                <label for="minWeight" class="form-label">Cân nặng tối thiểu (kg)</label>
                                <input type="number" id="minWeight" name="minWeight" step="0.1" class="form-control"  >
                            </div>

                            <!-- Cân nặng tối đa -->
                            <div class="mb-3">
                                <label for="maxWeight" class="form-label">Cân nặng tối đa (kg)</label>
                                <input type="number" id="maxWeight" name="maxWeight" step="0.1" class="form-control" >
                            </div>

                            <!-- Số lượng -->
                            <div class="mb-3">
                                <label for="quantity" class="form-label">Số lượng</label>
                                <input type="number" id="quantity" name="quantity" class="form-control" >
                            </div>

                            <!-- Giá mỗi đêm -->
                            <div class="mb-3">
                                <label for="pricePerNight" class="form-label">Giá mỗi đêm (VNĐ)</label>
                                <input type="number" id="pricePerNight" name="pricePerNight" step="0.01" class="form-control" >
                            </div>

                            <!-- Mô tả -->
                            <div class="mb-3">
                                <label for="description" class="form-label">Mô tả</label>
                                <textarea class="form-control" id="description" name="description" rows="4" ></textarea>
                            </div>

                            <!-- Nút hành động -->
                            <button type="submit" class="btn btn-primary">Thêm phòng</button>
                            <a href="pethotel" class="btn btn-secondary">Quay lại</a>

                        </form>                       
                    </div>

                </div>
            </div>
        </div>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                var errorMessage = "${errorMessage}";
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
        <script>
            function previewFile() {
                const fileInput = document.getElementById('petHotelImage');
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
        </script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            document.getElementById("createpethotel").addEventListener("submit", function (event) {
                event.preventDefault(); // Ngăn form submit ngay lập tức

                let roomName = document.getElementById("roomName").value.trim();
                let minWeight = parseFloat(document.getElementById("minWeight").value);
                let maxWeight = parseFloat(document.getElementById("maxWeight").value);
                let quantity = parseInt(document.getElementById("quantity").value);
                let pricePerNight = parseFloat(document.getElementById("pricePerNight").value);
                let description = document.getElementById("description").value.trim();
                let petHotelImage = document.getElementById("petHotelImage").files.length;

                // Kiểm tra ảnh
                if (petHotelImage === 0) {
                    Swal.fire("Lỗi!", "Vui lòng chọn một hình ảnh!", "error");
                    return;
                }

                // Biểu thức kiểm tra ký tự đặc biệt (không cho phép ký tự đặc biệt ngoại trừ khoảng trắng)
                let specialCharPattern = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?`~]/;

                // Kiểm tra tên phòng (không chứa ký tự đặc biệt)
                if (roomName === "") {
                    Swal.fire("Lỗi!", "Tên phòng không được để trống!", "error");
                    return;
                }
                if (specialCharPattern.test(roomName)) {
                    Swal.fire("Lỗi!", "Tên phòng không được chứa ký tự đặc biệt!", "error");
                    return;
                }

                // Kiểm tra cân nặng
                if (isNaN(minWeight) || minWeight <= 0.9) {
                    Swal.fire("Lỗi!", "Cân nặng tối thiểu phải lớn hơn 1!", "error");
                    return;
                }

                if (isNaN(maxWeight) || maxWeight <= 0.9) {
                    Swal.fire("Lỗi!", "Cân nặng tối đa phải lớn hơn 1!", "error");
                    return;
                }

                if (minWeight > maxWeight) {
                    Swal.fire("Lỗi!", "Cân nặng tối thiểu phải nhỏ hơn hoặc bằng cân nặng tối đa!", "error");
                    return;
                }


                // Kiểm tra số lượng
                if (isNaN(quantity) || quantity < 1) {
                    Swal.fire("Lỗi!", "Số lượng phải lớn hơn 0!", "error");
                    return;
                }

                // Kiểm tra giá
                if (isNaN(pricePerNight) || pricePerNight < 50000) {
                    Swal.fire("Lỗi!", "Giá mỗi đêm phải lớn hơn 50.000 VNĐ!", "error");
                    return;
                }
                
                // Kiểm tra giá mỗi đêm
                if (pricePerNight > 50000000) {
                    Swal.fire("Lỗi!", "Giá mỗi đêm phải nhỏ hơn 50.000.000 VNĐ!", "error");
                    return;
                }
                
                // Kiểm tra mô tả
                if (description === "") {
                    Swal.fire("Lỗi!", "Mô tả không được để trống!", "error");
                    return;
                }

                // Nếu tất cả hợp lệ, hiển thị xác nhận
                Swal.fire({
                    title: "Xác nhận!",
                    text: "Bạn có chắc muốn thêm phòng khách sạn này?",
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

        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    </body>
</html>
