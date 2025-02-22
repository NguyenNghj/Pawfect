<%-- 
    Document   : order
    Created on : Feb 11, 2025, 4:53:57 PM
    Author     : Vu Quang Duc - CE181221
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="../../css/dashboard.css">
        <title>JSP Page</title>
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
                        <nav class="navbar bg-body-tertiary active">
                            <a class="navbar-brand d-flex align-items-center gap-3" href="#" style="color: white; pointer-events: none;">
                                <i class="fa-solid fa-truck-ramp-box fa-lg"></i>
                                <span>Orders</span>
                            </a>
                        </nav>
                        <nav class="navbar bg-body-tertiary">
                            <a class="navbar-brand d-flex align-items-center gap-3" href="booking.jsp">
                                <i class="fa-solid fa-building-circle-check fa-lg"></i>
                                <span>Pet Hotel Booking</span>
                            </a>
                        </nav>
                        <nav class="navbar bg-body-tertiary">
                            <a class="navbar-brand d-flex align-items-center gap-3" href="feedback.jsp">
                                <i class="fa-solid fa-comment fa-lg"></i>
                                <span>Product Feedbacks</span>
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
                                <h1>Quản lý đơn hàng</h1>
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
                                <li class="breadcrumb-item"><a href="#">Trang chủ</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Đơn hàng</li>
                            </ol>
                        </nav>
                    </div>   

                    <div class="row" style="margin-top: 60px; margin-bottom: 50px;">
                        <div class="main-dashboard-table">
                            <div class="d-flex justify-content-center align-items-center gap-3 main-dashboard-table-header"
                                 style="background-color: #007BFF; color: white; border-top-left-radius: 6px; border-top-right-radius: 6px;">                                                 
                                <i class="fa-solid fa-truck-ramp-box fa-lg"></i>
                                <h4 class="mb-0">Danh sách đơn hàng</h4>
                            </div>
                            <div style="padding: 15px 15px 25px 15px;">
                                <!-- Order Tabs -->
                                <ul class="nav nav-tabs mb-4">
                                    <li class="nav-item">
                                        <a class="nav-link <c:if test="${orderStatus == 'tc'}">active</c:if>" href="ordermanagement?&action=view&status=tc"">Tất cả</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link <c:if test="${orderStatus == 'cxn'}">active</c:if>" href="ordermanagement?&action=view&status=cxn">Chờ xác nhận</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link <c:if test="${orderStatus == 'clh'}">active</c:if>" href="ordermanagement?&action=view&status=clh">Chờ lấy hàng</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link <c:if test="${orderStatus == 'cgh'}">active</c:if>" href="ordermanagement?&action=view&status=cgh">Chờ giao hàng</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link <c:if test="${orderStatus == 'ht'}">active</c:if>" href="ordermanagement?&action=view&status=ht">Hoàn thành</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link <c:if test="${orderStatus == 'dh'}">active</c:if>" href="ordermanagement?&action=view&status=dh">Đã huỷ</a>
                                        </li>
                                    </ul>
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th scope="col" style="width: 9%;">Mã đơn</th>
                                                <th scope="col" style="width: 20%;">Họ tên</th>
                                                <th scope="col">Địa chỉ giao hàng</th>
                                                <th scope="col" style="width: 12%;">Tổng tiền</th>
                                                <th scope="col" style="width: 12%;">Trạng thái</th>
                                                <th scope="col" style="width: 19%;">Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${orders}" var="o">
                                            <tr>
                                                <!-- Mã đơn hàng -->
                                                <th scope="row">#${o.orderId + 2500000}</th>
                                                <!-- Họ tên đặt -->
                                                <td class="bodycolor-name-address-total">${o.customerName}</td>
                                                <!-- Địa chỉ giao hàng -->
                                                <td class="bodycolor-name-address-total">${o.address}</td>
                                                <!-- Tổng tiền đơn hàng -->
                                                <td class="bodycolor-name-address-total"><f:formatNumber value="${o.totalAmount}" pattern="#,##0" />đ</td>                                              
                                                <!-- Trạng thái đơn hàng -->
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${o.status == 'Chờ xác nhận'}"><span class="text-warning fw-bold">${o.status}</span></c:when>
                                                        <c:when test="${o.status == 'Chờ lấy hàng'}"><span class="text-secondary fw-bold">${o.status}</span></c:when>
                                                        <c:when test="${o.status == 'Chờ giao hàng'}"><span class="text-primary fw-bold">${o.status}</span></c:when>
                                                        <c:when test="${o.status == 'Hoàn thành'}"><span class="text-success fw-bold">${o.status}</span></c:when>
                                                        <c:otherwise><span class="text-danger fw-bold">${o.status}</span></c:otherwise> 
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <a href="ordermanagement?&action=viewdetail&orderId=${o.orderId}" class="btn btn-success">Xem chi tiết</a>
                                                    <!-- Được huỷ đơn nếu đơn hàng ở trạng thái "Chờ xác nhận" hoặc "Chờ lấy hàng" -->
                                                    <button type="button" class="btn btn-danger btn-cancel"
                                                            data-product-id="${o.orderId + 2500000}"
                                                            >
                                                        Huỷ đơn
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>

                                    </tbody>
                                </table>

                                <!-- Nếu 'không' có đơn hàng nào! -->
                                <c:if test="${empty orders}">                     
                                    <div>
                                        <h5 style="color: #856404; text-align: center; background-color: #fff3cd; padding: 12px; border-radius: 5px; margin-top: 10px;">
                                            Không có đơn hàng nào!
                                        </h5>
                                    </div>
                                </c:if>
                                
                            </div>
                        </div>
                    </div>          

                </div>

            </div>
        </div>

        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script>
            $(document).ready(function () { // Đảm bảo code chạy sau khi trang đã load xong
                $('.btn-cancel').click(function () { // Sử dụng class selector
                    let productId = $(this).data('product-id'); // $(this) là nút được click

                    Swal.fire({
                        title: 'Bạn chắc chắn muốn huỷ đơn #' + productId + '?',
                        text: 'Hành động này không thể hoàn tác!',
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Có, huỷ đơn!',
                        cancelButtonText: 'Không, quay lại'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            Swal.fire({
                                title: 'Đã huỷ!',
                                text: 'Đơn hàng của bạn đã được huỷ.',
                                icon: 'success',
                                timer: 2000,
                                showConfirmButton: false
                            }).then(() => {
//                                window.location.href = "order?&action=view&status=tc";
                            });
                        }
                    });
                });
            });
        </script>
    </body>
</html>
