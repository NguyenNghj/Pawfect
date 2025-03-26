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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="./css/bookingforcustomer.css">
        <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;700&display=swap" rel="stylesheet">
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const checkInInput = document.getElementById("checkIn");
                const checkOutInput = document.getElementById("checkOut");
                const petSelect = document.getElementById("petId");
                const pricePerNightInput = document.getElementById("pricePerNight");
                const totalPriceInput = document.getElementById("totalPrice");
                const totalPriceHidden = document.getElementById("totalPriceHidden");

                function setMinDateTime() {
                    let now = new Date();
                    now.setMinutes(now.getMinutes() - now.getTimezoneOffset()); // Điều chỉnh múi giờ
                    let minDateTime = now.toISOString().slice(0, 16);

                    checkInInput.min = minDateTime;
                    checkOutInput.min = minDateTime;
                }

                function updateCheckOutMin() {
                    if (checkInInput.value) {
                        checkOutInput.min = checkInInput.value;
                    }
                }

                function checkPetSelected() {
                    if (!petSelect || !petSelect.value) {
                        Swal.fire({
                            icon: "error",
                            title: "Lỗi!",
                            text: "Vui lòng chọn thú cưng trước khi đặt phòng!"
                        });
                        return false;
                    }
                    return true;
                }

                function validateCheckInOut() {
                    let checkIn = new Date(checkInInput.value);
                    let checkOut = new Date(checkOutInput.value);
                    let now = new Date();

                    if (isNaN(checkIn)) {
                        Swal.fire("Lỗi!", "Vui lòng chọn ngày Check-in!", "error");
                        return false;
                    }

                    if (checkIn < now) {
                        Swal.fire("Lỗi!", "Ngày Check-in không được nhỏ hơn hiện tại!", "error");
                        return false;
                    }

                    if (checkOut <= checkIn) {
                        Swal.fire("Lỗi!", "Ngày Check-out phải sau Check-in!", "error");
                        return false;
                    }

                    return true;
                }

                function calculateTotalPrice() {
                    if (!validateCheckInOut())
                        return;

                    let checkIn = new Date(checkInInput.value);
                    let checkOut = new Date(checkOutInput.value);
                    let pricePerNight = parseFloat(pricePerNightInput.value) || 0;

                    if (isNaN(checkIn) || isNaN(checkOut) || checkOut <= checkIn) {
                        totalPriceInput.value = "";
                        totalPriceHidden.value = "";
                        return;
                    }

                    let diffDays = Math.ceil((checkOut - checkIn) / (1000 * 60 * 60 * 24)); // Số ngày
                    let totalPrice = diffDays * pricePerNight;

                    totalPriceInput.value = totalPrice.toLocaleString("vi-VN");
                    totalPriceHidden.value = totalPrice;
                }

                window.validateCheckInOut = validateCheckInOut;
                window.checkPetSelected = checkPetSelected;
                window.updateCheckOutMin = updateCheckOutMin;
                window.calculateTotalPrice = calculateTotalPrice;

                window.onload = setMinDateTime;
            });

        </script>
    </head>
    <body>
        <!-- Breadcrumb -->
        <div class="all"> 
            <div class="mt-4 bg-white p-3 mb-4 d-flex align-items-center justify-content-left" 
                 style="border-radius: 20px; height: 60px;">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0" style="font-weight: bold;">
                        <li class="breadcrumb-item"><a href="pawfect" class="text-decoration-none">Trang chủ</a></li>
                        <li class="breadcrumb-item"><a href="pethotel" class="text-decoration-none">Khách sạn thú cưng</a></li>
                        <li class="breadcrumb-item"><a href="pethoteldetail?id=${room.roomId}" class="text-decoration-none">Phòng ${room.roomName} dành cho ${room.roomType}</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Thông tin đặt lịch</li>
                    </ol>
                </nav>
            </div>
        </div>

        <h3>BIỂU MẪU ĐẶT LỊCH</h3>

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
                <img src="<%= request.getContextPath()%>/img/pethotel/${room.roomImage}" alt="Hình ảnh phòng ${room.roomName}" class="room-image">
            </div>

            <div class="form-container">
                <form action="bookingform" method="post" onsubmit="return validateCheckInOut() && checkPetSelected();">
                    <input type="hidden" name="customerId" value="${customer.customerId}">
                    <input type="hidden" name="roomId" value="${room.roomId}">
                    <input type="hidden" id="pricePerNight" value="${room.pricePerNight}">
                    <input type="hidden" name="totalPriceHidden" id="totalPriceHidden">

                    <div class="form-group">
                        <label for="checkIn">Check-in:</label>
                        <input type="datetime-local" name="checkIn" id="checkIn" onchange="updateCheckOutMin();
                                calculateTotalPrice();">
                    </div>

                    <div class="form-group">
                        <label for="checkOut">Check-out:</label>
                        <input type="datetime-local" name="checkOut" id="checkOut" required="" onchange="calculateTotalPrice();">
                    </div>


                    <div class="form-group">
                        <label for="petId">Chọn Thú Cưng:</label>
                        <c:choose>
                            <c:when test="${empty petList}">
                                <p style="color: red;">Bạn chưa có thú cưng. Vui lòng thêm thú cưng trước khi đặt phòng!</p>
                                <a href="viewpet" 
                                   style="display: inline-block; padding: 5px 8px; background: #8c6e63; color: white; text-decoration: none; border-radius: 10px; font-weight: bold; font-size: 14px; white-space: nowrap; width: max-content; text-align: left; margin-left: 0;">
                                    🐶 Thêm thú cưng
                                </a>



                            </c:when>
                            <c:otherwise>
                                <select name="petId" id="petId" onchange="checkPetStatus();">
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

                    <div class="button-group" style="display: flex; gap: 10px; align-items: center;">
                        <!-- Nút Đặt lịch -->
                        <button type="submit" style="
                                background-color: #8c6e63;
                                color: white;
                                padding: 10px 15px;
                                border: none;
                                border-radius: 5px;
                                cursor: pointer;
                                width: 70%;">
                            Đặt lịch
                        </button>
                        <!-- Nút Quay lại -->
                        <button type="button" onclick="history.back();" style="
                                background-color: gray;
                                color: white;
                                padding: 10px 15px;
                                border: none;
                                border-radius: 5px;
                                cursor: pointer;
                                width: 30%;">
                            Quay lại
                        </button>
                    </div>


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
        <svg id="wave" style="transform:rotate(0deg); transition: 0.3s" viewBox="0 0 1440 100" version="1.1" xmlns="http://www.w3.org/2000/svg"><defs><linearGradient id="sw-gradient-0" x1="0" x2="0" y1="1" y2="0"><stop stop-color="rgba(140, 110, 99, 1)" offset="0%"></stop><stop stop-color="rgba(140, 110, 99, 1)" offset="100%"></stop></linearGradient></defs><path style="transform:translate(0, 0px); opacity:1" fill="url(#sw-gradient-0)" d="M0,0L40,13.3C80,27,160,53,240,55C320,57,400,33,480,31.7C560,30,640,50,720,58.3C800,67,880,63,960,53.3C1040,43,1120,27,1200,25C1280,23,1360,37,1440,36.7C1520,37,1600,23,1680,16.7C1760,10,1840,10,1920,11.7C2000,13,2080,17,2160,15C2240,13,2320,7,2400,8.3C2480,10,2560,20,2640,20C2720,20,2800,10,2880,15C2960,20,3040,40,3120,48.3C3200,57,3280,53,3360,56.7C3440,60,3520,70,3600,73.3C3680,77,3760,73,3840,61.7C3920,50,4000,30,4080,28.3C4160,27,4240,43,4320,51.7C4400,60,4480,60,4560,56.7C4640,53,4720,47,4800,38.3C4880,30,4960,20,5040,23.3C5120,27,5200,43,5280,50C5360,57,5440,53,5520,51.7C5600,50,5680,50,5720,50L5760,50L5760,100L5720,100C5680,100,5600,100,5520,100C5440,100,5360,100,5280,100C5200,100,5120,100,5040,100C4960,100,4880,100,4800,100C4720,100,4640,100,4560,100C4480,100,4400,100,4320,100C4240,100,4160,100,4080,100C4000,100,3920,100,3840,100C3760,100,3680,100,3600,100C3520,100,3440,100,3360,100C3280,100,3200,100,3120,100C3040,100,2960,100,2880,100C2800,100,2720,100,2640,100C2560,100,2480,100,2400,100C2320,100,2240,100,2160,100C2080,100,2000,100,1920,100C1840,100,1760,100,1680,100C1600,100,1520,100,1440,100C1360,100,1280,100,1200,100C1120,100,1040,100,960,100C880,100,800,100,720,100C640,100,560,100,480,100C400,100,320,100,240,100C160,100,80,100,40,100L0,100Z"></path><defs><linearGradient id="sw-gradient-1" x1="0" x2="0" y1="1" y2="0"><stop stop-color="rgba(140, 110, 99, 1)" offset="0%"></stop><stop stop-color="rgba(140, 110, 99, 1)" offset="100%"></stop></linearGradient></defs><path style="transform:translate(0, 50px); opacity:0.9" fill="url(#sw-gradient-1)" d="M0,20L40,25C80,30,160,40,240,45C320,50,400,50,480,41.7C560,33,640,17,720,20C800,23,880,47,960,50C1040,53,1120,37,1200,28.3C1280,20,1360,20,1440,16.7C1520,13,1600,7,1680,18.3C1760,30,1840,60,1920,70C2000,80,2080,70,2160,58.3C2240,47,2320,33,2400,31.7C2480,30,2560,40,2640,41.7C2720,43,2800,37,2880,40C2960,43,3040,57,3120,66.7C3200,77,3280,83,3360,81.7C3440,80,3520,70,3600,68.3C3680,67,3760,73,3840,68.3C3920,63,4000,47,4080,35C4160,23,4240,17,4320,15C4400,13,4480,17,4560,28.3C4640,40,4720,60,4800,58.3C4880,57,4960,33,5040,33.3C5120,33,5200,57,5280,68.3C5360,80,5440,80,5520,71.7C5600,63,5680,47,5720,38.3L5760,30L5760,100L5720,100C5680,100,5600,100,5520,100C5440,100,5360,100,5280,100C5200,100,5120,100,5040,100C4960,100,4880,100,4800,100C4720,100,4640,100,4560,100C4480,100,4400,100,4320,100C4240,100,4160,100,4080,100C4000,100,3920,100,3840,100C3760,100,3680,100,3600,100C3520,100,3440,100,3360,100C3280,100,3200,100,3120,100C3040,100,2960,100,2880,100C2800,100,2720,100,2640,100C2560,100,2480,100,2400,100C2320,100,2240,100,2160,100C2080,100,2000,100,1920,100C1840,100,1760,100,1680,100C1600,100,1520,100,1440,100C1360,100,1280,100,1200,100C1120,100,1040,100,960,100C880,100,800,100,720,100C640,100,560,100,480,100C400,100,320,100,240,100C160,100,80,100,40,100L0,100Z"></path><defs><linearGradient id="sw-gradient-2" x1="0" x2="0" y1="1" y2="0"><stop stop-color="rgba(140, 110, 99, 1)" offset="0%"></stop><stop stop-color="rgba(140, 110, 99, 1)" offset="100%"></stop></linearGradient></defs><path style="transform:translate(0, 100px); opacity:0.8" fill="url(#sw-gradient-2)" d="M0,50L40,50C80,50,160,50,240,50C320,50,400,50,480,41.7C560,33,640,17,720,13.3C800,10,880,20,960,23.3C1040,27,1120,23,1200,23.3C1280,23,1360,27,1440,36.7C1520,47,1600,63,1680,71.7C1760,80,1840,80,1920,81.7C2000,83,2080,87,2160,75C2240,63,2320,37,2400,23.3C2480,10,2560,10,2640,16.7C2720,23,2800,37,2880,35C2960,33,3040,17,3120,18.3C3200,20,3280,40,3360,53.3C3440,67,3520,73,3600,68.3C3680,63,3760,47,3840,43.3C3920,40,4000,50,4080,51.7C4160,53,4240,47,4320,45C4400,43,4480,47,4560,40C4640,33,4720,17,4800,21.7C4880,27,4960,53,5040,60C5120,67,5200,53,5280,43.3C5360,33,5440,27,5520,30C5600,33,5680,47,5720,53.3L5760,60L5760,100L5720,100C5680,100,5600,100,5520,100C5440,100,5360,100,5280,100C5200,100,5120,100,5040,100C4960,100,4880,100,4800,100C4720,100,4640,100,4560,100C4480,100,4400,100,4320,100C4240,100,4160,100,4080,100C4000,100,3920,100,3840,100C3760,100,3680,100,3600,100C3520,100,3440,100,3360,100C3280,100,3200,100,3120,100C3040,100,2960,100,2880,100C2800,100,2720,100,2640,100C2560,100,2480,100,2400,100C2320,100,2240,100,2160,100C2080,100,2000,100,1920,100C1840,100,1760,100,1680,100C1600,100,1520,100,1440,100C1360,100,1280,100,1200,100C1120,100,1040,100,960,100C880,100,800,100,720,100C640,100,560,100,480,100C400,100,320,100,240,100C160,100,80,100,40,100L0,100Z"></path><defs><linearGradient id="sw-gradient-3" x1="0" x2="0" y1="1" y2="0"><stop stop-color="rgba(140, 110, 99, 1)" offset="0%"></stop><stop stop-color="rgba(140, 110, 99, 1)" offset="100%"></stop></linearGradient></defs><path style="transform:translate(0, 150px); opacity:0.7" fill="url(#sw-gradient-3)" d="M0,40L40,43.3C80,47,160,53,240,61.7C320,70,400,80,480,81.7C560,83,640,77,720,61.7C800,47,880,23,960,23.3C1040,23,1120,47,1200,58.3C1280,70,1360,70,1440,70C1520,70,1600,70,1680,73.3C1760,77,1840,83,1920,76.7C2000,70,2080,50,2160,46.7C2240,43,2320,57,2400,53.3C2480,50,2560,30,2640,28.3C2720,27,2800,43,2880,55C2960,67,3040,73,3120,76.7C3200,80,3280,80,3360,66.7C3440,53,3520,27,3600,16.7C3680,7,3760,13,3840,25C3920,37,4000,53,4080,50C4160,47,4240,23,4320,20C4400,17,4480,33,4560,41.7C4640,50,4720,50,4800,50C4880,50,4960,50,5040,43.3C5120,37,5200,23,5280,28.3C5360,33,5440,57,5520,56.7C5600,57,5680,33,5720,21.7L5760,10L5760,100L5720,100C5680,100,5600,100,5520,100C5440,100,5360,100,5280,100C5200,100,5120,100,5040,100C4960,100,4880,100,4800,100C4720,100,4640,100,4560,100C4480,100,4400,100,4320,100C4240,100,4160,100,4080,100C4000,100,3920,100,3840,100C3760,100,3680,100,3600,100C3520,100,3440,100,3360,100C3280,100,3200,100,3120,100C3040,100,2960,100,2880,100C2800,100,2720,100,2640,100C2560,100,2480,100,2400,100C2320,100,2240,100,2160,100C2080,100,2000,100,1920,100C1840,100,1760,100,1680,100C1600,100,1520,100,1440,100C1360,100,1280,100,1200,100C1120,100,1040,100,960,100C880,100,800,100,720,100C640,100,560,100,480,100C400,100,320,100,240,100C160,100,80,100,40,100L0,100Z"></path></svg>
        <%@include file="./components/footer.jsp" %>
    </body>
</html>
