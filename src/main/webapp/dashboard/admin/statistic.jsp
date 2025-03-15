<%-- 
    Document   : product
    Created on : Feb 11, 2025, 3:54:05 PM
    Author     : Vu Quang Duc - CE181221
--%>

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
        <link rel="stylesheet" href="../../css/statistic.css">
        <link rel="stylesheet" href="../../css/dashboard.css">
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
                                <h1>Quản lý sản phẩm</h1>
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
                                            <a class="dropdown-item" style="padding: 0;" href="/dashboard/staff/statistics">Chuyển qua giao diện nhân viên</a>
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
                                <li class="breadcrumb-item active" aria-current="page">Quản lý sản phẩm</li>
                            </ol>
                        </nav>
                    </div>   

                    <div class="row" style="margin-top: 20px; margin-bottom: 50px;">
                        <div class="row text-center">
                            <div class="col-md-3">
                                <div class="card">
                                    <h6>TỔNG DOANH THU</h6>
                                    <h2>4,42,236</h2>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="card">
                                    <h6>DOANH THU SẢN PHẨM</h6>
                                    <h2>78,250</h2>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="card">
                                    <h6>DOANH THU KHÁCH SẠN THÚ CƯNG</h6>
                                    <h2>18,800</h2>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="card">
                                    <h6>Total Sales</h6>
                                    <h2>$35,078</h2>
                                </div>
                            </div>
                        </div>

                        <div class="row mt-4">
                            <div class="col-md-8">
                                <div class="d-flex justify-content-between align-items-center">
                                    <h6>BIỂU ĐỒ DOANH THU SẢN PHẨM VÀ KHÁCH SẠN THÚ CƯNG</h6>
                                    <div class="toggle-group">
                                        <button id="month-btn">Month</button>
                                        <button id="week-btn" class="active">Week</button>
                                    </div>
                                </div>
                                <div class="card">
                                    <div id="line-chart"></div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <h6>SỐ LƯỢNG ĐƠN HOÀN THÀNH</h6>
                                <div class="card">
                                    <h2>$7,650</h2>
                                    <div id="bar-chart"></div>
                                </div>
                            </div>
                        </div>


                        <div class="row mt-4">
                            <!-- Recent Orders Table -->
                            <div class="col-md-8">
                                <h5>TOP 5 SẢN PHẨM BÁN CHẠY</h5>
                                <div class="card p-3">
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>Tracking No</th>
                                                <th>Product Name</th>
                                                <th>Total Order</th>
                                                <th>Status</th>
                                                <th>Total Amount</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>84564564</td>
                                                <td>Camera Lens</td>
                                                <td>40</td>
                                                <td class="status-rejected">Rejected</td>
                                                <td>$40,570</td>
                                            </tr>
                                            <tr>
                                                <td>84564564</td>
                                                <td>Laptop</td>
                                                <td>300</td>
                                                <td class="status-pending">Pending</td>
                                                <td>$180,139</td>
                                            </tr>
                                            <tr>
                                                <td>84564564</td>
                                                <td>Mobile</td>
                                                <td>355</td>
                                                <td class="status-approved">Approved</td>
                                                <td>$180,139</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <!-- Analytics Report -->
                            <div class="col-md-4">
                                <h3>TOP NHÂN VIÊN</h3>
                                <div class="transaction-history">

                                    <div class="transaction-item">
                                        <div class="icon success">🎁</div>
                                        <div class="transaction-details">
                                            <h4>Order #002434</h4>
                                        </div>
                                        <div class="transaction-amount positive">+ $1,430</div>
                                    </div>

                                    <div class="transaction-item">
                                        <div class="icon warning">💬</div>
                                        <div class="transaction-details">
                                            <h4>Order #984947</h4>
                                        </div>
                                        <div class="transaction-amount negative">- $302</div>
                                    </div>

                                    <div class="transaction-item">
                                        <div class="icon danger">⚙️</div>
                                        <div class="transaction-details">
                                            <h4>Order #988784</h4>
                                        </div>
                                        <div class="transaction-amount negative">- $682</div>
                                    </div>

                                </div>
                            </div>            
                            
                            <div class="col-md-8">
                                <h5>TOP 5 LOẠI PHÒNG THÚ CƯNG</h5>
                                <div class="card p-3">
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>Tracking No</th>
                                                <th>Product Name</th>
                                                <th>Total Order</th>
                                                <th>Status</th>
                                                <th>Total Amount</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>84564564</td>
                                                <td>Camera Lens</td>
                                                <td>40</td>
                                                <td class="status-rejected">Rejected</td>
                                                <td>$40,570</td>
                                            </tr>
                                            <tr>
                                                <td>84564564</td>
                                                <td>Laptop</td>
                                                <td>300</td>
                                                <td class="status-pending">Pending</td>
                                                <td>$180,139</td>
                                            </tr>
                                            <tr>
                                                <td>84564564</td>
                                                <td>Mobile</td>
                                                <td>355</td>
                                                <td class="status-approved">Approved</td>
                                                <td>$180,139</td>
                                            </tr>
                                        </tbody>
                                    </table>
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
                        document.querySelectorAll('.toggle-group button').forEach(button => {
                            button.addEventListener('click', () => {
                                document.querySelectorAll('.toggle-group button').forEach(btn => btn.classList.remove('active'));
                                button.classList.add('active');
                            });
                        });


                        var options1 = {
                            chart: {type: 'area', height: 250},
                            series: [
                                {name: 'Page Views', data: [30, 40, 28, 50, 60, 120, 100]},
                                {name: 'Sessions', data: [10, 30, 40, 35, 45, 70, 60]}
                            ],
                            xaxis: {categories: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']},
                            colors: ['#007bff', '#17a2b8'],
                            fill: {type: 'gradient'}
                        };
                        new ApexCharts(document.querySelector("#line-chart"), options1).render();

                        var options2 = {
                            chart: {type: 'bar', height: 250},
                            series: [{name: 'Income', data: [60, 90, 70, 50, 65, 55, 75]}],
                            xaxis: {categories: ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su']},
                            colors: ['#17a2b8']
                        };
                        new ApexCharts(document.querySelector("#bar-chart"), options2).render();
        </script>

        <script>
            var ctx = document.getElementById('financeChart').getContext('2d');
            var financeChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: ['Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                    datasets: [{
                            label: 'Finance Growth',
                            data: [10, 30, 20, 40, 35, 15, 25],
                            borderColor: 'orange',
                            borderWidth: 2,
                            fill: false
                        }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {beginAtZero: true}
                    }
                }
            });
        </script>
    </body>
</html>

