<%-- 
    Document   : checkout
    Created on : Feb 16, 2025, 11:44:06 AM
    Author     : Vu Quang Duc - CE181221
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                            <a href="pawfect">
                                <img src="./img/header/logo.png" alt="">
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
                                    <input type="email" class="form-control" id="email" placeholder="name@example.com" value="${emailCustomer}" readonly>
                                    <label for="email">Email</label>
                                </div>
                                <div class="form-floating mb-3">
                                    <input type="text" class="form-control" id="name" placeholder="name@example.com" required>
                                    <label for="name">Họ và tên</label>
                                </div>
                                <div class="form-floating mb-3">
                                    <input type="tel" class="form-control" id="phone" placeholder="name@example.com" required>
                                    <label for="phone">Số điện thoại</label>
                                </div>
                                <div class="form-floating mb-3">
                                    <input type="text" class="form-control" id="address" placeholder="name@example.com" required>
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
                                        <input class="form-check-input" type="radio" name="shipping-method" id="shipping-tietkem" value="30000" onclick="handleShippingChange('tietkiem')" checked>
                                        <div class="d-flex justify-content-between align-items-center gap-3">
                                            <label class="form-check-label" for="shipping-tietkem">
                                                Giao hàng tiết kiệm
                                            </label>
                                            <span>30.000đ</span>
                                        </div>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="shipping-method" id="shipping-hoatoc" value="45000" onclick="handleShippingChange('hoatoc')">
                                        <div class="d-flex justify-content-between align-items-center gap-3">
                                            <label class="form-check-label" for="shipping-hoatoc">
                                                Giao hàng hoả tốc
                                            </label>
                                            <span>45.000đ</span>
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
                                            <input class="form-check-input" type="radio" name="payment-method" id="payment-vnpay">
                                            <label class="form-check-label" for="payment-vnpay">
                                                Thanh toán qua VNPAY
                                            </label>
                                        </div>                      
                                        <img src="./img/vnpay-logo-vinadesign.jpg" alt="">        
                                    </div>
                                    <div class="form-check d-flex justify-content-between align-items-center">
                                        <div class="d-flex gap-3">
                                            <input class="form-check-input" type="radio" name="payment-method" id="payment-cash" checked>
                                            <label class="form-check-label" for="shipping-cash">
                                                Thanh toán tiền mặt (COD)
                                            </label>
                                        </div>                      
                                        <img src="./img/cash-payment-outline-color-icon-vector.jpg" alt="">        
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                    <!--                     Main Footer 
                                        <div class="row main-footer">
                                            <div class="d-flex justify-content-center gap-5">
                                                <a href="" data-bs-toggle="modal" data-bs-target="#hoantraModal">Chính sách hoàn trả</a>
                                                <a href="" data-bs-toggle="modal" data-bs-target="#baomatModal">Chính sách bảo mật</a>
                                                <a href="" data-bs-toggle="modal" data-bs-target="#dieukhoanModal">Điều khoản sử dụng</a>
                                            </div>
                                        </div>-->
                </div>

                <!-- Sidebar -->
                <div class="col" style="border-left: 1px solid #cecdcd;">
                    <div class="p-2">
                        <div class="title-sidebar">
                            <h5>Đơn hàng (${totalQuantity})</h5>
                        </div>
                        <!-- Item List -->
                        <div class="item-info d-grid gap-3">
                            <c:forEach items="${cartItems}" var="c">
                                <!-- Each Item -->
                                <div class="d-flex align-items-center">
                                    <div class="col-auto me-3 position-relative">
                                        <img src="./img/products/${c.productImage}" alt="">
                                        <span class="position-absolute top-0 translate-middle badge rounded-pill bg-danger" style="left: 90%;">
                                            ${c.quantity}
                                            <span class="visually-hidden">unread messages</span>
                                        </span>
                                    </div>
                                    <div class="col p-0">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <span style="max-width: 230px;">${c.productName}</span>
                                            <span>
                                                <b><f:formatNumber value="${c.getSubtotal()}" pattern="#,##0" />đ</b>                                          
                                            </span>
                                        </div>
                                        <div>
                                            <span>
                                                <b><f:formatNumber value="${c.productPrice}" pattern="#,##0" />đ</b>                                          
                                            </span>
                                        </div>
                                    </div>               
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Price & other Cost of Order -->
                        <div class="price-and-cost d-grid gap-2">
                            <div class="d-flex justify-content-between mb-2">
                                <div class="col-sm-9">
                                    <input id="voucher-code" type="search" class="form-control" style="height: 45px;" placeholder="Nhập mã giảm giá">                                   
                                </div>
                                <button id="voucher" class="btn btn-primary" type="button"
                                        style="--bs-btn-padding-y: .45rem; --bs-btn-padding-x: .9rem; --bs-btn-font-size: .95rem;">
                                    Áp dụng
                                </button>
                            </div>
                            <c:if test="${voucher != null}">
                                <div class="d-flex justify-content-between">
                                    <div class="promo-container">
                                        <div class="promo-title">
                                            <span class="gift-icon"><img src="https://img.icons8.com/stencil/32/ticket.png" alt="pnr-code"/></span>
                                            Mã Ưu Đãi
                                        </div>
                                        <p class="promo-description">
                                            Nhập mã <span class="promo-code">${voucher.code}</span> khi mua hàng lần đầu để được giảm giá <f:formatNumber value="${voucher.discountAmount}" pattern="#,##0" />đ cho đơn hàng từ <f:formatNumber value="${voucher.minOrderValue}" pattern="#,##0" />đ
                                        </p>
                                    </div>
                                </div>
                            </c:if>

                            <div class="d-flex justify-content-between">
                                <span>Tạm tính</span>
                                <span id="base-price" data-price="${totalCartPrice}">
                                    <f:formatNumber value="${totalCartPrice}" pattern="#,##0" />đ                                   
                                </span>
                            </div>
                            <div class="d-flex justify-content-between">
                                <span>Phí vận chuyển</span>
                                <span id="shipping-cost-value">40.000đ</span>
                            </div>   
                            <div class="d-flex justify-content-between">
                                <span>Khuyến mãi</span>
                                <span id="sale-cost">0đ</span>
                            </div> 
                        </div>

                        <!-- Total Price of Order -->
                        <div class="total-price">
                            <div class="d-flex justify-content-between">
                                <span>Tổng cộng</span>
                                <span id="total-price-value"></span>
                            </div>
                        </div>

                        <!-- Back to Cart or Submit Order -->
                        <div class="sidebar-footer">
                            <div class="d-flex justify-content-between align-items-center">                  
                                <a href="cart?&action=view">
                                    <i class="fa-solid fa-angle-left me-1"></i>
                                    <span>Quay về giỏ hàng</span>
                                </a>
                                <button id="submit-btn" type="button" class="btn btn-primary btn-order">
                                    ĐẶT HÀNG
                                </button>
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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
                                            let voucherId;
                                            $('#voucher').click(function () {

                                                const voucherCode = $('#voucher-code').val().trim();
                                                let saleCost = document.getElementById('sale-cost');
                                                // Lay gia tien tam tinh (chua bao gom phi van chuyen)
                                                let basePriceString = $('#base-price').data("price");
                                                // Chuyen basePriceString sang kieu so
                                                let basePrice = parseFloat(basePriceString);
                                                const totalPrice = parseFloat($('#total-price-value').text().replace(/[.,đ]/g, ''));
                                                const shippingCost = parseFloat($('#shipping-cost-value').text().replace(/[.,đ]/g, ''));

                                                console.log("Gui du lieu voucherCode: " + voucherCode);
                                                console.log("Gui du lieu saleCost: " + saleCost);

                                                // Kiểm tra voucher
                                                if (voucherCode === "") {
                                                    Swal.fire({
                                                        icon: "warning",
                                                        title: "Bạn đang để trống mã giảm giá!",
                                                        showConfirmButton: false,
                                                        width: 350,
                                                        timer: 2000
                                                    });
                                                    return;
                                                }

                                                // Gọi AJAX
                                                $.ajax({
                                                    url: 'checkout',
                                                    type: 'POST',
                                                    data: {
                                                        action: "voucher",
                                                        basePrice: basePrice,
                                                        voucherCode: voucherCode
                                                    },
                                                    dataType: "json",
                                                    success: function (response) {
                                                        if (response.status === "success") {
                                                            $("#voucher-code").val("");
                                                            voucherId = response.voucherId;

                                                            console.log("Áp mã khuyễn mãi thành công.");
                                                            Swal.fire({
                                                                icon: "success",
                                                                title: "Áp mã thành công.",
                                                                showConfirmButton: false,
                                                                width: 350,
                                                                timer: 2000
                                                            });
                                                            saleCost.textContent = "-" + formatCurrency(response.discountValue);

                                                            let shippingCost = document.querySelector('input[name="shipping-method"]:checked').value;
                                                            console.log("Chi phí vận chuyển:", shippingCost);

                                                            // Cập nhật tổng giá
                                                            updateTotalPrice(parseFloat(shippingCost));

                                                        } else if (response.status === "errorMinOrderValue") {
                                                            console.log("Không đủ điều kiện áp mã! Đơn hàng tối thiểu: " + formatCurrency(response.minOrderValue));

                                                            Swal.fire({
                                                                title: "Không đủ điều kiện sử dụng mã!",
                                                                text: "Đơn hàng tối thiểu " + formatCurrency(response.minOrderValue),
                                                                icon: "error"
                                                            });
                                                        } else if (response.status === "voucherIsUse") {
                                                            console.log("Voucher đã được sử dụng");

                                                            Swal.fire({
                                                                title: "Mã khuyến mãi đã được sử dụng!",
                                                                text: "Bạn đã sử dụng mã khuyến mãi này trước đó. Xin vui lòng thử lại mã khác!",
                                                                icon: "error"
                                                            });
                                                        } else if (response.status === "outOfDateVoucher") {
                                                            console.log("Voucher đã hết hạn");

                                                            Swal.fire({
                                                                title: "Mã khuyến mãi đã hết hạn!",
                                                                text: "Mã khuyến mãi này đã hết hạn. Xin vui lòng thử lại mã khác!",
                                                                icon: "error"
                                                            });
                                                        } else if (response.status === "isActiveVoucher") {
                                                            console.log("Mã khuyến mãi không còn hoạt động");

                                                            Swal.fire({
                                                                title: "Mã khuyến mãi không còn hoạt động!",
                                                                text: "Mã khuyến mãi này hiện tại không còn hoạt động nữa. Xin vui lòng thử lại mã khác!",
                                                                icon: "error"
                                                            });
                                                        } else {
                                                            console.log("Lỗi áp mã khuyến mãi!");
                                                            Swal.fire({
                                                                title: "Mã không hợp lệ!",
                                                                icon: "error",
                                                                width: 350,
                                                            });
                                                        }

                                                    },
                                                    error: function (xhr, status, error) {
                                                        // Xử lý lỗi
                                                        console.error("Lỗi khi gọi servlet:", status, error);
                                                        console.error("Response Text:", xhr.responseText);
                                                        alert("Có lỗi xảy ra. Vui lòng thử lại sau.");
                                                    }
                                                });
                                            });
        </script>

        <script>
            $('#submit-btn').click(function () { // Khi người dùng nhấp vào nút submit
                // 1. Lấy dữ liệu
                const email = $('#email').val().trim();
                const name = $('#name').val().trim();
                const phone = $('#phone').val().trim();
                const address = $('#address').val().trim();
                const note = $('#comment').val().trim();
                const totalPrice = parseFloat($('#total-price-value').text().replace(/[.,đ]/g, ''));
                const shippingCost = parseFloat($('#shipping-cost-value').text().replace(/[.,đ]/g, ''));
                const salePrice = parseFloat($('#sale-cost').text().replace(/[-,.,đ]/g, ''));
                if (salePrice === 0) {
                    voucherId = 0;
                }

                // Lay gia tien tam tinh (chua bao gom phi van chuyen)
                let basePriceString = $('#base-price').data("price");
                // Chuyen basePriceString sang kieu so
                let basePrice = parseFloat(basePriceString);

                // **Lấy giá trị của radio button được chọn
                const shippingMethod = $('input[name="shipping-method"]:checked').attr('id');
                const paymentMethod = $('input[name="payment-method"]:checked').attr('id');


                let ajaxUrl = (paymentMethod === "payment-vnpay") ? "vnpay" : "order";
                console.log("Lay gia tri ajaxUrl: " + ajaxUrl);

                console.log("Gui du lieu email: " + email);
                console.log("Gui du lieu name: " + name);
                console.log("Gui du lieu phone: " + phone);
                console.log("Gui du lieu address: " + address);
                console.log("Gui du lieu note: " + note);
                console.log("Gui du lieu totalPrice: " + totalPrice);
                console.log("Gui du lieu shippingCost: " + shippingCost);
                console.log("Gui du lieu shippingMethod: " + shippingMethod);
                console.log("Gui du lieu paymentMethod: " + paymentMethod);
                console.log("Gui du lieu salePrice: " + salePrice);


                // 3. Gọi AJAX
                $.ajax({
                    url: ajaxUrl,
                    type: 'POST',
                    data: {
                        action: "order",
                        name: name,
                        email: email,
                        address: address,
                        note: note,
                        phone: phone,
                        totalPrice: totalPrice,
                        basePrice: basePrice,
                        shippingCost: shippingCost,
                        shippingMethod: shippingMethod,
                        paymentMethod: paymentMethod,
                        salePrice: salePrice,
                        voucherId: voucherId
                    },
                    dataType: "json",
                    success: function (response) {
                        if (response.status === "success") {
                            console.log("Đã gửi dữ liệu thành công, đợi chuyển hướng từ server...");
                            // Neu khach hang chon thanh toan = vnpay
                            if (ajaxUrl === "vnpay") {
                                window.location.href = response.vnpayUrl;
                                return;
                            }
                            // Neu khach hang chon thanh toan = tien mat
                            window.location.href = "checkoutsuccess";
                        } else if (response.status === "error-data-email-empty") {
                            Swal.fire({
                                position: "top",
                                icon: "warning",
                                title: "Email không được để trống.",
                                showConfirmButton: false,
                                width: 350,
                                timer: 2500
                            });
                        } else if (response.status === "error-data-email-length") {
                            Swal.fire({
                                position: "top",
                                icon: "warning",
                                title: "Email không không vượt quá 255 kí tự.",
                                showConfirmButton: false,
                                width: 350,
                                timer: 2500
                            });
                        } else if (response.status === "error-data-email-valid") {
                            Swal.fire({
                                position: "top",
                                icon: "warning",
                                title: "Email không đúng định dạng.",
                                showConfirmButton: false,
                                width: 350,
                                timer: 2500
                            });
                        } else if (response.status === "error-data-name-empty") {
                            Swal.fire({
                                position: "top",
                                icon: "warning",
                                title: "Họ và tên không được để trống.",
                                showConfirmButton: false,
                                width: 350,
                                timer: 2500
                            });
                        } else if (response.status === "error-data-name-valid") {
                            Swal.fire({
                                position: "top",
                                icon: "warning",
                                title: "Họ và tên chỉ chứa ký tự chữ.",
                                showConfirmButton: false,
                                width: 350,
                                timer: 2500
                            });
                        } else if (response.status === "error-data-name-length") {
                            Swal.fire({
                                position: "top",
                                icon: "warning",
                                title: "Họ tên không vượt quá 100 kí tự.",
                                showConfirmButton: false,
                                width: 350,
                                timer: 2500
                            });
                        } else if (response.status === "error-data-phone-empty") {
                            Swal.fire({
                                position: "top",
                                icon: "warning",
                                title: "Số điện thoại không được để trống.",
                                showConfirmButton: false,
                                width: 350,
                                timer: 2500
                            });
                        } else if (response.status === "error-data-phone-valid") {
                            Swal.fire({
                                position: "top",
                                icon: "warning",
                                title: "Số điện thoại không đúng định dạng.",
                                showConfirmButton: false,
                                width: 350,
                                timer: 2500
                            });
                        } else if (response.status === "error-data-address-empty") {
                            Swal.fire({
                                position: "top",
                                icon: "warning",
                                title: "Địa chỉ không được để trống.",
                                showConfirmButton: false,
                                width: 350,
                                timer: 2500
                            });
                        } else if (response.status === "error-data-address-valid") {
                            Swal.fire({
                                position: "top",
                                icon: "warning",
                                title: "Địa chỉ không được chứa kí tự đặc biệt.",
                                showConfirmButton: false,
                                width: 350,
                                timer: 2500
                            });
                        } else if (response.status === "error-data-address-lenght") {
                            Swal.fire({
                                position: "top",
                                icon: "warning",
                                title: "Địa chỉ không vượt quá 255 kí tự.",
                                showConfirmButton: false,
                                width: 350,
                                timer: 2500
                            });
                        } else if (response.status === "error-data-address-number") {
                            Swal.fire({
                                position: "top",
                                icon: "warning",
                                title: "Địa chỉ không được là toàn số.",
                                showConfirmButton: false,
                                width: 350,
                                timer: 2500
                            });
                        } else if (response.status === "error-data-note-valid") {
                            Swal.fire({
                                position: "top",
                                icon: "warning",
                                title: "Ghi chú không vượt quá 500 kí tự.",
                                showConfirmButton: false,
                                width: 350,
                                timer: 2500
                            });
                        } else {
                            console.log("Lỗi đặt đơn hàng!");
                        }

                    },
                    error: function (xhr, status, error) {
                        // Xử lý lỗi
                        console.error("Lỗi khi gọi servlet:", status, error);
                        console.error("Response Text:", xhr.responseText);
                        alert("Có lỗi xảy ra. Vui lòng thử lại sau.");
                    }
                });
            });

            function isValidEmail(email) {
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                return emailRegex.test(email);
            }

            function isValidPhone(phone) {
                // Biểu thức chính quy kiểm tra số điện thoại (ví dụ: 10-11 số)
                const phoneRegex = /^\d{10,11}$/; // Hoặc biểu thức phức tạp hơn tùy theo yêu cầu
                return phoneRegex.test(phone);
            }

            // Gọi handleShippingChange() khi trang web được tải
            window.addEventListener('DOMContentLoaded', (event) => {
                handleShippingChange();
            });
        </script>

        <script>
            // Hàm này sẽ được gọi khi một radio button được chọn.
            // Hàm này sẽ cho biết thông tin về phương thức vận chuyển đã chọn cùng với giá tiền
            function handleShippingChange() {
                // Neu phuong thuc van chuyen nao duoc chon thi se lay id cua input tuong ung
                let selectedMethod = document.querySelector('input[name="shipping-method"]:checked').id;
                console.log("Đã chọn phương thức có ID:", selectedMethod);

                // Neu phuong thuc van chuyen nao duoc chon thi se lay value cua input tuong ung
                let shippingCost = document.querySelector('input[name="shipping-method"]:checked').value;
                console.log("Chi phí vận chuyển:", shippingCost);

                // Sử dụng shippingCost ở đây, ví dụ: cập nhật tổng giá
                updateTotalPrice(parseFloat(shippingCost)); // Chuyển thành số nguyên                             
            }


            function updateTotalPrice(shippingCost) {
                // Lay gia tien tam tinh (chua bao gom phi van chuyen)
                let basePriceString = $('#base-price').data("price");
                // Chuyen basePriceString sang kieu so
                let basePrice = parseFloat(basePriceString);
                console.log("Base price: " + basePrice);

                // Lấy tiền sale
                let salePrice = parseFloat($('#sale-cost').text().replace(/[-,.,đ]/g, ''));

                // Tinh tong gia tien cuoi cung
                let totalPrice = basePrice + shippingCost - salePrice;
                if (totalPrice < 0) {
                    totalPrice = 0;
                }
                console.log("Total price: " + totalPrice);
                console.log(``);

                // 'shippingCostElement' se tro toi thanh phan co id 'shipping-cost-value'
                let shippingCostElement = document.getElementById('shipping-cost-value');
                // Thay noi dung 'shippingCost' vao bien 'shippingCostElement' da tro toi id tuong ung
                shippingCostElement.textContent = formatCurrency(shippingCost);

                // 'totalPriceElement' se tro toi thanh phan co id 'total-price-value'
                let totalPriceElement = document.getElementById('total-price-value');
                // Thay noi dung 'totalPrice' vao bien 'totalPriceElement' da tro toi id tuong ung
                totalPriceElement.textContent = formatCurrency(totalPrice);

            }


            // Ham format lai gia tien
            function formatCurrency(amount) {
                return amount.toLocaleString('vi-VN', {
                    style: 'currency',
                    currency: 'VND'
                }).replace(/\s/g, '').replace('₫', 'đ').replace(/\./g, ',');
            }
        </script>
    </body>
</html>
