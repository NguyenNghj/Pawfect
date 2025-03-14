<%-- 
    Document   : pethoteldetail
    Created on : Feb 28, 2025, 4:03:47 PM
    Author     : Nguyen Tien Thanh
--%>

<%@page import="java.util.List"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="model.PetHotel"%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@include file="./components/header.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Phòng ${room.roomName} dành cho ${room.roomType}</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="./css/pethoteldetail_v1.css">
    </head>
    <body>

        <div class ="all">
            <div class="mt-4 bg-white p-3 mb-4 d-flex align-items-center justify-content-left" 
                 style="border-radius: 20px; height: 60px;">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0" style ="font-weight: bold;">
                        <li class="breadcrumb-item"><a href="pawfect" class="text-decoration-none">Trang chủ</a></li>
                        <li class="breadcrumb-item"><a href="pethotel?sizeFilter=all&roomTypeFilter=all" class="text-decoration-none">Khách sạn thú cưng</a></li>
                        <li class="breadcrumb-item active" aria-current="page"> Phòng ${room.roomName} dành cho ${room.roomType}</li>
                    </ol>
                </nav>
            </div>


            <%-- Lấy dữ liệu phòng từ request attribute --%>
            <%
                PetHotel room = (PetHotel) request.getAttribute("room");
                List<PetHotel> similarRooms = (List<PetHotel>) request.getAttribute("similarRooms");

                if (room == null) {
            %>
            <p>Phòng không tồn tại hoặc có lỗi xảy ra.</p>
            <a href="pethotel" class="back-btn">Quay lại</a>
            <%
            } else {
            %>

            <h3>Chi tiết phòng <%= room.getRoomName()%> dành cho <%= room.getRoomType()%></h3>
            <div class="detail-container">
                <div class="image-container">
                    <img src="<%= room.getRoomImage()%>" alt="<%= room.getRoomName()%>">
                </div>

                <div class="info-container">
                    <h2>Phòng <%= room.getRoomName()%></h2>
                    <div class="detail">
                        <p class="room-type"><i></i> Dành cho <%= room.getRoomType()%></p>
                        <p class="room-price"><i></i> Giá: <%= NumberFormat.getInstance(new Locale("vi", "VN")).format(room.getPricePerNight())%> đ/đêm</p>
                        <p class="room-weight"><i></i> Cân nặng phù hợp: <%= room.getMinWeight()%> - <%= room.getMaxWeight()%> kg</p>
                        <p class="room-quantity"><i></i> Số lượng phòng trống: <%= room.getAvailableQuantity()%>/<%= room.getQuantity()%> phòng</p>
                        <p class="room-status"><i></i> Trạng thái: <%= room.getStatus()%></p>
                        <hr class="divider">
                        <p class="room-description"><i></i> <%= room.getDescription()%></p>
                    </div>
                    <div class="button-container">
                        <a href="bookingform?id=<%= room.getRoomId()%>" class="booking-btn" data-status="<%= room.getStatus()%>"><i></i> Đặt lịch ngay</a>
                        <a href="pethotel" class="back-btn"><i></i> Quay lại</a>
                    </div>
                </div>
            </div>
        </div>
        <%-- Danh sách phòng tương tự --%>
        <h3>Phòng tương tự</h3>
        <div class="hotel-container">
            <button id="scrollLeft" class="scroll-btn">&#10094;</button>
            <div class="hotel-list">
                <%
                    if (similarRooms != null && !similarRooms.isEmpty()) {
                        for (PetHotel similarRoom : similarRooms) {
                %>
                <div class="pethotel-card">
                    <img src="<%= similarRoom.getRoomImage()%>" alt="<%= similarRoom.getRoomName()%>" 
                         onclick="window.location.href = 'pethoteldetail?id=<%= similarRoom.getRoomId()%>'">
                    <div class="pethotel-name"><%= similarRoom.getRoomName()%></div>
                    <div class="pethotel-type">Dành cho <%= similarRoom.getRoomType()%></div>
                    <div class="pethotel-price"><%= NumberFormat.getInstance(new Locale("vi", "VN")).format(similarRoom.getPricePerNight())%> đ/đêm</div>
                    <div class="pethotel-weight">
                        Cân nặng: <%= similarRoom.getMinWeight()%> - <%= similarRoom.getMaxWeight()%> kg
                    </div>
                    <a href="bookingform?id=<%= similarRoom.getRoomId()%>" class="booking" data-status="<%= similarRoom.getStatus()%>">Đặt lịch ngay</a>
                </div>

                <%
                    }
                } else {
                %>
                <p>Không có phòng tương tự.</p>
                <%
                    }
                %>
                <button id="scrollRight" class="scroll-btn">&#10095;</button>

            </div>
        </div>
        <% }%> <%-- Kết thúc kiểm tra room null --%>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const hotelList = document.querySelector(".hotel-list");
                const btnLeft = document.getElementById("scrollLeft");
                const btnRight = document.getElementById("scrollRight");
                const scrollAmount = 320; // Di chuyển đúng bằng 1 card

                function checkScrollButtons() {
                    btnLeft.style.display = hotelList.scrollLeft > 0 ? "block" : "block";
                    btnRight.style.display = hotelList.scrollLeft < (hotelList.scrollWidth - hotelList.clientWidth) ? "block" : "block";
                }

                btnLeft.addEventListener("click", function () {
                    hotelList.scrollBy({left: -scrollAmount, behavior: "smooth"});
                });

                btnRight.addEventListener("click", function () {
                    hotelList.scrollBy({left: scrollAmount, behavior: "smooth"});
                });

                hotelList.addEventListener("scroll", checkScrollButtons);
                checkScrollButtons();
            });
        </script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const bookRoomBtns = document.querySelectorAll(".booking-btn");

                bookRoomBtns.forEach(button => {
                    button.addEventListener("click", function (event) {
                        event.preventDefault();
                        const roomStatus = button.getAttribute("data-status").trim().toLowerCase();

                        if (roomStatus === "hết phòng") {
                            Swal.fire({
                                icon: 'error',
                                title: 'Phòng đã hết!',
                                text: 'Vui lòng chọn phòng khác. Xin cảm ơn!',
                                confirmButtonText: 'OK',
                                confirmButtonColor: '#8B4513' // Màu nâu (SaddleBrown)
                            });
                        } else {
                            window.location.href = button.getAttribute("href");
                        }
                    });
                });
            });
        </script>

    </body>
</html>
