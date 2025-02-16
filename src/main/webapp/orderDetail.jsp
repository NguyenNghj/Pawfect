<%-- 
    Document   : orderDetail
    Created on : Feb 15, 2025, 10:28:37 PM
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
                                    <a href="#" class="text-decoration-none" style="color: black;">Lịch sử đơn hàng</a>
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
                            <header class="d-flex align-items-center mb-2">
                                <a href="#" class="text-secondary me-3">
                                    <i class="bi bi-arrow-left"></i>
                                </a>
                                <h1 class="h4 mb-0">Đơn hàng của bạn</h1>
                            </header>

                            <!-- Đơn hàng có trạng thái "Chờ xác nhận" thì mới được huỷ đơn -->
                            <div class="text-secondary mb-4">
                                <div class="d-flex justify-content-between align-items-center">
                                    <span>Đơn hàng#: [Mã đơn hàng]</span>
                                    <button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#cancelModal" 
                                            style="padding: 8px 18px;"
                                            >
                                        <span style="font-size: 16px;">Huỷ đơn</span>
                                    </button> 
                                </div>                              
                            </div>

                            <!-- Modal xác nhận huỷ đơn -->
                            <div class="modal fade" id="cancelModal" tabindex="-1" aria-labelledby="cancelModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 class="modal-title fs-5" id="cancelModalLabel">Xác nhận huỷ đơn</h1>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <p style="text-align: left;">Bạn muốn chắc chắn huỷ đơn hàng [Mã đơn hàng]</p>   
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                            <a href="#" class="btn btn-danger">Huỷ</a>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Package Tracking -->
                            <div class="card">
                                <div class="card-body">
                                    <div class="mb-4">
                                        <div class="text-secondary small">Ngày đặt hàng</div>
                                        <div class="h3">[Ngày đặt hàng]</div>
                                    </div>

                                    <div class="mb-4">
                                        <div class="text-success fw-bold">[Trạng thái đơn hàng]</div>
                                        <div>[Mô tả trạng thái]</div>
                                    </div>

                                    <div class="row mb-4">
                                        <div class="col-md-6 mb-3 mb-md-0">
                                            <h6>Thông tin nhận hàng</h6>
                                            <div class="d-grid text-secondary">
                                                <span>[Tên người nhận]</span>
                                                <span>[Điện thoại]</span>
                                                <span>[Địa chỉ]</span>
                                                <span></span>
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
                                                Giao hàng tiêu chuẩn
                                            </div>
                                            <h6 style="margin: 10px 0 3px 0;">Phương thức thanh toán</h6>
                                            <div class="text-secondary">
                                                Thanh toán khi nhận hàng (COD)
                                            </div>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <div class="fw-bold">Ghi chú giao hàng</div>
                                        <textarea class="form-control" id="exampleFormControlTextarea1" rows="3" readonly>[Chèn ghi chú hoặc không có]</textarea>
                                    </div>
                                    
                                    <div class="mb-1">
                                        <p><span style="color: chocolate;"><b>Nhân viên phụ trách:</b></span> [Tên nhân viên]</p>
                                    </div>
                                </div>
                            </div>

                            <!-- Order Summary -->
                            <div class="card mt-4">
                                <div class="card-header">
                                    <h2 class="h5 mb-0">Giỏ hàng của bạn</h2>
                                </div>
                                <div class="card-body">
                                    <div class="order-item" style="padding: 12px 0 0 0;">
                                        <div class="mb-4">
                                            <!-- <div class="text-secondary small mb-2">PACKAGE 1 OF 2</div> -->
                                            <div class="d-flex">
                                                <div class="position-relative">
                                                    <img src="https://hebbkx1anhila5yf.public.blob.vercel-storage.com/order-conf-OihWsyJ9gZFXHQz5DOkVEQLUjY8Evl.png" alt="Product" class="rounded me-3" width="80" height="80">
                                                    <span class="position-absolute top-0 translate-middle badge rounded-pill bg-danger" style="left: 75%;">
                                                        99
                                                        <span class="visually-hidden">unread messages</span>
                                                    </span>
                                                </div>
                                                <div class="flex-grow-1">
                                                    <div class="fw-bold">Retro Rainbows Organic Baby Boy Footless Sleep</div>
                                                    <div class="text-secondary">[Giá tiền]</div>
                                                </div>
                                                <div class="fw-bold">$16.99</div>
                                            </div>
                                        </div>

                                        <div class="mb-4">
                                            <!-- <div class="text-secondary small mb-2">PACKAGE 2 OF 2</div> -->
                                            <div class="d-flex">
                                                <div class="position-relative">
                                                    <img src="https://hebbkx1anhila5yf.public.blob.vercel-storage.com/order-conf-OihWsyJ9gZFXHQz5DOkVEQLUjY8Evl.png" alt="Product" class="rounded me-3" width="80" height="80">
                                                    <span class="position-absolute top-0 translate-middle badge rounded-pill bg-danger" style="left: 75%;">
                                                        99
                                                        <span class="visually-hidden">unread messages</span>
                                                    </span>
                                                </div>

                                                <div class="flex-grow-1">
                                                    <div class="fw-bold">Sunny Skies Organic Toddler Boy Tee & Short</div>
                                                    <div class="text-secondary">[Giá tiền]</div>
                                                </div>
                                                <div class="fw-bold">$16.99</div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="border-top pt-3">
                                        <div class="d-flex justify-content-between mb-2">
                                            <div class="text-secondary">Tạm tính</div>
                                            <div>$33.99</div>
                                        </div>
                                        <!-- Phí Ship -->
                                        <div class="d-flex justify-content-between mb-2">
                                            <div class="text-secondary">Phí vận chuyển</div>
                                            <div class="text-success">40.000VND</div>
                                        </div>
                                        <!-- <div class="d-flex justify-content-between mb-2">
                                            <div class="text-secondary">Taxes</div>
                                            <div>$5.33</div>
                                        </div> -->
                                        <div class="d-flex justify-content-between align-items-center border-top pt-3 mt-3">
                                            <h5 class="text-primary">TỔNG TIỀN</h5>
                                            <div class="h3">$37.29</div>
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
