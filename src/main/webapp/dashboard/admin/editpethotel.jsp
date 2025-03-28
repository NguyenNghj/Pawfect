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
        <title>Chỉnh sửa khách sạn thú cưng</title>
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
                                <input type="text" class="form-control" name="roomName" value="${room.roomName}" >
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
                                <input type="number" class="form-control" name="minWeight" step="0.1" value="${room.minWeight}" >
                            </div>

                            <!-- Cân nặng tối đa -->
                            <div class="mb-3">
                                <label for="editMaxWeight" class="form-label">Cân nặng tối đa (kg)</label>
                                <input type="number" class="form-control" name="maxWeight" step="0.1" value="${room.maxWeight}" >
                            </div>

                            <!-- Số lượng phòng -->
                            <div class="mb-3">
                                <label for="editRoomQuantity" class="form-label">Số lượng</label>
                                <input type="number" class="form-control" name="quantity" value="${room.quantity}" >
                            </div>

                            <!-- Giá mỗi đêm -->
                            <div class="mb-3">
                                <label for="editPricePerNight" class="form-label">Giá mỗi đêm (VNĐ)</label>
                                <input type="number" class="form-control" name="pricePerNight" step="0.01" value="${room.pricePerNight}" >
                            </div>
                            <!-- Trạng thái hoạt động -->
                            <div class="mb-3">
                                <label class="form-label">Trạng thái hoạt động</label><br>
                                <!-- Select option để thay đổi trạng thái -->
                                <select class="form-select" id="isActive" name="isActive">
                                    <option value="1" ${room.isActive == '1' ? 'selected' : ''}>Hoạt động</option>
                                    <option value="0" ${room.isActive == '0' ? 'selected' : ''}>Không hoạt động</option>
                                </select>
                            </div>
                            <!-- Mô tả -->
                            <div class="mb-3">
                                <label for="editRoomDescription" class="form-label">Mô tả</label>
                                <textarea class="form-control" name="description" rows="5" >${room.description}</textarea>
                            </div>

                            <!--                             Trạng thái phòng 
                                                        <div class="mb-3">
                                                            <label for="editRoomStatus">Trạng thái</label>
                                                            <select class="form-select" name="status">
                                                                <option value="Còn phòng" ${room.status == 'Còn phòng' ? 'selected' : ''}>Còn phòng</option>
                                                                <option value="Hết phòng" ${room.status == 'Hết phòng' ? 'selected' : ''}>Hết phòng</option>
                                                            </select>
                                                        </div>-->





                            <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                            <a href="<c:url value='/dashboard/admin/pethotel'/>" class="btn btn-secondary">Trở về</a>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!--        <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        let isActiveSelect = document.getElementById("editIsActive");
                        let hiddenIsActiveInput = document.getElementById("hiddenIsActive");
        
                        // Khi chọn option, cập nhật giá trị hidden input
                        isActiveSelect.addEventListener("change", function () {
                            hiddenIsActiveInput.value = this.value;
                        });
                    });
        
        
                </script>-->

        <script>
            document.getElementById("editRoomName").addEventListener("submit", function (event) {
                event.preventDefault();

                Swal.fire({
                    title: "Xác nhận!",
                    text: "Bạn có chắc muốn cập nhật thông tin phòng?",
                    icon: "question",
                    showCancelButton: true,
                    confirmButtonText: "Đồng ý",
                    cancelButtonText: "Hủy"
                }).then((result) => {
                    if (result.isConfirmed) {
                        event.target.submit();
                    }
                });
            });
        </script>

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
        <script>
            // Tạo danh sách phòng từ dữ liệu lấy từ Servlet
            const petHotelRooms = [
            <%
                List<PetHotel> rooms = (List<PetHotel>) request.getAttribute("roomList");
                for (int i = 0; i < rooms.size(); i++) {
                    PetHotel room = rooms.get(i);
                    out.print("{ roomId: " + room.getRoomId() + ", roomName: \"" + room.getRoomName() + "\", roomType: \"" + room.getRoomType() + "\" }");
                    if (i < rooms.size() - 1) {
                        out.print(",");
                    }
                }
            %>
            ];

            console.log("Danh sách phòng từ database:", petHotelRooms);
        </script>

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            document.getElementById("editRoomForm").addEventListener("submit", function (event) {
                event.preventDefault(); // Ngăn form submit ngay lập tức

                let roomId = parseInt(document.querySelector("input[name='roomId']").value); // ID của phòng đang chỉnh sửa
                let roomName = document.querySelector("input[name='roomName']").value.trim();
                let roomType = document.querySelector("select[name='roomType']").value.trim();
                let minWeight = parseFloat(document.querySelector("input[name='minWeight']").value);
                let maxWeight = parseFloat(document.querySelector("input[name='maxWeight']").value);
                let quantity = parseInt(document.querySelector("input[name='quantity']").value);
                let pricePerNight = parseFloat(document.querySelector("input[name='pricePerNight']").value);
                let description = document.querySelector("textarea[name='description']").value.trim();
                let petHotelImage = document.getElementById("editRoomImage").files.length;

                // Biểu thức kiểm tra ký tự đặc biệt (chỉ cho phép chữ cái, số và khoảng trắng)
                let specialCharPattern = /^[\p{L} ]+$/u;

                // Kiểm tra tên phòng
                if (roomName.trim() === "") {
                    Swal.fire("Lỗi!", "Tên phòng không được để trống!", "error");
                    return;
                }

                if (!specialCharPattern.test(roomName)) {
                    Swal.fire("Lỗi!", "Tên phòng không được có ký tự đặc biệt hoặc số!", "error");
                    return;
                }

                // Kiểm tra trùng tên & loại phòng (loại trừ chính nó)
                let isDuplicate = petHotelRooms.some(room =>
                    room.roomName === roomName &&
                            room.roomType === roomType &&
                            room.roomId !== roomId // Bỏ qua phòng hiện tại
                );

                if (isDuplicate) {
                    Swal.fire("Lỗi!", "Phòng đã tồn tại!", "error");
                    return;
                }

                // Kiểm tra cân nặng
                if (isNaN(minWeight) || minWeight <= 0.9) {
                    Swal.fire("Lỗi!", "Cân nặng tối thiểu phải lớn hơn hoặc bằng 1kg!", "error");
                    return;
                }

                if (isNaN(minWeight) || minWeight > 40) {
                    Swal.fire("Lỗi!", "Cân nặng tối thiểu phải từ 40kg trở xuống!", "error");
                    return;
                }

                if (isNaN(maxWeight) || maxWeight <= 0.9) {
                    Swal.fire("Lỗi!", "Cân nặng tối đa phải lớn hơn 1kg!", "error");
                    return;
                }

                if (isNaN(maxWeight) || maxWeight > 50) {
                    Swal.fire("Lỗi!", "Cân nặng tối đa phải từ 50kg trở xuống!", "error");
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
                if (isNaN(quantity) || quantity > 50) {
                    Swal.fire("Lỗi!", "Số lượng phải nhỏ hơn 50!", "error");
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
                    text: "Bạn có chắc muốn lưu thay đổi phòng khách sạn này?",
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
