<%-- 
    Document   : profile
    Created on : Feb 17, 2025, 2:54:05 PM
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
                            <h5 class="card-title mb-4">Thông tin tài khoản</h5>
                            <div class="d-grid gap-2 account-info">
                                <span><span class="account-info-title">Họ tên:</span> Nguyễn Văn Mười / <span class="account-info-title">Giới tính:</span> Nam</span>
                                <span><span class="account-info-title">Ngày sinh:</span> 15/02/2025</span>
                                <span><span class="account-info-title">Email:</span> vanmuoi@gmail.com</span>
                                <span><span class="account-info-title">Điện thoại:</span> 0123456789</span>
                                <span><span class="account-info-title">Địa chỉ:</span> 600 Nguyễn Văn Cừ, Ninh Kiều, Cần Thơ</span>
                            </div>
                            <div class="mt-3">
                                <button type="button" class="btn btn-success" 
                                    data-bs-toggle="modal" data-bs-target="#exampleModal"
                                >
                                    Chỉnh sửa thông tin
                                </button>

                                <!-- Modal -->
                                <div class="modal fade" id="exampleModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h1 class="modal-title fs-5" id="exampleModalLabel">Chỉnh sửa thông tin</h1>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <div class="d-flex justify-content-between">
                                                    <!-- Họ tên -->
                                                    <div class="mb-2 col-8">
                                                        <label for="formGroupExampleInput" class="form-label">Họ tên</label>
                                                        <input type="text" class="form-control" id="formGroupExampleInput">
                                                    </div>
                                                    <!-- Giới tính -->
                                                    <div class="mb-2 col-3">
                                                        <label for="formGroupExampleInput2" class="form-label">Giới tính</label>
                                                        <select class="form-select" aria-label="Default select example">
                                                            <option selected>Khác</option>
                                                            <option value="1">Nam</option>
                                                            <option value="2">Nữ</option>
                                                        </select>
                                                    </div>                                   
                                                </div>

                                                <!-- Ngày sinh -->
                                                <div class="mb-2">
                                                    <label for="formGroupExampleInput3" class="form-label">Ngày sinh</label>
                                                    <input type="date" class="form-control" id="formGroupExampleInput3">
                                                </div>
                                                <!-- Email -->
                                                <div class="mb-2">
                                                    <label for="formGroupExampleInput4" class="form-label">Email</label>
                                                    <input type="email" class="form-control" id="formGroupExampleInput4">
                                                </div>
                                                <!-- Điện thoại -->
                                                <div class="mb-2">
                                                    <label for="formGroupExampleInput5" class="form-label">Điện thoại</label>
                                                    <input type="tel" class="form-control" id="formGroupExampleInput5">
                                                </div>
                                                <!-- Địa chỉ -->
                                                <div class="mb-2">
                                                    <label for="formGroupExampleInput6" class="form-label">Địa chỉ</label>
                                                    <input type="tel" class="form-control" id="formGroupExampleInput6">
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                <button type="button" class="btn btn-primary">Lưu thay đổi</button>
                                            </div>
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
                        
                        <!-- Thông tin cá nhân -->
                        <a href="#" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="fa-regular fa-user fa-lg" style="color: #0062ad;"></i>
                            <span style="color: #1c49c2;"><b>Thông tin cá nhân</b></span>
                        </a>
                        <!-- Thú cưng của tôi -->
                        <a href="#" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="fa-solid fa-paw fa-lg" style="color: #8C6E63;"></i>
                            <span>Thú cưng của tôi</span>
                        </a>
                        <!-- Đổi mật khẩu -->
                        <a href="#" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="fa-solid fa-key fa-lg" style="color: #eabd1a;"></i>
                            <span>Đổi mật khẩu</span>
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
