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
        <link rel="stylesheet" href="./css/petroomdetail_v2.css">
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
        <div>
            
            
        </div>
        <div class="room-detail">
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

        </div>
    </body>
</html>


