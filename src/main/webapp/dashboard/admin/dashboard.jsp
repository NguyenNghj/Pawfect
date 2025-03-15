<%-- 
    Document   : dashboard
    Created on : Feb 11, 2025, 3:42:47 PM
    Author     : Vu Quang Duc - CE181221
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page import="model.Product"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">       
        <title>Thống Kê</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../../css/dashboard.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
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
                                <li class="breadcrumb-item">Dashboard</li>
                                <li class="breadcrumb-item active" aria-current="page">Thống kê</li>
                            </ol>
                        </nav>
                    </div>  

                    <!-- comment    <div class="row mt-3">
                        <div class="d-flex gap-3" style="padding: 0;">
                            <div class="box-info d-flex align-items-center gap-4">
                                <i class="bi bi-calendar-check" style="font-size: 36px;"></i>
                                <span class="box-info-text">
                                    <h3>1070</h3>
                                    <p>New Order</p>
                                </span>
                            </div>
                            <div class="box-info d-flex align-items-center gap-4">
                                <i class="bi bi-calendar-check" style="font-size: 36px;"></i>
                                <span class="box-info-text">
                                    <h3>1070</h3>
                                    <p>New Order</p>
                                </span>
                            </div>
                            <div class="box-info d-flex align-items-center gap-4">
                                <i class="bi bi-calendar-check" style="font-size: 36px;"></i>
                                <span class="box-info-text">
                                    <h3>1070</h3>
                                    <p>New Order</p>
                                </span>
                            </div>
                            <div class="box-info d-flex align-items-center gap-4">
                                <i class="bi bi-calendar-check" style="font-size: 36px;"></i>
                                <span class="box-info-text">
                                    <h3>1070</h3>
                                    <p>New Order</p>
                                </span>
                            </div>
                        </div>
                    </div>-->

                    <!-- comment  <div class="row justify-content-between" style="margin-top: 60px; margin-bottom: 50px;">
                        <div class="col-7 main-dashboard-table">
                            <div class="d-flex justify-content-around align-items-center main-dashboard-table-header">
                                <h4 class="mb-0">Orders</h4>
                                <button type="button" class="btn btn-primary">View all</button>
                            </div>
                            <div style="padding: 15px 15px 25px 15px;">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">#</th>
                                            <th scope="col">First</th>
                                            <th scope="col">Last</th>
                                            <th scope="col">Handle</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th scope="row">1</th>
                                            <td>Mark</td>
                                            <td>Otto</td>
                                            <td>@mdo</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">2</th>
                                            <td>Jacob</td>
                                            <td>Thornton</td>
                                            <td>@fat</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">3</th>
                                            <td colspan="2">Larry the Bird</td>
                                            <td>@twitter</td>
                                        </tr>                             
                                    </tbody>
                                </table>
                            </div>
                        </div>--> 

                    <!-- <div class="col-4 pe-0 main-dashboard-table">
                            <div class="d-flex justify-content-around align-items-center main-dashboard-table-header">
                                <h4 class="mb-0">New customers</h4>
                                <button type="button" class="btn btn-primary">View all</button>
                            </div>
                            <div style="padding: 15px 15px 25px 15px;">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">#</th>
                                            <th scope="col">First</th>
                                            <th scope="col">Last</th>
                                            <th scope="col">Handle</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th scope="row">1</th>
                                            <td>Mark</td>
                                            <td>Otto</td>
                                            <td>@mdo</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">2</th>
                                            <td>Jacob</td>
                                            <td>Thornton</td>
                                            <td>@fat</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">3</th>
                                            <td colspan="2">Larry the Bird</td>
                                            <td>@twitter</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>-->

                    <div class="container">
                        <h1 class="text-center mb-4">Tổng Hợp Biểu Đồ Thống Kê</h1>

                        <div class="chart-container">
                            <div class="revenue-chart-container">
                                <h2>Doanh Thu</h2>
                                <canvas id="revenue-chart"></canvas>
                            </div>
                            <div class="revenue-box">
                                <h7>Doanh thu tháng này: <%= request.getAttribute("currentRevenue")%> VNĐ</h7>
                                <h7>Doanh thu tháng trước: <%= request.getAttribute("previousRevenue")%> VNĐ</h7>
                                <h7>Thay đổi doanh thu: <%= request.getAttribute("revenueChangePercent")%></h7>
                            </div>


                            <div class="chart-container">
                                <!-- Biểu đồ Lượng Đơn Hàng -->
                                <div class="chart-box">
                                    <h5>Lượng Đơn Hàng</h5>
                                    <canvas id="sale-revenue"></canvas>
                                </div>

                                <!-- Biểu đồ Doanh Thu Pet Hotel -->
                                <div class="chart-box">
                                    <h5>Doanh Thu Pet Hotel</h5>
                                    <canvas id="pet-hotel-revenue"></canvas>
                                </div>
                            </div>
                        </div>
                        <h5>Top 5 Sản Phẩm Bán Chạy</h5>
                        <table border="1">
                            <tr>
                                <th>ID</th>
                                <th>Tên Sản Phẩm</th>
                                <th>Giá</th>
                                <th>Ảnh</th>
                                <th>Đã Bán</th>
                            </tr>
                            <c:forEach var="p" items="${topProducts}">
                                <tr>
                                    <td>${p.productId}</td>
                                    <td>${p.productName}</td>
                                    <td>${p.productPrice} VND</td>
                                    <td><img src="${p.productImage}" width="50"></td>
                                    <td>${p.stock}</td> <!-- total_sold gán vào stock -->
                                </tr>
                            </c:forEach>
                        </table>

                        <!-- 🟢 Bảng top 5 nhân viên bán hàng -->
                        <h5>Top 5 Nhân Viên Bán Hàng</h5>
                        <table border="1">
                            <tr>
                                <th>ID</th>
                                <th>Họ và Tên</th>
                                <th>Tổng số sản phẩm đã bán</th>
                                <th>Tổng doanh thu</th>
                            </tr>
                            <c:forEach var="staff" items="${topStaffs}">
                                <tr>
                                    <td>${staff.staffId}</td>
                                    <td>${staff.fullName}</td>
                                    <td>${staff.totalSold}</td>
                                    <td>${staff.totalRevenue} VND</td>
                                </tr>
                            </c:forEach>
                        </table>

                        <!-- 🟢 Biểu đồ -->
                        <script>
                            var ctx1 = document.getElementById("sale-revenue").getContext("2d");
                            var myChart1 = new Chart(ctx1, {
                                type: "bar",
                                data: {
                                    labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
                                    datasets: [{
                                            label: "Sản phẩm",
                                            data: [${requestScope.Month1}, ${requestScope.Month2}, ${requestScope.Month3}, ${requestScope.Month4}, ${requestScope.Month5},
                            ${requestScope.Month6}, ${requestScope.Month7}, ${requestScope.Month8}, ${requestScope.Month9}, ${requestScope.Month10},
                            ${requestScope.Month11}, ${requestScope.Month12}],
                                            backgroundColor: "rgba(121, 85, 72, 0.5)",
                                            borderColor: "#5d4037",
                                            borderWidth: 2,
                                            pointBackgroundColor: "#3e2723",
                                            pointBorderColor: "#ffccbc"
                                        }]
                                },
                                options: {
                                    responsive: true,
                                    maintainAspectRatio: false,
                                    scales: {
                                        y: {
                                            beginAtZero: true
                                        }
                                    }
                                }
                            });

                            var ctx2 = document.getElementById("revenue-chart").getContext("2d");
                            var myChart2 = new Chart(ctx2, {
                                type: "line",
                                data: {
                                    labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
                                    datasets: [{
                                            label: "Doanh thu (VND)",
                                            data: [${requestScope.Monthh1}, ${requestScope.Monthh2}, ${requestScope.Monthh3}, ${requestScope.Monthh4}, ${requestScope.Monthh5},
                            ${requestScope.Monthh6}, ${requestScope.Monthh7}, ${requestScope.Monthh8}, ${requestScope.Monthh9}, ${requestScope.Monthh10},
                            ${requestScope.Monthh11}, ${requestScope.Monthh12}],
                                            backgroundColor: "rgba(255, 223, 128, 0.5)",
                                            borderColor: "#FFD700",
                                            borderWidth: 2,
                                            pointBackgroundColor: "#FFD700",
                                            pointBorderColor: "#FFCC00"
                                        }]
                                },
                                options: {
                                    responsive: true,
                                    maintainAspectRatio: false,
                                    scales: {
                                        y: {
                                            beginAtZero: true
                                        }
                                    }
                                }
                            });

                            // 🟢 Biểu đồ Pet Hotel Booking
                            var ctx3 = document.getElementById("pet-hotel-revenue").getContext("2d");
                            var myChart3 = new Chart(ctx3, {
                                type: "line",
                                data: {
                                    labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
                                    datasets: [{
                                            label: "Doanh thu Pet Hotel (VND)",
                                            data: [
                            ${requestScope.Monthhh1}, ${requestScope.Monthhh2}, ${requestScope.Monthhh3}, ${requestScope.Monthhh4}, ${requestScope.Monthhh5},
                            ${requestScope.Monthhh6}, ${requestScope.Monthhh7}, ${requestScope.Monthhh8}, ${requestScope.Monthhh9}, ${requestScope.Monthhh10},
                            ${requestScope.Monthhh11}, ${requestScope.Monthhh12}
                                            ],
                                            backgroundColor: "rgba(255, 165, 0, 0.5)", // Màu cam nhạt
                                            borderColor: "#FFA500", // Màu cam đậm
                                            borderWidth: 2,
                                            pointBackgroundColor: "#FF8C00", // Cam đậm hơn
                                            pointBorderColor: "#FF4500" // Cam đỏ
                                        }]
                                },
                                options: {
                                    responsive: true,
                                    maintainAspectRatio: false,
                                    scales: {
                                        y: {
                                            beginAtZero: true
                                        }
                                    }
                                }
                            });

                        </script>
                    </div>
                    <!-- comment -->
                </div>
            </div>
        </div>


        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>

    </body>
</html>
