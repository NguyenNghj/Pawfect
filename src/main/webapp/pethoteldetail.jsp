<%-- 
    Document   : pethoteldetail
    Created on : Feb 28, 2025, 4:03:47 PM
    Author     : Nguyen Tien Thanh
--%>

<%@page import="java.util.List"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="model.PetHotel"%>
<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chi tiết phòng khách sạn thú cưng</title>
        <link rel="stylesheet" href="./css/pethoteldetail_v1.css">
        <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;700&display=swap" rel="stylesheet">
    </head>
    <body>

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
                <h2><%= room.getRoomName()%></h2>
                <div class="detail">                
                    <p class="room-type">Dành cho <%= room.getRoomType()%></p>
                    <p class="room-price">Giá: <%= NumberFormat.getInstance(new Locale("vi", "VN")).format(room.getPricePerNight())%> đ/đêm</p>
                    <p class="room-weight">Cân nặng phù hợp: <%= room.getMinWeight()%> - <%= room.getMaxWeight()%> kg</p>
                    <hr class="divider"> 
                    <p class="room-description"><%= room.getDescription()%></p>
                </div>
                <div class="button-container">
                    <a href="booking?id=<%= room.getRoomId()%>" class="booking-btn">Đặt phòng ngay</a>
                    <a href="pethotel" class="back-btn">Quay lại</a>
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
                <div class="pethotel-card" onclick="window.location.href = 'pethoteldetail?id=<%= room.getRoomId()%>'">
                    <img src="<%= room.getRoomImage()%>" alt="<%= room.getRoomName()%>">
                    <div class="pethotel-name"><%= room.getRoomName()%></div>
                    <div class="pethotel-type"><%= room.getRoomType()%></div>
                    <div class="pethotel-price"><%= NumberFormat.getInstance(new Locale("vi", "VN")).format(room.getPricePerNight())%> đ/đêm</div>
                    <div class="pethotel-weight">
                        Cân nặng: <%= room.getMinWeight()%> - <%= room.getMaxWeight()%> kg
                    </div>
                    <a href="petroomdetail?id=<%= room.getRoomId()%>" class="booking">Đặt phòng ngay</a>
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
    </body>
</html>
