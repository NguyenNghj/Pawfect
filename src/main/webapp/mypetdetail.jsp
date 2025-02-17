<%-- 
    Document   : mypetdetail
    Created on : Feb 17, 2025, 10:15:58 AM
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
                                    <a href="#" class="text-decoration-none text-dark">Lịch sử đặt lịch</a>
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
                                <h1 class="h4 mb-0">Thú cưng của bạn</h1>
                            </header>

                            <!-- Đơn hàng có trạng thái "Chờ xác nhận" thì mới được huỷ đơn -->
                            <div class="text-secondary mb-4">
                                <div class="d-flex justify-content-between align-items-center">
                                    <span>Mã thú cưng#: [Mã thú cưng]</span>
                                    <div>
                                        <button class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#editPetModal" 
                                            style="padding: 8px 18px;"
                                            >
                                            <span style="font-size: 16px;">Sửa thông tin</span>
                                        </button>
                                        <button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#removePetModal" 
                                            style="padding: 8px 18px;"
                                            >
                                            <span style="font-size: 16px;">Xoá thú cưng</span>
                                        </button>
                                    </div>                                    
                                </div>                              
                            </div>

                            <!-- Modal sửa thông tin thú cưng -->
                            <div class="modal fade" id="editPetModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="editPetModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 class="modal-title fs-5" id="editPetModalLabel">Sửa thông tin thú cưng</h1>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body edit-pet-detail">
                                            <div class="row mb-3">
                                                <!-- Tên thú cưng -->
                                                <div class="col-md-9">
                                                    <label for="formGroupExampleInput" class="form-label">Tên thú cưng</label>
                                                    <input type="text" class="form-control" id="formGroupExampleInput">
                                                </div>  
                                                <!-- Loài -->
                                                <div class="col-md">
                                                    <label for="formGroupExampleInput2" class="form-label">Loài</label>
                                                    <select class="form-select" aria-label="Default select example">
                                                        <option value="1">Chó</option>
                                                        <option value="2">Mèo</option>
                                                    </select>
                                                </div> 
                                            </div>
                                            <!-- Giống thú cưng -->
                                            <div class="mb-3">
                                                <label for="formGroupExampleInput3" class="form-label">Giống thú cưng</label>
                                                <input type="text" class="form-control" id="formGroupExampleInput3">
                                            </div>
                                            <!-- Giới tính -->
                                            <div class="mb-3">
                                                <label for="formGroupExampleInput4" class="form-label">Giới tính</label>
                                                <select class="form-select" aria-label="Default select example">
                                                    <option value="1">Đực</option>
                                                    <option value="2">Cái</option>
                                                </select>
                                            </div>
                                            <!-- Cân nặng (kg) -->
                                            <div class="mb-3">
                                                <label for="formGroupExampleInput5" class="form-label">Cân nặng (kg)</label>
                                                <input type="number" class="form-control" id="formGroupExampleInput5" step="0.01">
                                            </div>
                                            <!-- Sinh nhật -->
                                            <div class="mb-3">
                                                <label for="formGroupExampleInput6" class="form-label">Sinh nhật</label>
                                                <input type="date" class="form-control" id="formGroupExampleInput6">
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                            <a href="#" class="btn btn-success">Lưu</a>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Modal xác nhận xoá thú cưng -->
                            <div class="modal fade" id="removePetModal" tabindex="-1" aria-labelledby="removePetModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 class="modal-title fs-5" id="removePetModalLabel">Xác nhận xoá thú cưng</h1>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <p style="text-align: left;">Bạn muốn chắc chắn xoá [Tên thú cưng]</p>   
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                            <a href="#" class="btn btn-danger">Xoá</a>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Package Tracking -->
                            <div class="card">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-3 d-flex justify-content-center align-items-center">
                                            <img class="rounded pet-detail-img" src="https://1nedrop.com/wp-content/uploads/2024/10/meme-meo-bua-575fYTUZ.jpg" alt="" 
                                                 width="140" height="140" 
                                                 style="object-fit: contain; cursor: pointer;"
                                                 data-bs-toggle="modal" data-bs-target="#imageModal"
                                                 >

                                            <!-- Modal hiển thị ảnh lớn -->
                                            <div class="modal fade" id="imageModal" tabindex="-1" aria-labelledby="imageModalLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-dialog-centered">
                                                    <div class="modal-content">
                                                        <div class="modal-body text-center">
                                                            <img src="https://1nedrop.com/wp-content/uploads/2024/10/meme-meo-bua-575fYTUZ.jpg" class="img-fluid rounded">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>                              

                                        <div class="col-md-9 mb-3 mb-md-0">
                                            <div class="mb-4">                       
                                                <div class="text-success fw-bold">[Trạng thái thú cưng]</div>
                                                <div>[Mô tả trạng thái]</div>
                                            </div>

                                            <div class="row mb-4">
                                                <div class="col-md-6 mb-3 mb-md-0">
                                                    <h6>Thông tin thú cưng</h6>
                                                    <div class="d-grid text-secondary">
                                                        <span>Tên: [Tên thú cưng] [Mèo/Chó]</span>
                                                        <span>Giống: [Giống thú cưng]</span>
                                                        <span>Giới tính: [Đực / Cái]</span>
                                                        <span>Cân nặng (kg): [?Kg]</span>
                                                        <span>Sinh nhật: [Ngày - tháng - năm]</span>
                                                    </div>
                                                </div>
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
