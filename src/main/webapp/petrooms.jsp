<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.PetRooms"%>
<%@page import="dao.PetRoomDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>PetHotel</title>
        <link rel="stylesheet" href="./css/petrooms_v4.css">
    </head>
    <body>
        <div class="header">
            <a href="index.html" class="title">Trang chủ</a>
            <span class="separator">/</span>
            <a href="petrooms.jsp" class="subtitle">Pet Hotel</a>
        </div>

        <h1 class="name">PET HOTEL</h1>

        <div class="filter-wrapper">
            <div class="filter">
                <button class="filter-btn" data-filter="cat">MÈO</button>
                <button class="filter-btn" data-filter="dog">CHÓ</button>
                <button class="filter-btn" data-filter="below-100k">DƯỚI 100.000đ</button>
                <button class="filter-btn" data-filter="100k-300k">100.000đ - 200.000đ</button>
                <button class="filter-btn" data-filter="above-300k">TRÊN 200.000đ</button>
                <button class="filter-btn" data-filter="ascending">TĂNG DẦN</button>
                <button class="filter-btn" data-filter="descending">GIẢM DẦN</button>
            </div>
        </div>

        <div class="container centered">
            <div class="service flex-container">
                <div class="service-container">
                    <h2>DỊCH VỤ PHÒNG VIP</h2>
                    <ul>
                        <li>MIỄN PHÍ: Đưa đón nội ô bán kính 5km.</li>
                        <li>ƯU ĐÃI: Tặng gói tắm khi gửi trên 5 ngày.</li>
                        <li>Phòng riêng biệt, cực kỳ thoải mái.</li>
                        <li>Thức ăn: Pate + Thịt tươi theo khẩu vị.</li>
                        <li>Đưa đón theo yêu cầu (phụ thu hoặc mang theo).</li>
                        <li>Cập nhật hình ảnh mỗi ngày qua ZALO.</li>
                    </ul>
                </div>

                <div class="service-container">
                    <h2>DỊCH VỤ PHÒNG TIÊU CHUẨN</h2>
                    <ul>
                        <li>Phòng kích thước trung bình.</li>
                        <li>Thức ăn: Hạt Classic + Pate.</li>
                    </ul>
                </div>
            </div>
            <div class="grid-container responsive-grid">
                <%
                    List<PetRooms> list = (List<PetRooms>) request.getAttribute("roomList");
                    if (list == null) {
                        list = PetRoomDAO.getAllPetRooms(); // Nếu danh sách null, lấy tất cả phòng
                    }
                    if (!list.isEmpty()) {
                        for (PetRooms room : list) {
                %>
                <div class="card">
                    <h3><%= room.getRoomName()%></h3>
                    <br>
                    <p><%= room.getPricePerNight()%>đ/Ngày</p>
                    <br>
                    <p><%= room.getRoomType()%></p>  
                    <br>
                    <img src="<%= room.getRoomImage()%>" alt="<%= room.getRoomName()%>" class="room-image">
                    <a href="petroomdetail?id=<%= room.getRoomId()%>">Xem Chi Tiết</a>
                </div>
                <%
                    }
                } else {
                %>
                <p>Không có phòng nào phù hợp với bộ lọc này.</p>
                <% }%>
            </div>
        </div>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const filterButtons = document.querySelectorAll(".filter-btn");
                const urlParams = new URLSearchParams(window.location.search);
                let currentFilter = urlParams.get("filter") || "";

                // Khi trang load, đánh dấu button đang được chọn
                filterButtons.forEach(button => {
                    if (button.getAttribute("data-filter") === currentFilter) {
                        button.classList.add("active");
                    }
                });

                filterButtons.forEach(button => {
                    button.addEventListener("click", function () {
                        const filterValue = this.getAttribute("data-filter");

                        if (currentFilter === filterValue) {
                            // Nếu nhấn lại cùng filter -> Hủy filter, hiển thị tất cả phòng
                            window.location.href = "petrooms";
                        } else {
                            // Chọn filter mới -> Cập nhật URL
                            window.location.href = "petrooms?filter=" + filterValue;
                        }
                    });
                });
            });
        </script>
    </body>
</html>
