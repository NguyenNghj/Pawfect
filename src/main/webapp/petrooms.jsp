<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.PetRooms"%>
<%@page import="dao.PetRoomDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>PetHotel</title>
        <link rel="stylesheet" href="./css/petrooms_v3.css">
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
                <% List<PetRooms> list = PetRoomDAO.getAllPetRooms();
                    for (PetRooms room : list) {%>
                <div class="card">
                    <h3><%= room.getRoomName()%></h3>
                    <p><%= room.getPricePerNight()%>đ/Ngày</p>
                    <p><%= room.getRoomType()%></p>     
                    <br><br><br><br> 
                    <a href="petroomdetail?id=<%= room.getRoomId()%>">Xem Chi Tiết</a>
                </div>
                <% }%>
            </div>
        </div>
    </body>
</html>
