<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.List"%>
<%@page import="dao.PetHotelDAO"%>
<%@page import="model.PetHotel"%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="./components/header.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh sách phòng cho thú cưng</title>
        <link rel="stylesheet" href="./css/pethotel_v2.css">
        <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;700&display=swap" rel="stylesheet">
    </head>
    <body>
        <div class="all"> 
            <div class="mt-4 bg-white p-3 mb-4 d-flex align-items-center justify-content-left" 
                 style="border-radius: 20px; height: 60px;">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0" style="font-weight: bold;">
                        <li class="breadcrumb-item"><a href="pawfect" class="text-decoration-none">Trang chủ</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Khách sạn thú cưng</li>
                    </ol>
                </nav>
            </div>

            <h2 style="margin: 0">Khách sạn thú cưng</h2>
            <h5>Bạn hãy lựa chọn phòng dựa vào cân nặng và giống chó hoặc mèo nhé!</h5>

            <div class="filter">
                <div class="filterbox">
                    <button class="nut-loc" onclick="filterRooms('all', 'all')">Tất cả</button>
                    <button class="nut-loc" onclick="filterRooms('small', 'all')">Nhỏ</button>
                    <button class="nut-loc" onclick="filterRooms('medium', 'all')">Vừa</button>
                    <button class="nut-loc" onclick="filterRooms('large', 'all')">Lớn</button>
                    <button class="nut-loc" onclick="filterRooms('all', 'dog')">Chó</button>
                    <button class="nut-loc" onclick="filterRooms('all', 'cat')">Mèo</button>
                </div>
            </div>

            <div class="hotel-container">
                <button id="scrollLeft" class="scroll-btn">&#10094;</button>
                <div class="hotel-list">
                    <c:choose>
                        <c:when test="${not empty requestScope.roomList}">
                            <c:forEach var="room" items="${requestScope.roomList}">
                                <div class="pethotel-card">
                                    <img src="<%= request.getContextPath()%>/img/pethotel/${room.roomImage}" alt="${room.roomName}" 
                                         onclick="window.location.href = 'pethoteldetail?id=${room.roomId}'">
                                    <div class="pethotel-name">${room.roomName}</div>
                                    <div class="pethotel-type">Dành cho ${room.roomType}</div>
                                    <div class="pethotel-price">
                                        <fmt:formatNumber value="${room.pricePerNight}" type="currency" currencyCode="VND"/>
                                        /đêm
                                    </div>
                                    <div class="pethotel-weight">
                                        Cân nặng: ${room.minWeight} - ${room.maxWeight} kg
                                    </div>
                                    <c:choose>
                                        <c:when test="${room.status == 'Còn phòng'}">
                                            <a href="bookingform?id=${room.roomId}" class="booking" data-status="${room.status}">Đặt lịch ngay</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="bookingform?id=${room.roomId}" class="booking" data-status="${room.status}">Hết phòng</a>
                                        </c:otherwise>
                                    </c:choose>

                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <p>Không có phòng nào phù hợp với bộ lọc này.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
                <button id="scrollRight" class="scroll-btn">&#10095;</button>
            </div>
        </div>
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
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="./js/pethotel.js"></script>
    </body>
</html>
