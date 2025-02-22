<%-- 
    Document   : changepassword
    Created on : Feb 17, 2025, 2:55:46 PM
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

                        <!-- Lịch sử đơn hàng -->
                        <div class="col-md-4">
                            <div class="card h-100">
                                <div class="card-body d-flex align-items-center gap-3">
                                    <i class="bi bi-clipboard-check fs-4 text-primary"></i>
                                    <a href="order?&action=view&status=tc" class="text-decoration-none text-dark">
                                        Lịch sử đơn hàng
                                    </a>
                                </div>
                            </div>
                        </div>
                        <!-- Lịch sử đật lịch -->
                        <div class="col-md-4">
                            <div class="card h-100">
                                <div class="card-body d-flex align-items-center gap-3">
                                    <i class="bi bi-calendar-date fs-4 text-primary"></i>
                                    <a href="#" class="text-decoration-none text-dark">Lịch sử đặt lịch</a>
                                </div>
                            </div>
                        </div>
                        <!-- Xin chào khách hàng -->
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
                            <h5 class="card-title mb-2">Đổi mật khẩu</h5>
                            <p style="color: #4c4c4c;">Để đảm bảo tính bảo mật vui lòng đặt mật khẩu với ít nhất 8 kí tự</p>
                            <div class="d-grid gap-2 account-info">
                                <div class="mb-2 mt-2">
                                    <label for="formGroupExampleInput" class="form-label">Mật khẩu cũ <span style="color: red;">*</span></label>
                                    <input type="password" class="form-control" id="formGroupExampleInput" required>
                                  </div>
                                <div class="mb-2">
                                    <label for="formGroupExampleInput2" class="form-label">Mật khẩu mới <span style="color: red;">*</span></label>
                                    <input type="password" class="form-control" id="formGroupExampleInput2" required>
                                </div>
                                <div class="mb-2">
                                    <label for="formGroupExampleInput2" class="form-label">Xác nhận lại mật khẩu <span style="color: red;">*</span></label>
                                    <input type="password" class="form-control" id="formGroupExampleInput2" required>
                                </div>
                            </div>
                            <div class="mt-2">
                                <a href="#" class="btn btn-primary">Đặt lại mật khẩu</a>
                            </div>                         
                        </div>
                    </div>
                </div>
    
                <!-- Sidebar -->
                <div class="col-md-4">
                    <div class="list-group account-action">
                        
                        <!-- Thông tin cá nhân -->
                        <a href="#" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="fa-regular fa-user fa-lg" style="color: #0062ad;"></i>
                            <span>Thông tin cá nhân</span>
                        </a>
                        <!-- Thú cưng của tôi -->
                        <a href="#" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="fa-solid fa-paw fa-lg" style="color: #8C6E63;"></i>
                            <span>Thú cưng của tôi</span>
                        </a>
                        <!-- Đổi mật khẩu -->
                        <a href="#" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="fa-solid fa-key fa-lg" style="color: #eabd1a;"></i>
                            <span style="color: #1c49c2;"><b>Đổi mật khẩu</b></span>
                        </a>
                        <!-- Đăng xuất -->
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
