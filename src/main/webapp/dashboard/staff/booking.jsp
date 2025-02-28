<%-- 
    Document   : booking
    Created on : Feb 11, 2025, 4:53:48 PM
    Author     : Vu Quang Duc - CE181221
--%>
<%@ page import="java.net.URLDecoder, java.nio.charset.StandardCharsets" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.PetHotelBookingDAO, model.PetHotelBooking, java.util.List" %>
<%@ page import="java.text.NumberFormat, java.util.Locale" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="../../css/dashboard.css">
        <title>Quản lí đặt phòng</title>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">

                <!-- SIDEBAR -->
                <div class="col-2" id="sidebar">
                    <div class="row pt-4 sidebar-brandName">
                        <div class="col d-flex justify-content-center align-items-center gap-3">
                            <i class="fa-solid fa-paw fa-beat" style="font-size: 36px;"></i>
                            <span>
                                <h3 style="margin: 0;">PetCare</h3>
                            </span>
                        </div>
                    </div>

                    <div class="row">                  
                        <nav class="navbar bg-body-tertiary">                                    
                            <a class="navbar-brand d-flex align-items-center gap-3" href="dashboard.jsp">
                                <i class="fa-solid fa-chart-line fa-lg"></i> 
                                Dashboard
                            </a>
                        </nav>
                        <nav class="navbar bg-body-tertiary">
                            <a class="navbar-brand d-flex align-items-center gap-3" href="ordermanagement?&action=view&status=tc">
                                <i class="fa-solid fa-truck-ramp-box fa-lg"></i>
                                <span>Đơn hàng</span>
                            </a>
                        </nav>
                        <nav class="navbar bg-body-tertiary active">
                            <a class="navbar-brand d-flex align-items-center gap-3" style="color: white; pointer-events: none;" href="#">
                                <i class="fa-solid fa-building-circle-check fa-lg"></i>
                                <span>Khách sạn thú cưng</span>
                            </a>
                        </nav>
                        <nav class="navbar bg-body-tertiary">
                            <a class="navbar-brand d-flex align-items-center gap-3" href="feedback.jsp">
                                <i class="fa-solid fa-comment fa-lg"></i>
                                <span>Phản hồi sản phẩm</span>
                            </a>
                        </nav>                 
                    </div>

                    <div class="row">
                        <hr style="margin: 10px 0;">
                    </div>

                    <div class="row">
                        <nav class="navbar bg-body-tertiary">                                   
                            <a class="navbar-brand d-flex align-items-center gap-3" href="profile.jsp">
                                <i class="fa-solid fa-address-book fa-lg"></i>   
                                <span>Hồ sơ</span>
                            </a>                          
                        </nav>
                        <nav class="navbar bg-body-tertiary">                                              
                            <a class="navbar-brand d-flex align-items-center gap-3" href="#">
                                <i class="fa-solid fa-right-from-bracket fa-lg"></i>
                                <span>Đăng xuất</span>
                            </a>
                        </nav>
                    </div>
                </div>


                <!-- MAIN -->
                <div class="col" id="main" style="padding: 0 40px;">
                    <div class="row pt-4">
                        <div class="d-flex align-items-center justify-content-between" style="padding: 0;">
                            <div>
                                <h1>Quản lí các yêu cầu đặt phòng</h1>
                            </div>
                            <div class="dropdown d-flex align-items-center gap-2">
                                <span>Username2025 (Employee)</span>
                                <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <img class="profile-img" src="https://img.freepik.com/foto-gratis/hombre-tiro-medio-peinado-afro_23-2150677136.jpg" alt="">
                                </button>
                                <ul class="dropdown-menu ps-2 pe-2 pt-2 pb-2">
                                    <div class="d-grid gap-2">
                                        <li class="profile-img-switch-store d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-store"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="#">Tới cửa hàng</a>
                                        </li>
                                        <hr style="margin: 0;">
                                        <li class="profile-img-info1 d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-user-pen"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="profile.jsp">Hồ sơ</a>
                                        </li>
                                        <li class="profile-img-info2 d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-right-from-bracket" style="font-size: 20px;"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="#">Đăng xuất</a>
                                        </li>
                                    </div>
                                </ul>
                            </div>                                                             
                        </div>
                    </div>

                    <div class="row mt-2">
                        <nav style="--bs-breadcrumb-divider: '>'; padding: 0 5px;" aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item" style="color: #6c757d;">Dashboard</li>
                                <li class="breadcrumb-item"><a href="#">Trang chủ</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Khách sạn thú cưng</li>
                            </ol>
                        </nav>
                    </div>   

                    <div class="d-flex gap-2 mb-3 p-2 rounded shadow-sm">
                        <button class="btn btn-outline-primary filter-btn" data-status="all" 
                                style="font-weight: bold; border-width: 2px;">
                            Tất cả
                        </button>
                        <button class="btn btn-outline-success filter-btn" data-status="Đã duyệt" 
                                style="font-weight: bold; border-width: 2px;">
                            Đã duyệt
                        </button>
                        <button class="btn btn-outline-warning filter-btn" data-status="Chờ xác nhận" 
                                style="font-weight: bold; border-width: 2px;">
                            Chờ xác nhận
                        </button>
                    </div>





                    <div class="main-dashboard-table">
                        <div class="d-flex justify-content-center align-items-center gap-3 main-dashboard-table-header"
                             style="background-color: #8C6E63; color: white; border-top-left-radius: 6px; border-top-right-radius: 6px;">                                                 
                            <i class="fa-solid fa-hotel fa-lg"></i>
                            <h4 class="mb-0">Pet Hotel Booking List</h4>
                        </div>
                        <div style="padding: 15px 15px 25px 15px;">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col" style="text-align: center; vertical-align: middle;">Tên khách hàng</th>
                                        <th scope="col" style="text-align: center; vertical-align: middle;">Tên thú cưng</th>
                                        <th scope="col" style="text-align: center; vertical-align: middle;">Tên phòng</th>
                                        <th scope="col" style="text-align: center; vertical-align: middle;">Check in</th>
                                        <th scope="col" style="text-align: center; vertical-align: middle;">Check out</th>
                                        <th scope="col" style="text-align: center; vertical-align: middle;">Tổng tiền (VND)</th>
                                        <th scope="col" style="text-align: center; vertical-align: middle;">Trạng thái</th>
                                        <th scope="col" style="text-align: center; vertical-align: middle;">Hành động</th>
                                    </tr>

                                </thead>
                                <tbody id="bookingTable">
                                    <%
                                        List<PetHotelBooking> bookings = PetHotelBookingDAO.getAllBookings();
                                        int index = 1;
                                        for (PetHotelBooking booking : bookings) {
                                    %>
                                    <tr class="booking-row" data-status="<%= booking.getStatus()%>">
                                        <td style="width: 140px; text-align: center; vertical-align: middle;"><%= booking.getCustomerName()%></td>
                                        <td style="width: 140px; text-align: center; vertical-align: middle;"><%= booking.getPetName()%></td>
                                        <td style="width: 140px; text-align: center; vertical-align: middle;"><%= booking.getRoomName()%></td>
                                        <td style="text-align: center; vertical-align: middle;"><%= booking.getCheckIn()%></td>
                                        <td style="text-align: center; vertical-align: middle;"><%= booking.getCheckOut()%></td>
                                        <%
                                            NumberFormat formatter = NumberFormat.getNumberInstance(new Locale("vi", "VN"));
                                        %>
                                        <td style="width: 140px; text-align: center; vertical-align: middle;"><%= formatter.format(booking.getTotalPrice())%></td>
                                        <td style="width: 135px; text-align: center; vertical-align: middle;">
                                            <span style="font-weight: bold; padding: 5px; color: <%= booking.getStatus().equals("Đã duyệt") ? "green" : "Orange"%>;">
                                                <%= booking.getStatus()%>
                                            </span>
                                        </td>
                                        <td style="width: 120px; text-align: center; vertical-align: middle;">
                                            <% if ("Chờ xác nhận".equals(booking.getStatus())) {%>
                                            <form action="pethotelbooking" method="post" style="display:inline;">
                                                <input type="hidden" name="bookingId" value="<%= booking.getBookingId()%>">
                                                <input type="hidden" name="filter" id="currentFilter" value="">
                                                <button type="submit" name="action" value="approve" class="btn btn-sm btn-primary"
                                                        onclick="setFilterBeforeSubmit(this)">
                                                    Duyệt
                                                </button>
                                            </form>

                                            <form action="pethotelbooking" method="post" style="display:inline;">
                                                <input type="hidden" name="bookingId" value="<%= booking.getBookingId()%>">
                                                <input type="hidden" name="filter" id="currentFilter" value="">
                                                <button type="submit" name="action" value="cancel" class="btn btn-sm btn-danger"
                                                        onclick="setFilterBeforeSubmit(this)">
                                                    Hủy
                                                </button>
                                            </form>
                                            <% } %>
                                        </td>

                                    </tr>
                                    <% }%>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>          
            </div>
        </div>
    </div>
    <%
        String filterParam = request.getParameter("filter");
        String currentFilter = (filterParam != null) ? URLDecoder.decode(filterParam, StandardCharsets.UTF_8.toString()) : "all";
    %>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // Lấy trạng thái filter từ URL (nếu có)
            const urlParams = new URLSearchParams(window.location.search);
            const currentFilter = urlParams.get("filter") || "all"; // Mặc định "all"

            // Gọi hàm lọc dữ liệu khi trang load
            filterBookings(currentFilter);

            // Đánh dấu nút đang chọn
            document.querySelectorAll(".filter-btn").forEach(button => {
                if (button.getAttribute("data-status") === currentFilter) {
                    button.classList.add("active");
                }
            });

            // Gán sự kiện lọc khi nhấn nút
            document.querySelectorAll(".filter-btn").forEach(button => {
                button.addEventListener("click", function () {
                    const filter = this.getAttribute("data-status");

                    // Cập nhật URL mà không reload trang
                    urlParams.set("filter", filter);
                    window.history.replaceState({}, "", "?" + urlParams.toString());

                    // Lọc danh sách theo trạng thái
                    filterBookings(filter);

                    // Xóa class "active" khỏi các nút và đặt lại
                    document.querySelectorAll(".filter-btn").forEach(btn => btn.classList.remove("active"));
                    this.classList.add("active");
                });
            });
        });

        // Hàm lọc danh sách theo trạng thái
        function filterBookings(filter) {
            document.querySelectorAll(".booking-row").forEach(row => {
                let status = row.getAttribute("data-status");
                row.style.display = (filter === "all" || status === filter) ? "" : "none";
            });
        }
    </script>
    <script>
        function setFilterBeforeSubmit(button) {
            const urlParams = new URLSearchParams(window.location.search);
            button.closest("form").querySelector("#currentFilter").value = urlParams.get("filter") || "all";
        }
    </script>

    <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
</body>
</html>
