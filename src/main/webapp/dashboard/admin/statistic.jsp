<%-- 
    Document   : product
    Created on : Feb 11, 2025, 3:54:05 PM
    Author     : Vu Quang Duc - CE181221
--%>

<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Arrays"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;600;800&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">       
        <link rel="stylesheet" href="../../css/dashboard.css">
        <link rel="stylesheet" href="../../css/statistic.css">
        <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
        <title>JSP Page</title>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">

                <!-- SIDEBAR -->
                <jsp:include page="sidebar.jsp"/>
                <%
                    Cookie[] cookies = request.getCookies();
                    String staffRole = "";
                    String staffName = "";

                    if (cookies != null) {
                        for (Cookie cookie : cookies) {
                            String name = cookie.getName();
                            String value = cookie.getValue();

                            if ("staffRole".equals(name)) {
                                staffRole = value;
                            } else if ("staffName".equals(name)) {
                                staffName = value;
                            }

                            // Nếu đã lấy được cả hai giá trị thì thoát vòng lặp
                            if (!staffRole.isEmpty() && !staffName.isEmpty()) {
                                break;
                            }
                        }
                    }
                %>
                <!-- MAIN -->
                <div class="col" id="main" style="padding: 0 40px;">
                    <div class="row pt-4">
                        <div class="d-flex align-items-center justify-content-between" style="padding: 0;">
                            <div>
                                <h1>Thống kê</h1>
                            </div>

                            <div class="dropdown d-flex align-items-center gap-2">
                                <span style = "color: #D3A376; font-weight: bold;"><%= staffName%></span>
                                <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <img class="profile-img" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTf74k9hxcTCkLN2gyhCr9lzuzZax5iy0uDOA&s" alt="">
                                </button>
                                <ul class="dropdown-menu ps-2 pe-2 pt-2 pb-2">
                                    <div class="d-grid gap-2">
                                        <li class="profile-img-switch-employee d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-repeat"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="/dashboard/staff/viewcustomersforStaff">Chuyển qua giao diện nhân viên</a>
                                        </li>
                                    </div>
                                </ul>
                            </div>                                                            


                        </div>
                    </div>

                    <div class="row mt-2 bg-white p-3 d-flex align-items-center justify-content-center" 
                         style="border-radius: 20px; height: 60px;">
                        <nav style="--bs-breadcrumb-divider: '>'; padding: 0 5px;" aria-label="breadcrumb">
                            <ol class="breadcrumb mb-0" style ="font-weight: bold;">
                                <li class="breadcrumb-item">Bảng điều khiển</li>
                                <li class="breadcrumb-item">Quản trị viên</li>
                                <li class="breadcrumb-item active" aria-current="page">Thống kê</li>
                            </ol>
                        </nav>
                    </div>   

                    <div class="row" style="margin-top: 20px; margin-bottom: 50px;">
                        <div class="row text-center">
                            <div class="col-md-3">
                                <div class="card">
                                    <h6>TỔNG DOANH THU</h6>
                                    <h2><fmt:formatNumber value="${totalRevenue}" type="number" groupingUsed="true" />đ</h2>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="card">
                                    <h6>DOANH THU SẢN PHẨM</h6>
                                    <h2><fmt:formatNumber value="${totalOrder}" type="number" groupingUsed="true" />đ</h2>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="card">
                                    <h6>DOANH THU KHÁCH SẠN THÚ CƯNG</h6>
                                    <h2><fmt:formatNumber value="${totalBooking}" type="number" groupingUsed="true" />đ</h2>
                                </div>
                            </div>
                            <!--                            <div class="col-md-3">
                                                            <div class="card">
                                                                <h6>Total Sales</h6>
                                                                <h2>$35,078</h2>
                                                            </div>
                                                        </div>-->
                        </div>


                        <div class="row mt-4">
                            <div class="col-md-12">
                                <div class="d-flex justify-content-between align-items-center">
                                    <h5>BIỂU ĐỒ DOANH THU SẢN PHẨM VÀ KHÁCH SẠN THÚ CƯNG</h5>
                                    <div class="toggle-group">
                                        <button id="month-btn" class="<%= request.getParameter("month") != null ? "active" : ""%>">Month</button>
                                        <button id="week-btn" class="<%= request.getParameter("month") == null ? "active" : ""%>">Week</button>
                                    </div>
                                </div>
                                <div class="card">
                                    <div id="line-chart"></div>
                                </div>
                            </div>
                        </div>

                        <div class="row mt-4">
                            <div class="col-md-6">
                                <h5>SỐ LƯỢNG ĐƠN HOÀN THÀNH</h5>
                                <div class="card p-3">
                                    <h2 class="text-success">Tổng: ${totalCountOrder} đơn</h2>
                                    <div id="order-chart"></div>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <h5>SỐ LƯỢNG PHÒNG CHECK OUT</h5>
                                <div class="card p-3">
                                    <h2 class="text-danger">Tổng: ${totalCountBooking} phòng</h2>
                                    <div id="booking-chart"></div>
                                </div>
                            </div>
                        </div>

                        <div class="row mt-4" style ="display: flex">
                            <!-- Recent Orders Table -->
                            <div class = "col-md-8" style ="display: flex; flex-direction: column">
                                <div class="col">
                                    <h5>THỐNG KÊ SẢN PHẨM BÁN CHẠY</h5>
                                    <div class="card p-3">
                                        <table class="table table-striped">
                                            <thead>
                                                <tr>
                                                    <th>Id</th>
                                                    <th>Tên sản phẩm</th>
                                                    <th>Số lượng đã bán</th>
                                                    <th>Tổng tiền</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="product" items="${top5Product}">
                                                    <tr>
                                                        <td>${product.productId}</td>
                                                        <td>${product.productName}</td>
                                                        <td>${product.totalOrder}</td>
                                                        <td><fmt:formatNumber value="${product.totalAmount}" type="number" groupingUsed="true" />đ</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                        <c:if test="${empty top5Product}">                     
                                            <div>
                                                <h5 style="color: #856404; text-align: center; background-color: #fff3cd; padding: 12px; border-radius: 5px; margin-top: 10px;">
                                                    Không tìm thấy!
                                                </h5>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>

                                <div class="col mt-4">
                                    <h5>THỐNG KÊ PHÒNG THÚ CƯNG ƯA THÍCH</h5>
                                    <div class="card p-3">
                                        <table class="table table-striped">
                                            <thead>
                                                <tr>
                                                    <th>Id</th>
                                                    <th>Tên phòng</th>
                                                    <th>Số lần được đặt</th>
                                                    <th>Thành tiền</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="hotel" items="${topPetHotel}">
                                                    <tr>
                                                        <td>${hotel.roomId}</td>
                                                        <td>${hotel.roomName}</td>
                                                        <td>${hotel.timeBooking}</td>
                                                        <td><fmt:formatNumber value="${hotel.totalRenueve}" type="number" groupingUsed="true" />đ</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                        <c:if test="${empty topPetHotel}">                     
                                            <div>
                                                <h5 style="color: #856404; text-align: center; background-color: #fff3cd; padding: 12px; border-radius: 5px; margin-top: 10px;">
                                                    Không tìm thấy!
                                                </h5>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                            <!-- Analytics Report -->
                            <div class="col-md-4">
                                <h5>TOP NHÂN VIÊN</h5>
                                <div class="transaction-history">
                                    <c:choose>
                                        <c:when test="${not empty topStaff}">
                                            <c:forEach var="staff" items="${topStaff}">
                                                <div class="transaction-item">
                                                    <div class="icon success">
                                                        <img src="<%= request.getContextPath()%>/img/staff/${staff.image}" alt="${staff.fullName}" style="width: 50px; height: 50px; object-fit: cover;" />
                                                    </div>

                                                    <div class="transaction-details">
                                                        <h4>${staff.fullName}</h4>
                                                    </div>
                                                    <div style="display: flex; flex-direction: column">
                                                        <div class="transaction-amount total">Tổng: + <fmt:formatNumber value="${staff.totalRevenue}" type="currency" currencySymbol="đ"/></div>
                                                        <div class="transaction-amount order">Đơn hàng: + <fmt:formatNumber value="${staff.totalOrder}" type="currency" currencySymbol="đ"/></div>
                                                        <div class="transaction-amount booking">Phòng: + <fmt:formatNumber value="${staff.totalBooking}" type="currency" currencySymbol="đ"/></div>
                                                    </div>  
                                                </div>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <div>
                                                <h5 style="color: #856404; text-align: center; background-color: #fff3cd; padding: 12px; border-radius: 5px; margin-top: 10px;">
                                                    Không tìm thấy!
                                                </h5>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div> 
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

                </div>
            </div>
        </div>  
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>

        <script>
                        document.getElementById('month-btn').addEventListener('click', () => {
                            window.location.href = "statistics?month=true"; // Thay yourServletURL bằng URL servlet
                        });

                        document.getElementById('week-btn').addEventListener('click', () => {
                            window.location.href = "statistics"; // Không gửi tham số month => Lấy theo tuần
                        });
        </script>

        <%

            int[] countOrder = (int[]) request.getAttribute("countOrder");
            int[] countBooking = (int[]) request.getAttribute("countBooking");
            String[] days = {"T2", "T3", "T4", "T5", "T6", "T7", "CN"};
            boolean isMonth = request.getParameter("month") != null;
            double[] orders = (double[]) request.getAttribute(isMonth ? "orderss" : "orders");
            double[] bookings = (double[]) request.getAttribute(isMonth ? "bookingss" : "bookings");
            String[] labels = isMonth
                    ? new String[]{"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"}
                    : new String[]{"T2", "T3", "T4", "T5", "T6", "T7", "CN"};
        %>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                var isMonth = new URLSearchParams(window.location.search).get("month") === "true";

                // Định nghĩa nhãn cho ngày trong tuần và tháng
                var weekLabels = ["T2", "T3", "T4", "T5", "T6", "T7", "CN"];
                var monthLabels = ["T1", "T2", "T3", "T4", "T5", "T6", "T7", "T8", "T9", "T10", "T11", "T12"];

                // Chọn nhãn phù hợp
                var labels = isMonth ? monthLabels : weekLabels;

                var countOrder = <%= new Gson().toJson(request.getAttribute("countOrder") != null ? request.getAttribute("countOrder") : new int[labels.length])%>;
                var countBooking = <%= new Gson().toJson(request.getAttribute("countBooking") != null ? request.getAttribute("countBooking") : new int[labels.length])%>;

                console.log("Labels:", labels);
                console.log("Count Order:", countOrder);
                console.log("Count Booking:", countBooking);
                console.log("Is Month:", isMonth);

                var xAxisTitle = isMonth ? "Tháng" : "Ngày trong tuần";

                // Vẽ biểu đồ đơn hàng hoàn thành
                var orderOptions = {
                    chart: {type: 'bar', height: 250},
                    series: [{name: 'Số lượng đơn', data: countOrder}],
                    xaxis: {categories: labels, title: {text: xAxisTitle}},
                    colors: ['#28a745']
                };
                new ApexCharts(document.querySelector("#order-chart"), orderOptions).render();

                // Vẽ biểu đồ phòng check-out
                var bookingOptions = {
                    chart: {type: 'bar', height: 250},
                    series: [{name: 'Số lượng phòng', data: countBooking}],
                    xaxis: {categories: labels, title: {text: xAxisTitle}},
                    colors: ['#dc3545']
                };
                new ApexCharts(document.querySelector("#booking-chart"), bookingOptions).render();
            });
        </script>

        <!--        theo thứ trong ngày-->

        <!-- Chuẩn bị dữ liệu cho biểu đồ doanh thu -->
        <%
            // Dữ liệu cho biểu đồ theo tuần
            double[] ordersDataWeek = request.getAttribute("orders") != null ? (double[]) request.getAttribute("orders") : new double[]{0, 0, 0, 0, 0, 0, 0};
            double[] bookingsDataWeek = request.getAttribute("bookings") != null ? (double[]) request.getAttribute("bookings") : new double[]{0, 0, 0, 0, 0, 0, 0};

            // Dữ liệu cho biểu đồ theo tháng
            double[] ordersDataMonth = request.getAttribute("orderss") != null ? (double[]) request.getAttribute("orderss") : new double[]{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
            double[] bookingsDataMonth = request.getAttribute("bookingss") != null ? (double[]) request.getAttribute("bookingss") : new double[]{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

            // Sử dụng Gson để chuyển đổi mảng thành chuỗi JSON
            Gson gson = new Gson();
            String ordersDataWeekJson = gson.toJson(ordersDataWeek);
            String bookingsDataWeekJson = gson.toJson(bookingsDataWeek);
            String ordersDataMonthJson = gson.toJson(ordersDataMonth);
            String bookingsDataMonthJson = gson.toJson(bookingsDataMonth);
        %>

        <!-- Gộp logic vẽ biểu đồ theo tuần và tháng -->
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                var isMonth = new URLSearchParams(window.location.search).get("month") === "true";

                // Lấy dữ liệu từ JSP
                var ordersDataWeek = <%= ordersDataWeekJson%>;
                var bookingsDataWeek = <%= bookingsDataWeekJson%>;
                var ordersDataMonth = <%= ordersDataMonthJson%>;
                var bookingsDataMonth = <%= bookingsDataMonthJson%>;

                // Ghi log để kiểm tra dữ liệu
                console.log("Dữ liệu đơn hàng theo tuần:", ordersDataWeek);
                console.log("Dữ liệu đặt phòng theo tuần:", bookingsDataWeek);
                console.log("Dữ liệu đơn hàng theo tháng:", ordersDataMonth);
                console.log("Dữ liệu đặt phòng theo tháng:", bookingsDataMonth);

                // Chọn dữ liệu và nhãn dựa trên tham số 'month'
                var ordersData = isMonth ? ordersDataMonth : ordersDataWeek;
                var bookingsData = isMonth ? bookingsDataMonth : bookingsDataWeek;
                var categories = isMonth
                        ? ["Th1", "Th2", "Th3", "Th4", "Th5", "Th6", "Th7", "Th8", "Th9", "Th10", "Th11", "Th12"]
                        : ["T2", "T3", "T4", "T5", "T6", "T7", "CN"];

                // Kiểm tra xem dữ liệu có toàn bộ là 0 hay không
                var isOrdersEmpty = ordersData.every(val => val === 0);
                var isBookingsEmpty = bookingsData.every(val => val === 0);

                if (isOrdersEmpty && isBookingsEmpty) {
                    // Hiển thị thông báo nếu không có dữ liệu
                    document.querySelector("#line-chart").innerHTML = '<h5 style="text-align: center; color: #856404; background-color: #fff3cd; padding: 12px; border-radius: 5px;">Không có dữ liệu để hiển thị!</h5>';
                } else {
                    // Cấu hình biểu đồ
                    var options = {
                        chart: {
                            type: 'area',
                            height: 250
                        },
                        series: [
                            {name: 'Đơn hàng', data: ordersData},
                            {name: 'Đặt phòng', data: bookingsData}
                        ],
                        xaxis: {
                            categories: categories,
                            title: {text: isMonth ? "Tháng" : "Ngày trong tuần"}
                        },
                        colors: ['#007bff', '#17a2b8'],
                        fill: {type: 'gradient'}
                    };

                    // Vẽ biểu đồ
                    new ApexCharts(document.querySelector("#line-chart"), options).render();
                }
            });
        </script>

    </body>
</html>

