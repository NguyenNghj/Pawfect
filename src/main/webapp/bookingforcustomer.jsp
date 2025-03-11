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
            function setMinDateTime() {
                let now = new Date();
                now.setMinutes(now.getMinutes() - now.getTimezoneOffset()); // Điều chỉnh múi giờ
                let minDateTime = now.toISOString().slice(0, 16);

                document.getElementById("checkIn").min = minDateTime;
                document.getElementById("checkOut").min = minDateTime;
            }

            function updateCheckOutMin() {
                let checkIn = document.getElementById("checkIn").value;
                if (checkIn) {
                    document.getElementById("checkOut").min = checkIn;
                }
            }

            function validateCheckInOut() {
                let checkIn = document.getElementById("checkIn").value;
                let checkOut = document.getElementById("checkOut").value;
                let now = new Date();

                if (!checkIn) {
                    showAlert("Vui lòng chọn ngày check-in!");
                    return false;
                }

                let dateIn = new Date(checkIn);
                if (dateIn < now) {
                    showAlert("Vui lòng chọn thời gian check-in từ thời điểm hiện tại trở đi.");

                    document.getElementById("checkIn").value = "";
                    return false;
                }


                let dateOut = new Date(checkOut);
                if (dateOut <= dateIn) {
                    showAlert("Thời gian check-out phải sau check-in!");
                    document.getElementById("checkOut").value = "";
                    return false;
                }

                return true;
            }

            function calculateTotalPrice() {
                if (!validateCheckInOut())
                    return;

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
                        document.getElementById("totalPrice").value = total.toLocaleString('vi-VN');
                        document.getElementById("totalPriceHidden").value = total;
                    }
                }
            }
            function showAlert(message) {
                Swal.fire({
                    icon: "error",
                    title: "Chọn thời gian hợp lệ!",
                    text: message
                });
            }
            window.onload = setMinDateTime;
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

        <div class="container">
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

            <div class="form-container">
                <form action="bookingform" method="post" onsubmit="return validateCheckInOut()">
                    <input type="hidden" name="customerId" value="${customer.customerId}">
                    <input type="hidden" name="roomId" value="${room.roomId}">
                    <input type="hidden" id="pricePerNight" value="${room.pricePerNight}">
                    <input type="hidden" name="totalPriceHidden" id="totalPriceHidden">

                    <div class="form-group">
                        <label for="checkIn">Check-in:</label>
                        <input type="datetime-local" name="checkIn" id="checkIn" required onchange="updateCheckOutMin(); calculateTotalPrice();">
                    </div>

                    <div class="form-group">
                        <label for="checkOut">Check-out:</label>
                        <input type="datetime-local" name="checkOut" id="checkOut" required onchange="calculateTotalPrice();">
                    </div>


                    <div class="form-group">
                        <label for="petId">Chọn Thú Cưng:</label>
                        <c:choose>
                            <c:when test="${empty petList}">
                                <p style="color: red;">Bạn chưa có thú cưng. Vui lòng thêm thú cưng trước khi đặt phòng!</p>
                                <a href="viewpet" class="add-pet-btn">➕ Thêm thú cưng</a>
                            </c:when>
                            <c:otherwise>
                                <select name="petId" id="petId" required onchange="checkPetStatus();">
                                    <option value="" disabled selected>Chọn thú cưng của bạn</option> <!-- Option mặc định -->
                                    <c:forEach var="pet" items="${petList}">
                                        <option value="${pet.petId}" data-status="${petStatusMap[pet.petId]}">
                                            ${pet.petname}
                                        </option>
                                    </c:forEach>
                                </select>
                            </c:otherwise>
                        </c:choose>
                    </div>


                    <div class="form-group">
                        <label for="note">Ghi chú:</label>
                        <textarea name="note" rows="3" placeholder="Nhập ghi chú..." maxlength="10000"></textarea>
                    </div>

                    <div class="form-group">
                        <label for="totalPrice">Tổng giá (VND):</label>
                        <input type="text" name="totalPrice" id="totalPrice" readonly>
                    </div>

                    <button type="submit">Đặt lịch</button>
                </form>
            </div>
        </div>
        <script>
            function checkPetStatus() {
                let petSelect = document.getElementById("petId");
                let selectedPet = petSelect.options[petSelect.selectedIndex];
                let petStatus = selectedPet.getAttribute("data-status");

                if (petStatus === "booking") {
                    Swal.fire({
                        title: "Thú cưng đang có lịch đặt!",
                        text: "Bạn có chắc chắn muốn tiếp tục đặt phòng?",
                        icon: "warning",
                        showCancelButton: true,
                        confirmButtonText: "Tiếp tục",
                        cancelButtonText: "Hủy"
                    }).then((result) => {
                        if (!result.isConfirmed) {
                            petSelect.selectedIndex = 0; // Reset về chọn đầu tiên
                        }
                    });
                }
            }
        </script>

    </body>
</html>
