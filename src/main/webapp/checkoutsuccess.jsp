<%-- 
    Document   : checkoutsuccess
    Created on : Feb 20, 2025, 8:49:54 PM
    Author     : Vu Quang Duc - CE181221
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="./css/checkoutsuccess.css"/>
        <title>JSP Page</title>
    </head>
    <body>
        <div class="container py-4">
            <div class="text-center">
                <div class="success-icon">
                    <i class="fa-solid fa-check fa-2xl" style="color: #ffffff;"></i>
                </div>
                <h1 class="h3 mb-3">Cảm ơn bạn đã đặt hàng!</h1>
                <p class="text-muted mb-1" style="font-size: 17px;">Chúng tôi đã nhận được đơn đặt hàng của bạn và sẽ xử lý trong vòng 2-3 ngày làm việc</p>
                <p class="text-muted" style="font-size: 17px;">Mã đơn hàng của bạn là #202500001</p>

                <div class="order-card">
                    <h2 class="order-title">Đơn hàng của bạn</h2>

                    <div class="container-items">
                        <c:forEach items="${cartItems}" var="c">
                            <!-- Product Item 1 -->
                            <div class="product-item position-relative">
                                <img src="https://hebbkx1anhila5yf.public.blob.vercel-storage.com/Checkout_success-Zc3SGleKOsKYkwyfEt9To7n2EByi2N.png" alt="ME-O Cat Food" class="product-image">
                                <span class="position-absolute translate-middle badge rounded-pill bg-danger" style="left: 11%; top: 18%;">
                                    ${c.quantity}
                                    <span class="visually-hidden">unread messages</span>
                                </span>
                                <div class="product-details">
                                    <div class="product-info">
                                        <div class="product-name-price">
                                            <h3 class="h6 mb-0">${c.productName}</h3>
                                            <p class="product-price mb-0">${c.productPrice}</p>
                                        </div>
                                        <p class="mb-0">${c.getSubtotal()}</p>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>

                    </div>

                    <!-- Shipping Fee & Total -->
                    <div class="d-flex justify-content-between mt-4">
                        <p class="mb-0">PHÍ VẬN CHUYỂN</p>
                        <p class="mb-0">${shippingCost}</p>
                    </div>
                    <div class="d-flex justify-content-between mt-2">
                        <p class="h5 mb-0">TỔNG TIỀN</p>
                        <p class="h5 mb-0 total-amount">${totalCartPrice}</p>
                    </div>
                </div>

                <a href="#" class="btn btn-outline-primary mt-4" style="padding: 8px 30px;">Trở về trang chủ</a>

            </div>
        </div>

        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
    </body>
</html>
