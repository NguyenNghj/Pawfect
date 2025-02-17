<%-- 
    Document   : cart
    Created on : Feb 17, 2025, 8:14:23 PM
    Author     : Vu Quang Duc - CE181221
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="./css/cart.css">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="container-fluid">

            <!-- Breadcrumb -->
            <div class="row bread">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb m-0">
                        <li class="breadcrumb-item"><a href="#">Trang chủ</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Giỏ hàng</li>
                    </ol>
                </nav>
            </div>

            <!-- Cart Content -->
            <div class="row cart-content">
                <div class="col" style="margin: 0 250px;">
                    <h3 class="cart-title">GIỎ HÀNG (12)</h3>

                    <div class="container-items">
                        <!-- Item 1 -->
                        <c:forEach items="${cartItems}" var="c">
                            <div class="d-flex justify-content-between item-product">

                                <!-- Item Images -->
                                <div class="col-auto">
                                    <div class="item-images">
                                        <img src="https://bizweb.dktcdn.net/100/091/443/products/hieuunganh-com-5e9066b48c276.png?v=1586522083473" alt="">
                                    </div>
                                </div>

                                <!-- Item Information -->
                                <div class="col-9 d-grid align-items-center">      
                                    <!-- Info & Price of item -->
                                    <div class="row gap-1">
                                        <div class="item-info d-flex justify-content-between">
                                            <a href="#">${c.productName}</a>
                                            <span class="total-price-item">${c.getSubtotal()}</span>
                                        </div>
                                        <div>
                                            <span class="price-item">${c.productPrice}</span>
                                        </div>
                                    </div>

                                    <!-- Quantity & Remove Product -->
                                    <div class="row">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div class="d-flex">                            
                                                <a class="btn btn-secondary btn-minus" href="#">
                                                    <i class="fa-solid fa-minus"></i>
                                                </a>
                                                <input class="input-quantity" type="text" value="${c.quantity}" readonly>
                                                <a class="btn btn-secondary btn-plus" href="#">
                                                    <i class="fa-solid fa-plus"></i>                                                                   
                                                </a>
                                            </div>
                                            <div class="remove-product">
                                                <a class="btn" href="">
                                                    <i class="fa-solid fa-trash fa-xl"></i>
                                                </a>                      
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>

                    </div>

                    <!-- End Cart Information -->
                    <div class="total-info">
                        <!-- Total Price of Products -->
                        <div>
                            <b class="d-flex justify-content-between">
                                <span>Tổng tiền</span>
                                <span>${totalCart}</span>
                            </b>
                        </div>
                        <div class="mt-1">
                            <span>Phí vận chuyển và các phí khác sẽ được tính khi tiến hành thanh toán.</span>
                        </div>

                        <!-- Go to Checkout or Continue Shopping -->
                        <div class="d-flex flex-column align-items-center gap-3 end-cart">
                            <a class="btn btn-primary" href="#" role="button">THANH TOÁN</a>
                            <p class="m-0">
                                hoặc
                                <a class="link-offset-2 link-offset-3-hover link-underline link-underline-opacity-0 link-underline-opacity-75-hover" href="#">
                                    <span>Tiếp tục mua sắm</span>
                                    <i class="fa-solid fa-reply"></i>
                                </a>
                            </p>
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
