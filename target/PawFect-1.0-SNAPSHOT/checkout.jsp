<%-- 
    Document   : checkout
    Created on : Feb 16, 2025, 11:44:06 AM
    Author     : Vu Quang Duc - CE181221
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="./css/checkout.css">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="container">
            <div class="row">
                <!-- Main  -->
                <div class="col-8 main">
                    <!-- Logo -->
                    <div class="row">
                        <div class="header-logo">
                            <a href="#">
                                <img src="./images/logos/Logo.png" alt="">
                            </a>
                        </div>
                    </div>

                    <!-- Main Content -->
                    <div class="row main-content">
                        <!-- Delivery Information -->
                        <div class="col">
                            <div class="">
                                <h5 class="title-main">Thông tin nhận hàng</h5>
                            </div>

                            <!-- Fieldset -->
                            <div class="fieldset">
                                <div class="form-floating mb-3">
                                    <input type="email" class="form-control" id="email" placeholder="name@example.com">
                                    <label for="email">Email</label>
                                </div>
                                <div class="form-floating mb-3">
                                    <input type="text" class="form-control" id="name" placeholder="name@example.com">
                                    <label for="name">Họ và tên</label>
                                </div>
                                <div class="form-floating mb-3">
                                    <input type="tel" class="form-control" id="phone" placeholder="name@example.com">
                                    <label for="phone">Số điện thoại</label>
                                </div>
                                <div class="form-floating mb-3">
                                    <input type="text" class="form-control" id="address" placeholder="name@example.com">
                                    <label for="address">Địa chỉ</label>
                                </div>
                                <div class="form-floating">
                                    <textarea class="form-control" placeholder="Leave a comment here" id="comment" style="height: 100px"></textarea>
                                    <label for="comment">Ghi chú</label>
                                </div>
                            </div>
                        </div>

                        <!-- Shipping & Payment Methods -->
                        <div class="col">
                            <!-- Shipping Method -->
                            <div>
                                <div>
                                    <h5 class="title-main">Vận chuyển</h5>
                                </div>
                                <div class="shipping-method">
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="shipping-method" id="shipping-tietkem">
                                        <div class="d-flex justify-content-between align-items-center gap-3">
                                            <label class="form-check-label" for="shipping-tietkem">
                                                Giao hàng tiết kiệm
                                            </label>
                                            <span>40.000đ</span>
                                        </div>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="shipping-method" id="shipping-hoatoc">
                                        <div class="d-flex justify-content-between align-items-center gap-3">
                                            <label class="form-check-label" for="shipping-hoatoc">
                                                Giao hàng hoả tốc
                                            </label>
                                            <span>50.000đ</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Payment Method -->
                            <div>
                                <div>
                                    <h5 class="title-main" style="margin-top: 30px;">Thanh toán</h5>
                                </div>
                                <div class="payment-method">
                                    <div class="form-check d-flex justify-content-between align-items-center">
                                        <div class="d-flex gap-3">
                                            <input class="form-check-input" type="radio" name="shipping-method" id="shipping-tietkem">
                                            <label class="form-check-label" for="shipping-tietkem">
                                                Thanh toán qua VietQR
                                            </label>
                                        </div>                      
                                        <img src="./images/logos/vnpay-logo-vinadesign.jpg" alt="">        
                                    </div>
                                    <div class="form-check d-flex justify-content-between align-items-center">
                                        <div class="d-flex gap-3">
                                            <input class="form-check-input" type="radio" name="shipping-method" id="shipping-tietkem">
                                            <label class="form-check-label" for="shipping-tietkem">
                                                Thanh toán tiền mặt (COD)
                                            </label>
                                        </div>                      
                                        <img src="./images/icons/cash.png" alt="">        
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                    <!-- Main Footer -->
                    <div class="row main-footer">
                        <div class="d-flex justify-content-center gap-5">
                            <a href="" data-bs-toggle="modal" data-bs-target="#hoantraModal">Chính sách hoàn trả</a>
                            <a href="" data-bs-toggle="modal" data-bs-target="#baomatModal">Chính sách bảo mật</a>
                            <a href="" data-bs-toggle="modal" data-bs-target="#dieukhoanModal">Điều khoản sử dụng</a>
                        </div>
                    </div>
                </div>

                <!-- Sidebar -->
                <div class="col" style="border-left: 1px solid #cecdcd;">
                    <div class="p-2">
                        <div class="title-sidebar">
                            <h5>Đơn hàng (8)</h5>
                        </div>
                        <!-- Item List -->
                        <div class="item-info d-grid gap-3">
                            <!-- Each Item -->
                            <div class="d-flex align-items-center">
                                <div class="col-auto">
                                    <img src="https://bizweb.dktcdn.net/100/091/443/products/hieuunganh-com-5e9066b48c276.png?v=1586522083473" alt="">
                                </div>
                                <div class="col p-0">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span style="max-width: 280px;">Thức ăn hạt Whiskas Adult 1+ cho mèo</span>
                                        <span>65.000đ</span>
                                    </div>
                                    <div>
                                        <span>25.000đ</span>
                                    </div>
                                </div>               
                            </div>
                            <div class="d-flex align-items-center">
                                <div class="col-auto">
                                    <img src="https://bizweb.dktcdn.net/100/091/443/products/hieuunganh-com-5e9066b48c276.png?v=1586522083473" alt="">
                                </div>
                                <div class="col p-0">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span style="max-width: 280px;">Thức ăn hạt Whiskas Adult 1+ cho mèo</span>
                                        <span>65.000đ</span>
                                    </div>
                                    <div>
                                        <span>25.000đ</span>
                                    </div>
                                </div>               
                            </div>
                            <div class="d-flex align-items-center">
                                <div class="col-auto">
                                    <img src="https://bizweb.dktcdn.net/100/091/443/products/hieuunganh-com-5e9066b48c276.png?v=1586522083473" alt="">
                                </div>
                                <div class="col p-0">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span style="max-width: 280px;">Thức ăn hạt Whiskas Adult 1+ cho mèo</span>
                                        <span>65.000đ</span>
                                    </div>
                                    <div>
                                        <span>25.000đ</span>
                                    </div>
                                </div>               
                            </div>
                        </div>

                        <!-- Price & other Cost of Order -->
                        <div class="price-and-cost d-grid gap-2">
                            <div class="d-flex justify-content-between">
                                <span>Tạm tính</span>
                                <span>275.000đ</span>
                            </div>
                            <div class="d-flex justify-content-between">
                                <span>Phí vận chuyển</span>
                                <span>40.000đ</span>
                            </div>         
                        </div>

                        <!-- Total Price of Order -->
                        <div class="total-price">
                            <div class="d-flex justify-content-between">
                                <span>Tổng cộng</span>
                                <span>315.000đ</span>
                            </div>
                        </div>

                        <!-- Back to Cart or Submit Order -->
                        <div class="sidebar-footer">
                            <div class="d-flex justify-content-between align-items-center">                  
                                <a href="">
                                    <i class="fa-solid fa-angle-left me-1"></i>
                                    <span>Quay về giỏ hàng</span>
                                </a>
                                <button type="button" class="btn btn-primary btn-order">ĐẶT HÀNG</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <!-- Modal Chính sách Hoàn trả -->
        <div class="modal fade" id="hoantraModal" tabindex="-1" aria-labelledby="hoantraModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="hoantraModalLabel">Chính sách hoàn trả</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        ...
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Save changes</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal Chính sách Bảo mật -->
        <div class="modal fade" id="baomatModal" tabindex="-1" aria-labelledby="baomatModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="baomatModalLabel">Chính sách bảo mật</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        ...
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Save changes</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal Điều khoản sử dụng -->
        <div class="modal fade" id="dieukhoanModal" tabindex="-1" aria-labelledby="dieukhoanModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="dieukhoanModalLabel">Điều khoản sử dụng</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        ...
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Save changes</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
        <script>
            function handleRadioChange() {
                const radio1 = document.getElementById('flexRadioDefault1');
                const radio2 = document.getElementById('flexRadioDefault2');

                if (radio1.checked) {
                    // Chuyển hướng khi "Giao hàng tiết kiệm" được chọn
                    window.location.href = 'your-url-for-tiet-kiem'; // Thay 'your-url-for-tiet-kiem' bằng URL bạn muốn chuyển đến
                } else if (radio2.checked) {
                    // Chuyển hướng khi "Giao hàng hoả tốc" được chọn
                    window.location.href = 'your-url-for-hoatoc'; // Thay 'your-url-for-hoatoc' bằng URL bạn muốn chuyển đến
                }
            }
        </script>
    </body>
</html>
