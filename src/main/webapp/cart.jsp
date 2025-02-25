<%-- 
    Document   : cart
    Created on : Feb 17, 2025, 8:14:23 PM
    Author     : Vu Quang Duc - CE181221
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="./components/header.jsp" %>
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
            <div class="row bread" style="background-color: white;">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb m-0">
                        <li class="breadcrumb-item"><a href="#">Trang chủ</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Giỏ hàng</li>
                    </ol>
                </nav>
            </div>

            <!-- Cart Content -->
            <div class="row cart-content">
                <div class="col">
                    <h3 class="cart-title">GIỎ HÀNG (<span id="totalQuantity">${totalQuantity}</span>)</h3>

                    <c:choose>
                        <c:when test="${empty cartItems}">
                            <!-- Nếu giỏ hàng trống -->
                            <div class="text-center" style="background-color: #fff3cd; padding: 10px; border-radius: 5px; border-radius: 5px; margin-bottom: 200px;">
                                <span style="font-size: 18px; color: #856404;">
                                    Không có sản phẩm nào. Quay lại cửa hàng để tiếp tục mua sắm.
                                </span>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div id="cart-main">
                                <div class="container-items">
                                    <!-- Item 1 -->
                                    <c:forEach items="${cartItems}" var="c">
                                        <div id="item-product-${c.productId}" class="d-flex justify-content-between item-product">

                                            <!-- Item Images -->
                                            <div class="col-auto">
                                                <div class="item-images">
                                                    <img src="${c.productImage}" alt="">
                                                </div>
                                            </div>

                                            <!-- Item Information -->
                                            <div class="col-9 d-grid align-items-center">      
                                                <!-- Info & Price of item -->
                                                <div class="row gap-1">
                                                    <div class="item-info d-flex justify-content-between">
                                                        <a href="#">${c.productName}</a>
                                                        <span id="subtotal-${c.productId}" class="total-price-item">
                                                            <f:formatNumber value="${c.getSubtotal()}" pattern="#,##0" />đ                                                       
                                                        </span>
                                                    </div>
                                                    <div>
                                                        <span class="price-item">
                                                            <f:formatNumber value="${c.productPrice}" pattern="#,##0" />đ     
                                                        </span>
                                                    </div>
                                                </div>

                                                <!-- Quantity & Remove Product -->
                                                <div class="row">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <div class="d-flex">                            
                                                            <a href="#" class="btn btn-secondary btn-minus" data-product-id="${c.productId}" data-customer-id="${c.customerId}" >
                                                                <i class="fa-solid fa-minus"></i>
                                                            </a>
                                                            <input id="quantity-${c.productId}" class="input-quantity" type="text" value="${c.quantity}" readonly>
                                                            <a href="#" class="btn btn-secondary btn-plus" data-product-id="${c.productId}" data-customer-id="${c.customerId}" >
                                                                <i class="fa-solid fa-plus"></i>                                                                   
                                                            </a>
                                                        </div>
                                                        <div class="remove-product">
                                                            <a class="btn btn-remove" href="#" data-product-id="${c.productId}" data-customer-id="${c.customerId}">
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
                                            <span id="total-price">
                                                <f:formatNumber value="${totalCartPrice}" pattern="#,##0" />đ                                          
                                            </span>
                                        </b>
                                    </div>
                                    <div class="mt-1">
                                        <span>Phí vận chuyển và các phí khác sẽ được tính khi tiến hành thanh toán.</span>
                                    </div>

                                    <!-- Go to Checkout or Continue Shopping -->
                                    <div class="d-flex flex-column align-items-center gap-3 end-cart">
                                        <a class="btn btn-primary" href="checkout?&action=view" role="button">THANH TOÁN</a>
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
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>


        </div>

        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script>
            function updateCart(action, productId, customerId, target) {
                $.ajax({
                    url: "cart", // URL của servlet
                    type: "POST",
                    data: {
                        action: action,
                        productId: productId,
                        customerId: customerId,
                        target: target
                    },
                    dataType: "json", // Dữ liệu trả về là JSON
                    success: function (response) {
                        if (response.status === "success") {
                            // Cap nhat tong tien gio hang
                            $("#total-price").text(formatNumber(response.totalCartPrice));

                            if (response.removed) {
                                // Xoa san pham khoi gio hang neu quantity = 0
                                $("#item-product-" + productId).remove();
                                
                                $("#totalQuantity").text(response.totalQuantity);
                                
                                $("#cart-count").text(response.totalQuantity);
                                
                                console.log("Đã xóa sản phẩm khỏi giỏ hàng!");

                                // Kiểm tra xem giỏ hàng có còn sản phẩm nào không
                                if ($(".item-product").length === 0) { // Nếu không còn sản phẩm nào                              
                                    $("#cart-main").html("<div class='text-center' style='background-color: #fff3cd; padding: 10px; border-radius: 5px; margin-bottom: 200px;'>" +
                                            "<span style='font-size: 18px; color: #856404;'>" +
                                            "Không có sản phẩm nào. Quay lại cửa hàng để tiếp tục mua sắm." +
                                            "</span>" +
                                            "</div>");
                                    console.log("Giỏ hàng trống!");
                                }

                            } else {
                                // Cap nhat so luong
                                $("#quantity-" + productId).val(response.quantity);

                                // Cap nhat tong tien san pham
                                $("#subtotal-" + productId).text(formatNumber(response.subtotal));
                                
                                $("#totalQuantity").text(response.totalQuantity);
                                
                                $("#cart-count").text(response.totalQuantity);
                            }

                            console.log("Cập nhật giỏ hàng thành công!");
                        } else {
                            console.error("Lỗi cập nhật giỏ hàng:", response.message);
                        }
                    },
                    error: function (error) {
                        console.error("Lỗi AJAX:", error);
                    }
                });
            }

            // Hàm định dạng số (quan trọng!)
            function formatNumber(number) {
                // Cách 1: Sử dụng toLocaleString (khuyến nghị cho hầu hết các trường hợp)
                const formattedNumber = new Intl.NumberFormat('vi-VN', {
                    style: 'currency',
                    currency: 'VND',
                }).format(number);
                
                return formattedNumber
                        .replace(/\s/g, '') // Loại bỏ khoảng trắng
                        .replace('₫', 'đ') // Thay thế ký hiệu "₫" bằng "đ"
                        .replace(/\./g, ','); // Loại bỏ dấu chấm
            }

            function removeFromCart(action, productId, customerId) {
                $.ajax({
                    url: "cart", // URL của servlet
                    type: "POST",
                    data: {
                        action: action,
                        productId: productId,
                        customerId: customerId,
                    },
                    dataType: "json", // Dữ liệu trả về là JSON
                    success: function (response) {
                        if (response.removed) {
                            // Xoa san pham khoi gio hang neu quantity = 0
                            $("#item-product-" + productId).remove();
                            
                            $("#totalQuantity").text(response.totalQuantity);

                            console.log("Xoa san pham khoi gio hang thanh cong!");

                            // Kiểm tra xem giỏ hàng có còn sản phẩm nào không
                            if ($(".item-product").length === 0) { // Nếu không còn sản phẩm nào                              
                                $("#cart-main").html("<div class='text-center' style='background-color: #fff3cd; padding: 10px; border-radius: 5px; margin-bottom: 200px;'>" +
                                        "<span style='font-size: 18px; color: #856404;'>" +
                                        "Không có sản phẩm nào. Quay lại cửa hàng để tiếp tục mua sắm." +
                                        "</span>" +
                                        "</div>");
                                console.log("Giỏ hàng trống!");
                            }
                        } else {
                            console.error("Loi xoa san pham:", response.message);
                        }
                    },
                    error: function (error) {
                        console.error("Lỗi AJAX:", error);
                    }
                });
            }

            // Gọi hàm updateCart khi người dùng tăng/giảm số lượng
            $(".btn-plus").click(function () {
                event.preventDefault(); // Ngăn chặn hành động mặc định
                var productId = $(this).data("product-id");
                var customerId = $(this).data("customer-id");
                console.log("productId:", productId);
                console.log("customerId:", customerId);
                updateCart("update", productId, customerId, "increase");
            });

            $(".btn-minus").click(function () {
                event.preventDefault(); // Ngăn chặn hành động mặc định
                var productId = $(this).data("product-id");
                var customerId = $(this).data("customer-id");
                console.log("productId:", productId);
                console.log("customerId:", customerId);
                updateCart("update", productId, customerId, "decrease");
            });

            $(".btn-remove").click(function () {
                event.preventDefault(); // Ngăn chặn hành động mặc định
                var productId = $(this).data("product-id");
                var customerId = $(this).data("customer-id");
                console.log("productId:", productId);
                console.log("customerId:", customerId);
                removeFromCart("remove", productId, customerId);
            });
        </script>
    </body>
    <%@include file="./components/footer.jsp" %>
</html>
