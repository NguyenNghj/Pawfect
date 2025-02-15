<%-- 
    Document   : orderDetail
    Created on : Feb 15, 2025, 9:28:21 PM
    Author     : Vu Quang Duc - CE181221
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                                <h1>Order Management</h1>
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
                                <li class="breadcrumb-item"><a href="#">Home</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Orders</li>
                            </ol>
                        </nav>
                    </div>   

                    <div class="row" style="margin-top: 30px; margin-bottom: 50px;">
                        <div class="main-dashboard-table">

                            <!-- Chi tiết đơn hàng -->
                            <div class="card">
                                <div class="card-body">
                                    <header class="d-flex align-items-center mb-2">
                                        <a href="#" class="text-secondary me-3">
                                            <i class="bi bi-arrow-left"></i>
                                        </a>
                                        <h1 class="h4 mb-0">Đơn hàng của [tên khách hàng]</h1>
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
                    
                                            <div class="mb-2">
                                                <div class="fw-bold">Ghi chú giao hàng</div>
                                                <textarea class="form-control" id="exampleFormControlTextarea1" rows="3" readonly>[Chèn ghi chú hoặc không có]</textarea>
                                            </div>             
                                        </div>
                                    </div>
                            
                                    <!-- Order Summary -->
                                    <div class="card mt-4">
                                        <div class="card-header">
                                            <h2 class="h5 mb-0">Giỏ hàng của [tên khách hàng]</h2>
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
                    </div>          

                </div>

            </div>
        </div>

        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    </body>
</html>
