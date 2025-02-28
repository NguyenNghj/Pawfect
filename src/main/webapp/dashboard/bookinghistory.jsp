<%-- 
    Document   : bookingHistory
    Created on : Feb 16, 2025, 5:26:46 PM
    Author     : Vu Quang Duc - CE181221
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="./css/account.css">
    </head>
    <body>
        <div class="container py-4">
            <!-- Breadcrumb -->
            <nav aria-label="breadcrumb" class="mb-4">
                <ol class="breadcrumb p-3" style="background-color: white; border-radius: 5px;">
                    <li class="breadcrumb-item"><a href="#" class="text-decoration-none">Trang chủ</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Tài khoản</li>
                </ol>
            </nav>

            <div class="row g-4">
                <!-- Main Content -->
                <div class="col-md-8">
                    <!-- Top Cards -->
                    <div class="row g-4 mb-4">
                        <div class="col-md-4">
                            <div class="card h-100">
                                <div class="card-body d-flex align-items-center gap-3">
                                    <i class="bi bi-clipboard-check fs-4 text-primary"></i>
                                    <a href="#" class="text-decoration-none text-dark">Lịch sử đơn hàng</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card h-100">
                                <div class="card-body d-flex align-items-center gap-3">
                                    <i class="bi bi-calendar-date fs-4 text-primary"></i>
                                    <a href="#" class="text-decoration-none">Lịch sử đặt lịch</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card h-100">
                                <div class="card-body d-flex align-items-center gap-3">
                                    <i class="bi bi-person-circle fs-4"></i>
                                    <span>Xin chào, <span class="text-primary">[tên khách hàng]</span></span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Orders Section -->
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title mb-4">Lịch đặt của bạn</h5>

                            <!-- Order Tabs -->
                            <ul class="nav nav-tabs mb-4">
                                <li class="nav-item">
                                    <a class="nav-link active" href="#">Tất cả</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#">Chờ xác nhận</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#">Chờ nhận thú cưng</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#">Đang lưu trú</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#">Hoàn thành</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#">Đã huỷ</a>
                                </li>
                            </ul>

                            <!-- TH1: Khách hàng 'không' có đơn hàng -->
                            <!-- <div>
                                <h5 style="color: #ff7d0a; text-align: center;">
                                    Bạn không có đơn hàng nào!
                                </h5>
                            </div> -->

                            <!-- TH2: Khách hàng 'có' đơn hàng  -->
                            <!-- Order Item -->                           
                            <div class="card mb-3 hover-card">
                                <a href="#chitiet" style="text-decoration: none; color: inherit;">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col">
                                                <h6 class="mb-3">
                                                    [Mã booking] - <span class="text-warning">Chờ xác nhận</span>
                                                </h6>
                                                <p class="text-secondary mb-2">
                                                    Loại phòng: [Tên loại phòng]
                                                </p>
                                                <p class="text-secondary mb-2">
                                                    Thú cưng: [Tên thú cưng]
                                                </p>
                                                <p class="text-secondary">Ngày đặt lịch: 16/02/2025</p>
                                            </div>
                                            <div class="col-auto text-end">
                                                <h5 class="mb-3">789.000VND</h5>
    
                                                <!-- Đơn hàng có trạng thái "Chờ xác nhận" thì mới được huỷ đơn -->
                                                <button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#cancelModal" 
                                                        style="padding: 4px 12px;"
                                                        >
                                                    Huỷ dặt lịch
                                                </button>                                     
                                            </div>
                                        </div>
                                    </div>
                                </a>                              
                            </div>    

                            <!-- Modal huỷ đặt lịch -->
                            <div class="modal fade" id="cancelModal" tabindex="-1" aria-labelledby="cancelModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 class="modal-title fs-5" id="cancelModalLabel">Xác nhận huỷ đặt lịch</h1>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <p style="text-align: left;">Bạn muốn chắc chắn huỷ đặt lịch [Mã booking]</p>   
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                            <a href="#" class="btn btn-danger">Huỷ</a>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

                <!-- Sidebar -->
                <div class="col-md-4">
                    <div class="list-group account-action">
                        <a href="#" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="fa-regular fa-user fa-lg" style="color: #0062ad;"></i>
                            <span>Thông tin cá nhân</span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="fa-solid fa-paw fa-lg" style="color: #8C6E63;"></i>
                            <span>Thú cưng của tôi</span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="fa-solid fa-key fa-lg" style="color: #eabd1a;"></i>
                            <span>Đổi mật khẩu</span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="fa-solid fa-arrow-right-from-bracket fa-lg" style="color: #d01616;"></i>
                            <span>Đăng xuất</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
    </body>
</html>
