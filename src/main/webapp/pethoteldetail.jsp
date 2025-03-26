<%-- 
    Document   : pethoteldetail
    Created on : Feb 28, 2025, 4:03:47 PM
    Author     : Nguyen Tien Thanh
--%>

<%@page import="java.util.List"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="model.PetHotel"%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="./components/header.jsp" %>
<!DOCTYPE html>

<html>
    <head>
        <meta charset="UTF-8">
        <title>Phòng ${room.roomName} dành cho ${room.roomType}</title>       
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <link rel="stylesheet" href="./css/pethoteldetail.css?v=123456">
    </head>
    <body>
        <div class="all"> 
            <div class="mt-4 bg-white p-3 mb-4 d-flex align-items-center justify-content-left" 
                 style="border-radius: 20px; height: 60px;">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0" style="font-weight: bold;">
                        <li class="breadcrumb-item"><a href="pawfect" class="text-decoration-none">Trang chủ</a></li>
                        <li class="breadcrumb-item"><a href="pethotel" class="text-decoration-none">Khách sạn thú cưng</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Phòng ${room.roomName} dành cho ${room.roomType}</li>
                    </ol>
                </nav>
            </div>
        </div>

        <c:choose>
            <c:when test="${empty room}">
                <p>Phòng không tồn tại hoặc có lỗi xảy ra.</p>
                <a href="pethotel" class="back-btn">Quay lại</a>
            </c:when>
            <c:otherwise>
                <h3>Chi tiết phòng ${room.roomName} dành cho ${room.roomType}</h3>
                <div class="detail-container">
                    <div class="image-container">
                        <img src="<%= request.getContextPath()%>/img/pethotel/${room.roomImage}" alt="${room.roomName}">
                    </div>
                    <div class="info-container">
                        <h2>Phòng ${room.roomName}</h2>
                        <div class="detail">
                            <p class="room-type">Dành cho ${room.roomType}</p>
                            <p class="room-price">Giá: <fmt:formatNumber value="${room.pricePerNight}" type="currency" currencyCode="VND"/>/Ngày</p>
                            <p class="room-weight">Cân nặng phù hợp: ${room.minWeight} - ${room.maxWeight} kg</p>
                            <hr class="divider">
                            <p class="room-description" style="text-align: left;">${room.description}</p>
                        </div>
                        <div class="button-container">
                            <a href="bookingform?id=${room.roomId}" class="booking-btn">Đặt lịch ngay</a>
                            <a href="pethotel" class="back-btn">Quay lại</a>
                        </div>
                    </div>
                </div>

                <h3>Phòng tương tự</h3>
                <div class="hotel-container">
                    <button id="scrollLeft" class="scroll-btn">&#10094;</button>
                    <div class="hotel-list">
                        <c:choose>
                            <c:when test="${not empty similarRooms}">
                                <c:forEach var="similarRoom" items="${similarRooms}">
                                    <div class="pethotel-card">
                                        <img style="cursor: pointer;" src="<%= request.getContextPath()%>/img/pethotel/${similarRoom.roomImage}" alt="${similarRoom.roomName}"  onclick="window.location.href = 'pethoteldetail?id=${similarRoom.roomId}'">
                                        <div class="pethotel-name">${similarRoom.roomName}</div>
                                        <div class="pethotel-type">Dành cho ${similarRoom.roomType}</div>
                                        <div class="pethotel-price">
                                            <fmt:formatNumber value="${similarRoom.pricePerNight}"/>đ/Ngày
                                        </div>
                                        <div class="pethotel-weight">Cân nặng: ${similarRoom.minWeight} - ${similarRoom.maxWeight} kg</div>
                                        <a href="bookingform?id=${room.roomId}" class="booking">Đặt lịch ngay</a>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <p>Không có phòng tương tự.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <button id="scrollRight" class="scroll-btn">&#10095;</button>
                </div>
            </c:otherwise>
        </c:choose>

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <!--        <script>
                                                    document.addEventListener("DOMContentLoaded", function () {
                                                        const bookRoomBtns = document.querySelectorAll(".booking-btn, .booking"); // Chọn cả hai loại nút
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
                                                                        confirmButtonColor: '#8B4513'
                                                                    });
                                                                } else {
                                                                    window.location.href = button.getAttribute("href");
                                                                }
                                                            });
                                                        });
                                                    });
                </script>-->
        <script>
                                            document.addEventListener("DOMContentLoaded", function () {
                                                const descriptions = document.querySelectorAll(".room-description");

                                                descriptions.forEach(desc => {
                                                    let text = desc.innerHTML;
                                                    let iconPattern = /(🐶|🐱|🌞|✨|👑|🏡|🛏️|🎾|🧸|☀️|🌳|🍖|🥩|💕|💖|💎|🛁|⏰|🍽️)/g;
                                                    let firstMatch = true;

                                                    text = text.replace(iconPattern, (match) => {
                                                        if (firstMatch) {
                                                            firstMatch = false;
                                                            return match; // Giữ nguyên icon đầu tiên
                                                        }
                                                        return "<br>" + match; // Thêm xuống dòng từ icon thứ hai trở đi
                                                    });

                                                    desc.innerHTML = text;
                                                });
                                            });

        </script>
        <script src="./js/pethotel.js"></script>

    </body>
</html>
