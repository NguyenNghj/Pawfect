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
        <div class="container">
            <div class="container-order-success">
                <div class="text-center">
                    <div class="success-icon">
                        <i class="fa-solid fa-check fa-2xl" style="color: #ffffff;"></i>
                    </div>
                    <h1 class="h3 mb-3">Cảm ơn bạn đã đặt hàng!</h1>
                    <p class="text-muted mb-1" style="font-size: 17px;">Chúng tôi đã nhận được đơn đặt hàng của bạn và sẽ xử lý trong vòng 2-3 ngày làm việc</p>              
                    <p class="text-muted" style="font-size: 17px;">Mã đơn hàng của bạn là #${orderId}</p>                
    
                    <div class="mt-4 d-flex justify-content-center gap-4">
                        <a href="#" class="btn btn-secondary" style="padding: 8px 24px;">Trở về trang chủ</a>
                        <a href="#" class="btn btn-outline-primary" style="padding: 8px 40px;">Chi tiết đơn hàng</a>                       
                    </div>                   
                </div>
            </div>
        </div>

        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
    </body>
</html>
