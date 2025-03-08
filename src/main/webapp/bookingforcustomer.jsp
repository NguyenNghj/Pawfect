<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="./components/header.jsp" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đặt Phòng Khách Sạn Thú Cưng</title>
        <link rel="stylesheet" href="./css/bookingforcustomer_v1.css">
        <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;700&display=swap" rel="stylesheet">
        <script>
            function showAlert(message) {
                Swal.fire({
                    title: "Thông báo",
                    text: message,
                    icon: "warning",
                    confirmButtonText: "OK",
                    confirmButtonColor: "#ff6b6b",
                });
            }

            function calculateTotalPrice() {
                const checkIn = document.getElementById("checkIn").value;
                const checkOut = document.getElementById("checkOut").value;
                const pricePerNight = parseFloat(document.getElementById("pricePerNight").value);

                if (checkIn && checkOut) {
                    const dateIn = new Date(checkIn);
                    const dateOut = new Date(checkOut);
                    const timeDiff = dateOut - dateIn;
                    const days = timeDiff / (1000 * 60 * 60 * 24);

                    if (days > 0) {
                        let total = days * pricePerNight;
                        document.getElementById("totalPrice").value = total.toLocaleString('vi-VN'); // Hiển thị dạng có dấu phẩy
                        document.getElementById("totalPriceHidden").value = total; // Giá trị thực không có dấu phẩy
                    } else {
                        showAlert("Vui lòng chọn ngày check-out hợp lệ!");
                        document.getElementById("checkOut").value = "";
                        document.getElementById("totalPrice").value = "";
                    }
                }
            }

        </script>
    </head>
    <body>
        <!-- Breadcrumb -->
        <ol class="breadcrumb">
            <li><a class="trang-chu" href="/pawfect">Trang chủ</a></li>
            <li><a class="trang-chu" href="/pethotel">Khách sạn thú cưng</a></li>
            <li><a class="trang-chu" href="/pethoteldetail?id=${room.roomId}">Phòng ${room.roomName} dành cho ${room.roomType}</a></li>
            <li>Đặt lịch</li>
        </ol>

        <h3>THÔNG TIN ĐẶT LỊCH</h3>

        <!-- Container chính -->
        <div class="container">
            <!-- Thông tin khách hàng bên trái -->
            <div class="info-container">
                <div class="info-box">
                    <h3>Thông tin khách hàng</h3>
                    <ul class="info-list">
                        <li><strong>Họ và tên:</strong> ${customer.fullName}</li>
                        <li><strong>Email:</strong> ${customer.email}</li>
                        <li><strong>Số điện thoại:</strong> ${customer.phone}</li>
                    </ul>
                </div>
                <h2 class="title">Phòng ${room.roomName} dành cho ${room.roomType}</h2>
                <img src="${room.roomImage}" alt="Hình ảnh phòng ${room.roomName}" class="room-image">
            </div>

            <!-- Form đặt phòng bên phải -->
            <div class="form-container">
                <form action="booking" method="post" onsubmit="validateBooking(event)">
                    <input type="hidden" name="customerId" value="${customer.customerId}">
                    <input type="hidden" name="roomId" value="${room.roomId}">
                    <input type="hidden" id="pricePerNight" value="${room.pricePerNight}">
                    <input type="hidden" name="totalPriceHidden" id="totalPriceHidden">

                    <div class="form-group">
                        <label for="checkIn">Check-in:</label>
                        <input type="datetime-local" name="checkIn" id="checkIn" required onchange="calculateTotalPrice()">
                    </div>

                    <div class="form-group">
                        <label for="checkOut">Check-out:</label>
                        <input type="datetime-local" name="checkOut" id="checkOut" required onchange="calculateTotalPrice()">
                    </div>

                    <div class="form-group">
                        <label for="petId">Chọn Thú Cưng:</label>
                        <select name="petId" id="petId" required>
                            <c:forEach var="pet" items="${petList}">
                                <option value="${pet.petId}">${pet.petname}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="note">Ghi chú:</label>
                        <textarea name="note" rows="3" placeholder="Nhập ghi chú..." maxlength="10000"></textarea>
                    </div>

                    <div class="form-group">
                        <label for="totalPrice">Tổng giá (VND):</label>
                        <input type="text" name="totalPrice" id="totalPrice" readonly>
                    </div>

                    <button type="submit">Đặt Phòng</button>
                </form>
            </div>
        </div>
    </body>
</html>
