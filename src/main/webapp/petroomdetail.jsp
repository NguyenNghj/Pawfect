<%-- 
    Document   : petroomsdetail
    Created on : Feb 18, 2025, 11:51:28 PM
    Author     : Nguyen Tien Thanh
--%>

<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.PetRooms" %>

<jsp:useBean id="room" class="model.PetRooms" scope="request" />

<html>
    <head>
        <title>Chi tiết phòng</title>
        <link rel="stylesheet" href="./css/petroomdetail_v3.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>
    <body>
        <div class="header">
            <a href="index.html" class="title">Trang chủ</a>
            <span class="separator">/</span>
            <a href="petrooms.jsp" class="subtitle1">Pet Hotel</a>
            <span class="separator">/</span>
            <a href="petroomdetail?id=<%= room.getRoomId()%>" class="subtitle2">Tên phòng</a>
        </div>

        <div class="room-detail-container">
            <div class="room-image-container">
                <img src="${room.roomImage}" alt="${room.roomName}" class="room-image">
            </div>
            <div class="room-info-container">
                <h1 class="room-title"><span>${room.roomName}</span></h1>
                <p class="room-price">Giá: <span>${room.pricePerNight}đ/ngày</span></p>
                <p class="room-type">${room.roomType}</p>

                <div class="room-info">
                    <h3>Thông tin phòng</h3>
                    <p class="room-description">
                        <span>Cân nặng tối thiểu: ${room.minWeight} kg</span><br>
                        <span>Cân nặng tối đa: ${room.maxWeight} kg</span><br>
                        <span>Số lượng: ${room.quantity} chuồng</span><br>
                        <span>Trạng thái: ${room.status}</span>
                    </p>
                </div>
                <a href="bookingforcustomer.jsp" class="book-room-btn" id="bookRoomBtn" data-status="${room.status}">Đặt phòng</a>
            </div>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const bookRoomBtn = document.getElementById("bookRoomBtn");

                bookRoomBtn.addEventListener("click", function (event) {
                    event.preventDefault();
                    const roomStatus = bookRoomBtn.getAttribute("data-status").trim().toLowerCase();

                    if (roomStatus === "hết phòng") {
                        Swal.fire({
                            icon: 'error',
                            title: 'Phòng đã hết!',
                            text: 'Vui lòng chọn phòng khác. Xin cảm ơn!',
                            confirmButtonText: 'OK'
                        });
                    } else {
                        window.location.href = bookRoomBtn.getAttribute("href");
                    }
                });
            });
        </script>
        <h2 class="phongtuongtu">Phòng Tương Tự</h2>
        <div class="grid-container responsive-grid">
            <%
                List<PetRooms> similarRooms = (List<PetRooms>) request.getAttribute("similarRooms");
                if (similarRooms != null && !similarRooms.isEmpty()) {
                    for (PetRooms similarRoom : similarRooms) { // Đổi tên biến để tránh trùng lặp
%>
            <div class="card">
                <h3><%= similarRoom.getRoomName()%></h3>
                <p><%= similarRoom.getPricePerNight()%>đ/Ngày</p>
                <p><%= similarRoom.getRoomType()%></p>     
                <img src="<%= similarRoom.getRoomImage()%>" alt="<%= similarRoom.getRoomName()%>" class="room-image">
                <a href="petroomdetail?id=<%= similarRoom.getRoomId()%>">Xem Chi Tiết</a>
            </div>
            <%
                }
            } else {
            %>
            <p>Không có phòng nào tương tự.</p>
            <% }%>
        </div>
        <br>
        <br>
</html>
