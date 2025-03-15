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
        <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
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

                    <h1 class="text-center mb-4">Tổng Hợp Biểu Đồ Thống Kê</h1>


                    <div class="summary-container">
                        <!-- Thẻ doanh thu / sản phẩm -->
                        <div class="summary-group">
                            <div class="summary-card revenue-summary">
                                <p>Doanh Thu<br>
                                    <span class="revenue-value"><%= request.getAttribute("currentRevenue")%></span> 
                                    <span class="unit">VND</span>
                            </div>
                            <div class="summary-card sales-summary">
                                <p>Tổng sản phẩm<br>
                                    <span class="value">${requestScope.totalSalesThisMonth}</span> 
                                    <span class="unit">SP</span>
                            </div>
                            <div class="summary-card hotel-revenue-summary">
                                <p>PetHotel<br>
                                    <span class="value">${requestScope.totalPetHotelRevenue}</span> 
                                    <span class="unit">VND</span>
                            </div>
                            <!-- Cột thẻ doanh thu (30%) -->
                            <div class="col-md-4">
                                <div class="summary-card revenue-box2">
                                    <p>Doanh thu tháng này: 
                                        <span class="revenue-value"><%= request.getAttribute("currentRevenue")%></span> 
                                        <span class="unit">VNĐ</span>
                                    </p>
                                    <p>Doanh thu tháng trước: 
                                        <span class="revenue-value"><%= request.getAttribute("previousRevenue")%></span> 
                                        <span class="unit">VNĐ</span>
                                    </p>
                                    <p>Thay đổi doanh thu: 
                                        <span class="revenue-value"><%= request.getAttribute("revenueChangePercent")%></span>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>




                    <div class="revenue-chart-container2">
                        <div class="row mt-4">
                            <!-- Cột chứa cả hai biểu đồ -->
                            <div class="col-md-8">
                                <div class="row">
                                    <!-- Biểu đồ Doanh Thu (50%) -->
                                    <div class="col-md-6">
                                        <div class="card">
                                            <h6>Doanh Thu và Pethotel</h6>
                                            <div id="line-chart"></div> <!-- Biểu đồ doanh thu -->
                                        </div>
                                    </div>

                                    <!-- Biểu đồ Tổng Sản Phẩm (50%) -->
                                    <div class="col-md-6">
                                        <div class="card">
                                            <h6>Tổng Sản Phẩm</h6>
                                            <h2><span class="value">${requestScope.totalSalesThisMonth} SP</span></h2>
                                            <div id="bar-chart"></div> <!-- Biểu đồ cột -->
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-4">
                        <!-- Recent Orders Table -->
                        <div class="col-md-8">
                            <h5>Sản Phẩm Bán Chạy</h5>
                            <div class="card p-3">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Tên Sản Phẩm</th>
                                            <th>Giá</th>
                                            <th>Ảnh</th>
                                            <th>Đã Bán</th>
                                            <th>Tiến độ</th>  
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="p" items="${topProducts}">
                                            <tr>
                                                <td>${p.productId}</td>
                                                <td>${p.productName}</td>
                                                <td>${p.productPrice} VND</td>
                                                <td><img src="${p.productImage}" width="50"></td>
                                                <td>${p.stock}</td>
                                                <td>
                                                    <div class="progress-bar">
                                                        <div class="in-time" style="width: ${p.inTimePercentage}%"></div>
                                                        <div class="late" style="width: ${p.latePercentage}%"></div>
                                                        <div class="completed" style="width: ${p.completedPercentage}%"></div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    <tbody>
                                </table>
                            </div>
                        </div>
                        <div class="row mt-4">
                            <!-- Recent Orders Table -->
                            <div class="col-md-8">
                                <h5>Nhân Viên Bán Hàng </h5>
                                <div class="card p-3">
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Họ Và Tên</th>
                                                <th>Đã Bán</th>
                                                <th>Doanh Thu</th>
                                                <th>Trạng Thái</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="staff" items="${topStaffs}">
                                                <tr>
                                                    <td>${staff.staffId}</td>
                                                    <td>${staff.fullName}</td>
                                                    <td class="blue">${staff.totalSold}</td>
                                                    <td>${staff.totalRevenue} VND</td>
                                                    <td class="${staff.status == 'Hoàn thành' ? 'green' : 'red'}">${staff.status}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>


                            <!-- 🟢 Biểu đồ -->
                            <script>


                                document.querySelectorAll('.toggle-group button').forEach(button => {
                                    button.addEventListener('click', () => {
                                        document.querySelectorAll('.toggle-group button').forEach(btn => btn.classList.remove('active'));
                                        button.classList.add('active');
                                    });
                                });
                                // 🔹 Biểu đồ Doanh thu (bar chart)
                                // 🔹 Biểu đồ Page Views (area chart)
                                var options1 = {
                                    chart: {type: 'area', height: 250},
                                    series: [{
                                            name: 'doanh thu',
                                            data: [${requestScope.Monthh1}, ${requestScope.Monthh2}, ${requestScope.Monthh3}, ${requestScope.Monthh4}, ${requestScope.Monthh5},
                                ${requestScope.Monthh6}, ${requestScope.Monthh7}, ${requestScope.Monthh8}, ${requestScope.Monthh9}, ${requestScope.Month10},
                                ${requestScope.Month11}, ${requestScope.Month12}]},
                                        {name: 'pethotel',
                                            data: [${requestScope.Monthhh1}, ${requestScope.Monthhh2}, ${requestScope.Monthhh3}, ${requestScope.Monthhh4}, ${requestScope.Monthhh5},
                                ${requestScope.Monthhh6}, ${requestScope.Monthhh7}, ${requestScope.Monthhh8}, ${requestScope.Monthhh9}, ${requestScope.Monthhh10},
                                ${requestScope.Monthhh11}, ${requestScope.Monthhh12}]}
                                    ],
                                    xaxis: {categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']},
                                     colors: ['#007bff', '#17a2b8'],
          
                                    fill: {type: 'gradient'}
                                };
                                new ApexCharts(document.querySelector("#line-chart"), options1).render();


                                // 🔹 Biểu đồ Doanh thu Pet Hotel (line chart)
                                var options2 = {
                                    chart: {type: 'bar', height: 250},
                                    series: [{
                                            name: 'Sản phẩm',
                                            data: [${requestScope.Month1}, ${requestScope.Month2}, ${requestScope.Month3}, ${requestScope.Month4}, ${requestScope.Month5},
                                ${requestScope.Month6}, ${requestScope.Month7}, ${requestScope.Month8}, ${requestScope.Month9}, ${requestScope.Month10},
                                ${requestScope.Month11}, ${requestScope.Month12}]

                                        }],
                                    xaxis: {categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']},
                                    colors: ['#17a2b8']
                                };
                                new ApexCharts(document.querySelector("#bar-chart"), options2).render();



                            </script>

                            <!-- comment -->


                        </div>
                    </div>


                    <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
                    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>

                    </body>
                    </html>
