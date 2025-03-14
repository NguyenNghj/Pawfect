<%-- 
    Document   : myPetHistory
    Created on : Feb 16, 2025, 7:39:55 PM
    Author     : Vu Quang Duc - CE181221
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@include file="./components/header.jsp" %>
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
            <div class="row mt-2 bg-white p-3 mb-4 d-flex align-items-center justify-content-center" 
                 style="border-radius: 20px; height: 60px;">
                <nav padding: 0 5px;" aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0" style ="font-weight: bold;">
                        <li class="breadcrumb-item"><a href="pawfect" class="text-decoration-none">Trang chủ</a></li>
                        <li class="breadcrumb-item"><a href="profile" class="text-decoration-none">Tài khoản</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Thú cưng của tôi</li>
                    </ol>
                </nav>
            </div>

            <div class="row g-4">
                <!-- Main Content -->
                <div class="col-md-8">

                    <!-- Orders Section -->
                    <div class="card">
                        <div class="card-body">
                            <div class="" style="display: flex; align-items: center; justify-content: space-between;">
                                <h5 class="card-title mb-4">Thú cưng của bạn</h5>
                                <div class="mb-4" style="margin-left: auto;">
                                    <a href="createpet" style="text-decoration: none;">
                                        <button style="background-color: #8C6E63; color: white; border: none; padding: 10px 20px; border-radius: 8px; font-size: 16px; cursor: pointer;">
                                            Thêm thú cưng
                                        </button>
                                    </a>
                                </div>
                            </div>

                            <!-- Order Tabs -->
                            <ul class="nav nav-tabs mb-4">
                                <li class="nav-item">
                                    <a class="nav-link <c:if test="${petType == ' '}">active</c:if>" href="viewpet?&pettype" style="font-weight: bold; border-width: 2px;">Tất cả</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link <c:if test="${petType == 'Chó'}">active</c:if>" href="viewpet?&pettype=Chó" style="font-weight: bold; border-width: 2px;">Chó</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link <c:if test="${petType == 'Mèo'}">active</c:if>" href="viewpet?&pettype=Mèo" style="font-weight: bold; border-width: 2px;">Mèo</a>
                                    </li>
                                </ul>

                                <div class="reviews-list">
                                <c:choose>
                                    <c:when test="${empty pets}">
                                        <div>
                                            <h5 style="color: #856404; text-align: center; background-color: #fff3cd; padding: 12px; border-radius: 5px;">
                                                Không tìm thấy!
                                            </h5>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach items="${pets}" var="pro" varStatus="loop">
                                            <div class="card mb-3 hover-card pet-item" data-type="${pro.petType}" style="<c:if test='${loop.index >= 4}'>display: none;</c:if>" >
                                                <a href="petviewdetail?petId=${pro.petId}" style="text-decoration: none; color: inherit;">
                                                    <div class="card-body">
                                                        <div class="row align-items-center">
                                                            <div class="col">
                                                                <div class="d-flex align-items-center gap-4">
                                                                    <img class="rounded" src="/img/pet/${pro.petImg != null ? pro.petImg : 'default.jpg'}" 
                                                                         alt="" width="90" height="90" style="object-fit: cover;">
                                                                    <div class="d-grid gap-1">
                                                                        <h6 style="font-size: 18px;">
                                                                            <c:choose>
                                                                                <c:when test="${pro.petStatus == 'booking'}">Đã đặt lịch</c:when>
                                                                                <c:otherwise>Chưa đặt lịch</c:otherwise>
                                                                            </c:choose>
                                                                        </h6>
                                                                        <span class="text-secondary">Tên: ${pro.petname}</span>
                                                                        <span class="text-secondary">Loại: ${pro.petType}</span>                                                       
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </a>                                                         
                                            </div>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>      
                            </div>

                            <div style="text-align: center">
                                <!-- Nút Xem thêm -->
                                <button id="loadMore" class="btn btn-success"
                                        style="--bs-btn-padding-y: .45rem; --bs-btn-padding-x: 1.7rem; --bs-btn-font-size: 1.1rem;">
                                    Xem thêm thú cưng
                                </button>
                            </div>

                        </div>
                    </div>
                </div>

                <!-- Sidebar -->
                <div class="col-md-4">
                    <div class="list-group account-action">
                        <!-- Thông tin cá nhân -->
                        <a href="profile" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="fa-regular fa-user fa-lg" style="color: #0062ad;"></i>
                            <span>Thông tin cá nhân</span>
                        </a>
                        <!-- Thú cưng của tôi -->
                        <a href="viewpet" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="fa-solid fa-paw fa-lg" style="color: #8C6E63;"></i>
                            <span style="color: #D3A376;"><b>Thú cưng của tôi</b></span>
                        </a>
                        <!-- Đổi mật khẩu -->
                        <c:if test="${customer.email != null and fn:contains(customer.email, '@')}">
                            <a href="changepassword" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                                <i class="fa-solid fa-key fa-lg" style="color: #eabd1a;"></i>
                                <span>Đổi mật khẩu</span>
                            </a>
                        </c:if>
                        <a href="order?&action=view&status=tc" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="bi bi-clipboard-check fs-4" style="color: #008080;"></i>
                            <span>Lịch sử đơn hàng</span>
                        </a>
                        <a href="bookinghistory" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="bi bi-calendar-date fs-4" style="color: #808000;"></i>
                            <span>Lịch sử đặt lịch</span>
                        </a>
                        <!-- Đăng xuất -->
                        <a href="logout" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="fa-solid fa-arrow-right-from-bracket fa-lg" style="color: #d01616;"></i>
                            <span>Đăng xuất</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <script>
            let initialPets = $(".pet-item").length; // Tổng số feedback có sẵn
            let itemsToShow = 4; // Số feedback hiển thị ban đầu

            $(".pet-item").slice(itemsToShow).hide(); // Ẩn feedback vượt quá số quy định

            // Ẩn nút "Xem thêm" nếu tổng feedback nhỏ hơn hoặc bằng itemsToShow
            if (initialPets <= itemsToShow) {
                $("#loadMore").hide();
            }


            $(document).ready(function () {
                $("#loadMore").click(function () {
                    let hiddenPets = $(".pet-item:hidden"); // Lấy feedback chưa hiển thị
                    let itemsToShow = hiddenPets.slice(0, 4); // Lấy số feedback muốn hiển thị tiếp theo

                    if (itemsToShow.length > 0) {
                        itemsToShow.fadeIn(); // Hiển thị chúng
                    }

                    if ($(".pet-item:hidden").length === 0) {
                        $("#loadMore").hide(); // Ẩn nút nếu không còn feedback nào
                    }
                });
            });
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
    </body>
</html>
