<%-- 
    Document   : dashboard
    Created on : Feb 11, 2025, 3:42:47 PM
    Author     : Vu Quang Duc - CE181221
--%>

<%@page import="model.Product"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="../../css/dashboard.css">
        <title>JSP Page</title>
        <style>

            body {
                background-color: #F3E5D8; /* Màu nền tổng thể */
            }

            #main {
                background-color: #F3E5D8; /* Màu nền cho phần Dashboard */
                padding: 0 40px;
            }

            .dropdown-menu {
                background-color: #d7ccc8; /* Màu nền cho menu dropdown */
                border-radius: 8px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            }

            .dropdown-item {
                color: #5d4037; /* Màu chữ */
            }

            .dropdown-item:hover {
                background-color: #efebe9; /* Hiệu ứng hover */
            }

            h1 {
                color: #5d4037; /* Màu chữ cho tiêu đề */
            }

            .profile-img {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                border: 2px solid #5d4037;
            }

            .chart-container {

                display: flex;
                justify-content: right; /* Căn giữa nội dung */
                gap: 30px; /* Khoảng cách giữa hai biểu đồ */
                align-items: flex-start; /* Căn đỉnh theo chiều dọc */
            }

            .container {

                width: 95%; /* Điều chỉnh chiều rộng để cả hai vừa trên một dòng */
                padding: 20px;
                background: #d7ccc8;
                border-radius: 10px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            }

            canvas {
                background: #efebe9;
                border-radius: 8px;
                padding: 10px;
                width: 100%; /* Đảm bảo chart co giãn hợp lý */
                height: 300px;
            }

            /* Đảm bảo hiển thị tốt trên màn hình nhỏ */
            @media (max-width: 768px) {
                .chart-container {
                    flex-direction: column;
                    align-items: center;
                }

                .container {
                    width: 80%;
                }
            }
            h4 {
                display: inline-block;
                padding: 12px 24px;
                border: 2px solid #5d4037; /* Viền nâu đậm */
                border-radius: 8px;
                background-color: #d7ccc8; /* Đồng bộ với nền chung */
                color: #212529; /* Màu chữ nâu */
                font-size: 22px;
                text-align: center;
                font-weight: bold;
                box-shadow: 2px 2px 6px rgba(0, 0, 0, 0.2);
            }

            /* Style cho bảng */
            table {
                width: 60%;
                border-collapse: collapse;
                margin-top: 15px;
                background-color: #5d4037; /* Màu nền đồng bộ */
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 2px 4px 8px rgba(0, 0, 0, 0.2);
            }

            table, th, td {
                border: 2px solid #795548; /* Viền màu nâu */
            }

            th, td {
                padding: 12px;
                text-align: center;
            }

            th {
                background-color: #d7ccc8; /* Màu nền tiêu đề */
                color: #5d4037; /* Chữ màu trắng */
            }

            tr:nth-child(even) {
                background-color: #f5f5f5; /* Màu nền xen kẽ */
            }

            tr:hover {
                background-color: #d7ccc8; /* Hiệu ứng hover */
            }

            img {
                border-radius: 8px;
                box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
            }

            /* Đảm bảo hiển thị tốt trên màn hình nhỏ */
            @media (max-width: 768px) {
                table {
                    font-size: 14px;
                }

                h4 {
                    font-size: 18px;
                    padding: 8px 16px;
                }
            }

        </style>

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
                        <nav class="navbar bg-body-tertiary justify-content-start gap-3 active">       
                            <i class="fa-solid fa-chart-line fa-lg" style="color: white;"></i>        
                            <a class="navbar-brand" style="color: white; pointer-events: none;" href="#">Dashboard</a>
                        </nav>
                        <nav class="navbar bg-body-tertiary">                        
                            <div class="accordion w-100" id="accordionExample1">                               
                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed gap-3" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
                                        <i class="fa-solid fa-users fa-lg"></i>Account
                                    </button>
                                </h2>
                                <div id="collapseOne" class="accordion-collapse collapse" data-bs-parent="#accordionExample1">
                                    <div class="accordion-body">
                                        <nav class="navbar bg-body-tertiary" style="padding-bottom: 0;">
                                            <div class="container-fluid">
                                                <a class="navbar-brand" href="accountAdmin.jsp">Admin</a>
                                            </div>
                                        </nav>
                                        <nav class="navbar bg-body-tertiary" style="padding-bottom: 0;">
                                            <div class="container-fluid">
                                                <a class="navbar-brand" href="staff">Employee</a>
                                            </div>
                                        </nav>
                                        <nav class="navbar bg-body-tertiary" style="padding-bottom: 0;">
                                            <div class="container-fluid">
                                                <a class="navbar-brand" href="customers">Customer</a>
                                            </div>
                                        </nav>
                                    </div>
                                </div>                                              
                            </div>                    
                        </nav>
                        <nav class="navbar bg-body-tertiary">                                           
                            <a class="navbar-brand d-flex align-items-center gap-3" href="product.jsp">
                                <i class="fa-solid fa-box fa-lg"></i>
                                <span>Product</span>
                            </a>                          
                        </nav>
                        <nav class="navbar bg-body-tertiary">                   
                            <a class="navbar-brand d-flex align-items-center gap-3" href="productCategory.jsp">
                                <i class="fa-solid fa-boxes-stacked fa-lg"></i>
                                <span>Product Category</span>
                            </a>
                        </nav>
                        <nav class="navbar bg-body-tertiary">                                            
                            <a class="navbar-brand d-flex align-items-center gap-3" href="petRoom.jsp">
                                <i class="fa-solid fa-hotel fa-lg"></i>  
                                <span>Pet Rooms</span>
                            </a>
                        </nav>
                        <!-- <nav class="navbar bg-body-tertiary">                        
                            <div class="accordion w-100" id="accordionExample2">                               
                                <h2 class="accordion-header">                           
                                    <button class="accordion-button collapsed gap-3" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                        <i class="fa-solid fa-comment fa-lg"></i>Feedback
                                    </button>
                                </h2>
                                <div id="collapseTwo" class="accordion-collapse collapse" data-bs-parent="#accordionExample2">
                                    <div class="accordion-body">                                  
                                        <nav class="navbar bg-body-tertiary" style="padding-bottom: 0;">
                                            <div class="container-fluid">
                                                <a class="navbar-brand" href="#">Product</a>
                                            </div>
                                        </nav>
                                        <nav class="navbar bg-body-tertiary" style="padding-bottom: 0;">
                                        <div class="container-fluid">
                                                <a class="navbar-brand" href="#">Kennel</a>
                                            </div>
                                        </nav>
                                    </div>
                                </div>                                              
                            </div>                    
                        </nav>                   -->
                    </div>

                    <div class="row">
                        <hr style="margin: 10px 0;">
                    </div>

                    <div class="row">
                        <nav class="navbar bg-body-tertiary">                                   
                            <a class="navbar-brand d-flex align-items-center gap-3" href="profile.jsp">
                                <i class="fa-solid fa-address-book fa-lg"></i>   
                                <span>Profile</span>
                            </a>                          
                        </nav>
                        <nav class="navbar bg-body-tertiary">                                              
                            <a class="navbar-brand d-flex align-items-center gap-3" href="#">
                                <i class="fa-solid fa-right-from-bracket fa-lg"></i>
                                <span>Logout</span>
                            </a>
                        </nav>
                    </div>
                </div>


                <!-- MAIN -->
                <div class="col" id="main" style="padding: 0 40px;">
                    <div class="row pt-4">
                        <div class="d-flex align-items-center justify-content-between" style="padding: 0;">
                            <div>
                                <h1>Dashboard</h1>
                            </div>
                            <div class="dropdown d-flex align-items-center gap-2">
                                <span>Username2025 (Admin)</span>
                                <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <img class="profile-img" src="https://img.freepik.com/foto-gratis/hombre-tiro-medio-peinado-afro_23-2150677136.jpg" alt="">
                                </button>
                                <ul class="dropdown-menu ps-2 pe-2 pt-2 pb-2">
                                    <div class="d-grid gap-2">
                                        <li class="profile-img-switch-employee d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-repeat"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="#">Switch to employee</a>
                                        </li>
                                        <li class="profile-img-switch-store d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-store"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="#">Go to store</a>
                                        </li>
                                        <hr style="margin: 0;">
                                        <li class="profile-img-info1 d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-user-pen"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="profile.jsp">Profile</a>
                                        </li>
                                        <li class="profile-img-info2 d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-right-from-bracket" style="font-size: 20px;"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="#">Logout</a>
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
                                <li class="breadcrumb-item active" aria-current="page">Home</li>
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
                        <div class="chart-container">
                            <div class="container">
                                <h2>Doanh Thu</h2>
                                <canvas id="revenue-chart"></canvas>
                            </div>

                            <div class="container">
                                <h2>Lượng Đơn Hàng</h2>
                                <canvas id="sale-revenue"></canvas>
                            </div>
                        </div>


                        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>

                        <h4>Top 5 Nhân Viên Bán Hàng</h4>
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
                                    <td>${staff.totalRevenue}</td>
                                </tr>
                            </c:forEach>
                        </table>

                        <!-- 🟢 Bảng top 5 sản phẩm -->
                        <h4>Top 5 Sản Phẩm Bán Chạy</h4>
                        <table border="1">
                            <tr>
                                <th>ID</th>
                                <th>Tên Sản Phẩm</th>
                                <th>Giá</th>
                                <th>Ảnh</th>
                                <th>Đã Bán</th>
                            </tr>
                            <%
                                List<Product> topProducts = (List<Product>) request.getAttribute("topProducts");
                                if (topProducts != null) {
                                    for (Product p : topProducts) {
                            %>
                            <tr>
                                <td><%= p.getProductId()%></td>
                                <td><%= p.getProductName()%></td>
                                <td><%= p.getProductPrice()%> VND</td>
                                <td><img src="<%= p.getProductImage()%>" width="50"></td>
                                <td><%= p.getStock()%></td> <!-- total_sold gán vào stock -->
                            </tr>
                            <%
                                }
                            } else {
                            %>
                            <tr><td colspan="5">Không có dữ liệu.</td></tr>
                            <% }%>
                        </table>

                        <!-- 🟢 Biểu đồ thống kê -->
                        <script>
                            var ctx1 = document.getElementById("sale-revenue").getContext("2d");
                            var myChart1 = new Chart(ctx1, {
                                type: "line",
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
                                        yAxes: [{
                                                ticks: {
                                                    beginAtZero: true
                                                }
                                            }]
                                    }
                                }
                            });

                            var ctx2 = document.getElementById("revenue-chart").getContext("2d");
                            var myChart2 = new Chart(ctx2, {
                                type: "line",
                                data: {
                                    labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
                                    datasets: [{
                                            label: "Doanh thu",
                                            data: [${requestScope.Monthh1}, ${requestScope.Monthh2}, ${requestScope.Monthh3}, ${requestScope.Monthh4}, ${requestScope.Monthh5},
                            ${requestScope.Monthh6}, ${requestScope.Monthh7}, ${requestScope.Monthh8}, ${requestScope.Monthh9}, ${requestScope.Monthh10},
                            ${requestScope.Monthh11}, ${requestScope.Monthh12}],
                                            backgroundColor: "rgba(255, 223, 128, 0.5)", // Màu vàng nhạt
                                            borderColor: "#FFD700", // Màu vàng gold
                                            borderWidth: 2,
                                            pointBackgroundColor: "#FFD700",
                                            pointBorderColor: "#FFCC00"
                                        }]
                                },
                                options: {
                                    responsive: true,
                                    maintainAspectRatio: false,
                                    scales: {
                                        yAxes: [{
                                                ticks: {
                                                    beginAtZero: true
                                                }
                                            }]
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
