<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.List"%>
<%@page import="dao.PetHotelDAO"%>
<%@page import="model.PetHotel"%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@include file="./components/header.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh sách phòng cho thú cưng</title>
        <link rel="stylesheet" href="./css/pethotel_v1.css">
        <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;700&display=swap" rel="stylesheet">
    </head>
    <body>
        <h3>Danh sách phòng lưu trú thú cưng</h3>
        <h4>Bạn hãy lựa chọn phòng dựa vào cân nặng và giống chó hoặc mèo nhé!</h4>

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

        <script>
            function filterRooms(size, roomType) {
                window.location.href = "pethotel?sizeFilter=" + size + "&roomTypeFilter=" + roomType;
            }
        </script>

        <div class="hotel-container">
            <button id="scrollLeft" class="scroll-btn">&#10094;</button>
            <div class="hotel-list">
                <% List<PetHotel> list = (List<PetHotel>) request.getAttribute("roomList");
                    if (list == null) {
                        list = PetHotelDAO.getAllPetRooms();
                    }
                    if (!list.isEmpty()) {
                        for (PetHotel room : list) {%>
                <div class="pethotel-card">
                    <img src="<%= room.getRoomImage()%>" alt="<%= room.getRoomName()%>" 
                         onclick="window.location.href = 'pethoteldetail?id=<%= room.getRoomId()%>'">
                    <div class="pethotel-name"><%= room.getRoomName()%></div>
                    <div class="pethotel-type">Dành cho <%= room.getRoomType()%></div>
                    <div class="pethotel-price"><%= NumberFormat.getInstance(new Locale("vi", "VN")).format(room.getPricePerNight())%> đ/đêm</div>
                    <div class="pethotel-weight">
                        Cân nặng: <%= room.getMinWeight()%> - <%= room.getMaxWeight()%> kg
                    </div>
                    <a href="customerbooking.jsp?id=<%= room.getRoomId()%>" class="booking" data-status="<%= room.getStatus()%>">Đặt phòng ngay</a>
                </div>
                <% }
                } else { %>
                <p>Không có phòng nào phù hợp với bộ lọc này.</p>
                <% }%>
            </div>
            <button id="scrollRight" class="scroll-btn">&#10095;</button>
        </div>

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
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const buttons = document.querySelectorAll('.nut-loc');

                // Lấy giá trị từ URL (nếu có)
                const params = new URLSearchParams(window.location.search);
                const sizeFilter = params.get('sizeFilter') || 'all';
                const roomTypeFilter = params.get('roomTypeFilter') || 'all';

                // Thiết lập class 'active' khi trang tải lại
                buttons.forEach(button => {
                    const buttonSize = button.getAttribute("onclick").match(/'([^']+)'/g)[0].replace(/'/g, "");
                    const buttonType = button.getAttribute("onclick").match(/'([^']+)'/g)[1].replace(/'/g, "");

                    if (buttonSize === sizeFilter && buttonType === roomTypeFilter) {
                        button.classList.add('active');
                    }

                    button.addEventListener('click', function () {
                        buttons.forEach(btn => btn.classList.remove('active')); // Xóa 'active' khỏi tất cả nút
                        this.classList.add('active'); // Thêm 'active' vào nút được chọn
                    });
                });
            });

        </script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const bookRoomBtns = document.querySelectorAll(".booking");

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
