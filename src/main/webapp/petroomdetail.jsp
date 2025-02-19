<%-- 
    Document   : petroomsdetail
    Created on : Feb 18, 2025, 11:51:28 PM
    Author     : Nguyen Tien Thanh
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.PetRooms" %>

<jsp:useBean id="room" class="model.PetRooms" scope="request" />

<html>
    <head>
        <title>Chi tiết phòng</title>
        <link rel="stylesheet" href="./css/petroomdetail.css">
    </head>
    <body>
        <div class="header">
            <a href="index.html" class="title">Trang chủ</a>
            <span class="separator">/</span>
            <a href="petrooms.jsp" class="subtitle1">Pet Hotel</a>
            <span class="separator">/</span>
            <a href="petroomdetail?id=<%= room.getRoomId()%>" class="subtitle2">Tên phòng</a>
        </div>
        <div class="room-detail">
            <h1 class="room-title"><span>${room.roomName}</span></h1><br>
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

        <button class="book-btn">
            <img src="calendar-icon.png" alt="Đặt lịch">
        </button>
    </div>
            <br><br><br><h1 class="same">PHÒNG TƯƠNG TỰ</h1>
            
    </body>
</html>


