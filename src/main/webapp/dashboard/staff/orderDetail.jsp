<%-- 
    Document   : orderDetail
    Created on : Feb 15, 2025, 9:28:21 PM
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
                                <span>Đơn hàng</span>
                            </a>
                        </nav>
                        <nav class="navbar bg-body-tertiary">
                            <a class="navbar-brand d-flex align-items-center gap-3" href="booking.jsp">
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
                                <h1>Chi tiết đơn hàng</h1>
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
                                <li class="breadcrumb-item"><a href="ordermanagement?&action=view&status=tc">Đơn hàng</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Chi tiết đơn hàng</li>
                            </ol>
                        </nav>
                    </div>   

                    <div class="row" style="margin-top: 30px; margin-bottom: 50px;">
                        <div class="main-dashboard-table">

                            <!-- Chi tiết đơn hàng -->
                            <div class="card">
                                <c:forEach items="${orders}" var="o">
                                    <div class="card-body">
                                        <header class="d-flex align-items-center mb-2">
                                            <a href="ordermanagement?&action=view&status=tc" class="text-secondary me-3">
                                                <i class="bi bi-arrow-left"></i>
                                            </a>
                                            <h1 class="h4 mb-0">Đơn hàng của ${o.customerName}</h1>
                                        </header>

                                        <!-- Đơn hàng có trạng thái "Chờ xác nhận" thì mới được huỷ đơn -->
                                        <div class="text-secondary mb-4">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <span>Đơn hàng: #${o.orderId + 2500000}</span>
                                                <button id="btn-cancel" class="btn btn-danger btn-sm" onclick="confirmCancel()"
                                                        data-product-id="${o.orderId + 2500000}" 
                                                        style="padding: 8px 18px;"
                                                        >
                                                    <span style="font-size: 16px;">Huỷ đơn</span>
                                                </button> 
                                            </div>                              
                                        </div>

                                        <!-- Package Tracking -->
                                        <div class="card">
                                            <div class="card-body">
                                                <div class="mb-4">
                                                    <div class="text-secondary small">Ngày đặt hàng</div>
                                                    <div class="h3">${o.orderDate}</div>
                                                </div>

                                                <div class="mb-4">
                                                    <div class="text-success fw-bold">
                                                        <c:choose>
                                                            <c:when test="${o.status == 'Chờ xác nhận'}"><div class="text-warning fw-bold">${o.status}</div></c:when>
                                                            <c:when test="${o.status == 'Chờ lấy hàng'}"><div class="text-secondary fw-bold">${o.status}</div></c:when>
                                                            <c:when test="${o.status == 'Chờ giao hàng'}"><div class="text-primary fw-bold">${o.status}</div></c:when>
                                                            <c:when test="${o.status == 'Hoàn thành'}"><div class="text-success fw-bold">${o.status}</div></c:when>
                                                            <c:otherwise><div class="text-danger fw-bold">${o.status}</div></c:otherwise> 
                                                        </c:choose>
                                                    </div>
                                                    <div>[Mô tả trạng thái]</div>
                                                </div>

                                                <div class="row mb-4">
                                                    <div class="col-md-6 mb-3 mb-md-0">
                                                        <h6>Thông tin nhận hàng</h6>
                                                        <div class="d-grid text-secondary">
                                                            <span>Họ tên người nhận: ${o.name}</span>
                                                            <span>Điện thoại: ${o.phone}</span>
                                                            <span>Địa chỉ: ${o.address}</span>
                                                        </div>
                                                        <!-- <address class="text-secondary">
                                                            Jane Doe<br>
                                                            1455 Market Street,<br>
                                                            San Francisco, CA 10977<br>
                                                            United States
                                                        </address> -->
                                                    </div>
                                                    <div class="col-md-6">
                                                        <h6 style="margin-bottom: 3px;">Phương thức giao hàng</h6>
                                                        <div class="text-secondary">
                                                            ${o.shippingMethodName}
                                                        </div>
                                                        <h6 style="margin: 10px 0 3px 0;">Phương thức thanh toán</h6>
                                                        <div class="text-secondary">
                                                            ${o.paymentMethodName}
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="mb-2">
                                                    <div class="fw-bold">Ghi chú giao hàng</div>
                                                    <textarea style="color: rgb(108 117 125);" class="form-control" id="exampleFormControlTextarea1" rows="3" readonly>${empty o.note ? 'Không có ghi chú.' : o.note}</textarea>
                                                </div>             
                                            </div>
                                        </div>

                                        <!-- Order Summary -->
                                        <div class="card mt-4">
                                            <div class="card-header">
                                                <h2 class="h5 mb-0">Giỏ hàng của ${o.customerName}</h2>
                                            </div>
                                            <div class="card-body" style="padding: 20px 35px;">
                                                <div class="order-item">
                                                    <c:forEach items="${orderitems}" var="oi">
                                                        <div class="mb-4">
                                                            <!-- <div class="text-secondary small mb-2">PACKAGE 1 OF 2</div> -->
                                                            <div class="d-flex">
                                                                <div class="position-relative">
                                                                    <img src="https://hebbkx1anhila5yf.public.blob.vercel-storage.com/order-conf-OihWsyJ9gZFXHQz5DOkVEQLUjY8Evl.png" alt="Product" class="rounded me-3" width="80" height="80">
                                                                    <span class="position-absolute top-0 translate-middle badge rounded-pill bg-danger" style="left: 75%;">
                                                                        ${oi.quantity}
                                                                        <span class="visually-hidden">unread messages</span>
                                                                    </span>
                                                                </div>
                                                                <div class="flex-grow-1">
                                                                    <div class="fw-bold">${oi.productName}</div>
                                                                    <div class="text-secondary">
                                                                        <f:formatNumber value="${oi.productPrice}" pattern="#,##0" />đ
                                                                    </div>
                                                                </div>
                                                                <div class="fw-bold">
                                                                    <f:formatNumber value="${oi.getSubtotal()}" pattern="#,##0" />đ
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:forEach>

                                                </div>

                                                <div class="border-top pt-3 mt-4">
                                                    <div class="d-flex justify-content-between mb-2">
                                                        <div class="text-secondary">Tạm tính</div>
                                                        <div>
                                                            <f:formatNumber value="${basicPrice}" pattern="#,##0" />đ
                                                        </div>
                                                    </div>
                                                    <!-- Phí Ship -->
                                                    <div class="d-flex justify-content-between mb-2">
                                                        <div class="text-secondary">Phí vận chuyển</div>
                                                        <div class="text-success">                                                           
                                                            <f:formatNumber value="${o.shippingMethodFee}" pattern="#,##0" />đ 
                                                        </div>
                                                    </div>
                                                    <!-- <div class="d-flex justify-content-between mb-2">
                                                        <div class="text-secondary">Taxes</div>
                                                        <div>$5.33</div>
                                                    </div> -->
                                                    <div class="d-flex justify-content-between align-items-center border-top pt-3 mt-3">
                                                        <h5 class="text-primary">TỔNG TIỀN</h5>
                                                        <div class="h3">
                                                            <f:formatNumber value="${o.totalAmount}" pattern="#,##0" />đ                                                          
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>                                              
                                    </div>
                                </c:forEach>

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
                                                    function confirmCancel() {
                                                        let productId = $('#btn-cancel').data('product-id');

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
                                                                Swal.fire({// Hiển thị thông báo "Đã huỷ!"
                                                                    title: 'Đã huỷ!',
                                                                    text: 'Đơn hàng của bạn đã được huỷ.',
                                                                    icon: 'success',
                                                                    timer: 2000, // Đặt thời gian hiển thị thông báo (2 giây)
                                                                    showConfirmButton: false // Ẩn nút "OK"
                                                                }).then(() => { // Sau khi thông báo hiển thị xong

                                                                });
                                                            }
                                                        });
                                                    }
        </script>
    </body>
</html>
