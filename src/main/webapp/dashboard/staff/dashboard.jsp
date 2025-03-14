<%-- 
    Document   : dashboard
    Created on : Feb 11, 2025, 5:02:13 PM
    Author     : Vu Quang Duc - CE181221
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;600;800&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="../../css/dashboard.css">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">

                <!-- SIDEBAR -->
                < <jsp:include page="sidebar.jsp"/>


                <!-- MAIN -->
                <div class="col" id="main" style="padding: 0 40px;">
                    <div class="row pt-4">
                        <div class="d-flex align-items-center justify-content-between" style="padding: 0;">
                            <div>

                                <h1>Dashboard</h1>
                            </div>
                            <div class="dropdown d-flex align-items-center gap-2">
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
                                <span><%= staffName%></span>
                                <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <img class="profile-img" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTf74k9hxcTCkLN2gyhCr9lzuzZax5iy0uDOA&s" alt="">
                                </button>
                                <ul class="dropdown-menu ps-2 pe-2 pt-2 pb-2">
                                    <div class="d-grid gap-2">                                       
                                        <% if ("Admin".equals(staffRole)) { %>
                                        <li class="profile-img-switch-employee d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-repeat"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="/dashboard/admin/dashboard.jsp">Đổi sang Admin</a>
                                        </li>
                                        <% }%>
                                        <li class="profile-img-switch-store d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-store"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="#">Tới cửa hàng</a>
                                        </li>
                                        <hr style="margin: 0;">
                                        <li class="profile-img-info1 d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-user-pen"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="staffprofile">Profile</a>
                                        </li>
                                        <li class="profile-img-info2 d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-right-from-bracket" style="font-size: 20px;"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="logoutstaff">Đăng xuất</a>
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
                                <li class="breadcrumb-item active" aria-current="page">Trang chủ</li>
                            </ol>
                        </nav>
                    </div>

                    <div class="row mt-3">
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
                    </div>

                    <div class="row justify-content-between" style="margin-top: 60px; margin-bottom: 50px;">
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
                        </div>
                        <nav class="navbar navbar-light d-flex gap-2" style="background-color: #EEEEEE;">
                            <a href="customers" class="btn btn-primary">Danh Sách Khách Hàng</a>
                        </nav>

                        <div class="col-4 pe-0 main-dashboard-table">
                            <div class="d-flex justify-content-around align-items-center main-dashboard-table-header">
                                <h4 class="mb-0">New feedback</h4>
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
                        </div>
                    </div>          

                </div>

            </div>
        </div>


        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    </body>
</html>
