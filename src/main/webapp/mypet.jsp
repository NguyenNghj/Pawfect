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
        <title>Danh sách thú cưng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="./css/account.css">
    </head>
    <body>
        <% if (request.getParameter("error") != null) { %>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            Swal.fire({
                icon: 'error',
                title: 'Oops...',
                text: 'Đã có lỗi xảy ra khi thêm thú cưng!',
                footer: ''
            });
        </script>
        <% } %>
        <% if (request.getParameter("erro") != null) { %>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            Swal.fire({
                icon: 'error',
                title: 'Lỗi!',
                text: 'Không thể tải thông tin thú cưng!',
                footer: ''
            });
        </script>
        <% } %>
        <% if (request.getParameter("err") != null) { %>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            Swal.fire({
                icon: 'error',
                title: 'Lỗi!',
                text: 'Không thể xóa thú cưng!',
                footer: ''
            });
        </script>
        <% } %>
        <%
            String errorMessage = request.getParameter("error");
            if (errorMessage != null) {
        %>
        <script>
            Swal.fire({
                icon: 'error',
                title: 'Lỗi!',
                text: '<%= errorMessage%>',
                confirmButtonText: 'OK'
            });
        </script>
        <% }%>

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
                                    <a class="nav-link <c:if test="${pettype == ''}">active</c:if>" href="viewpet?&pettype" style="font-weight: bold; border-width: 2px;">Tất cả</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link <c:if test="${pettype == 'Chó'}">active</c:if>" href="viewpet?&pettype=Chó" style="font-weight: bold; border-width: 2px;">Chó</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link <c:if test="${pettype == 'Mèo'}">active</c:if>" href="viewpet?&pettype=Mèo" style="font-weight: bold; border-width: 2px;">Mèo</a>
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
                        <a href="bookinghistory?status=tc" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
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

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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

        <svg id="wave" style="transform:rotate(0deg); transition: 0.3s" viewBox="0 0 1440 100" version="1.1" xmlns="http://www.w3.org/2000/svg"><defs><linearGradient id="sw-gradient-0" x1="0" x2="0" y1="1" y2="0"><stop stop-color="rgba(140, 110, 99, 1)" offset="0%"></stop><stop stop-color="rgba(140, 110, 99, 1)" offset="100%"></stop></linearGradient></defs><path style="transform:translate(0, 0px); opacity:1" fill="url(#sw-gradient-0)" d="M0,0L40,13.3C80,27,160,53,240,55C320,57,400,33,480,31.7C560,30,640,50,720,58.3C800,67,880,63,960,53.3C1040,43,1120,27,1200,25C1280,23,1360,37,1440,36.7C1520,37,1600,23,1680,16.7C1760,10,1840,10,1920,11.7C2000,13,2080,17,2160,15C2240,13,2320,7,2400,8.3C2480,10,2560,20,2640,20C2720,20,2800,10,2880,15C2960,20,3040,40,3120,48.3C3200,57,3280,53,3360,56.7C3440,60,3520,70,3600,73.3C3680,77,3760,73,3840,61.7C3920,50,4000,30,4080,28.3C4160,27,4240,43,4320,51.7C4400,60,4480,60,4560,56.7C4640,53,4720,47,4800,38.3C4880,30,4960,20,5040,23.3C5120,27,5200,43,5280,50C5360,57,5440,53,5520,51.7C5600,50,5680,50,5720,50L5760,50L5760,100L5720,100C5680,100,5600,100,5520,100C5440,100,5360,100,5280,100C5200,100,5120,100,5040,100C4960,100,4880,100,4800,100C4720,100,4640,100,4560,100C4480,100,4400,100,4320,100C4240,100,4160,100,4080,100C4000,100,3920,100,3840,100C3760,100,3680,100,3600,100C3520,100,3440,100,3360,100C3280,100,3200,100,3120,100C3040,100,2960,100,2880,100C2800,100,2720,100,2640,100C2560,100,2480,100,2400,100C2320,100,2240,100,2160,100C2080,100,2000,100,1920,100C1840,100,1760,100,1680,100C1600,100,1520,100,1440,100C1360,100,1280,100,1200,100C1120,100,1040,100,960,100C880,100,800,100,720,100C640,100,560,100,480,100C400,100,320,100,240,100C160,100,80,100,40,100L0,100Z"></path><defs><linearGradient id="sw-gradient-1" x1="0" x2="0" y1="1" y2="0"><stop stop-color="rgba(140, 110, 99, 1)" offset="0%"></stop><stop stop-color="rgba(140, 110, 99, 1)" offset="100%"></stop></linearGradient></defs><path style="transform:translate(0, 50px); opacity:0.9" fill="url(#sw-gradient-1)" d="M0,20L40,25C80,30,160,40,240,45C320,50,400,50,480,41.7C560,33,640,17,720,20C800,23,880,47,960,50C1040,53,1120,37,1200,28.3C1280,20,1360,20,1440,16.7C1520,13,1600,7,1680,18.3C1760,30,1840,60,1920,70C2000,80,2080,70,2160,58.3C2240,47,2320,33,2400,31.7C2480,30,2560,40,2640,41.7C2720,43,2800,37,2880,40C2960,43,3040,57,3120,66.7C3200,77,3280,83,3360,81.7C3440,80,3520,70,3600,68.3C3680,67,3760,73,3840,68.3C3920,63,4000,47,4080,35C4160,23,4240,17,4320,15C4400,13,4480,17,4560,28.3C4640,40,4720,60,4800,58.3C4880,57,4960,33,5040,33.3C5120,33,5200,57,5280,68.3C5360,80,5440,80,5520,71.7C5600,63,5680,47,5720,38.3L5760,30L5760,100L5720,100C5680,100,5600,100,5520,100C5440,100,5360,100,5280,100C5200,100,5120,100,5040,100C4960,100,4880,100,4800,100C4720,100,4640,100,4560,100C4480,100,4400,100,4320,100C4240,100,4160,100,4080,100C4000,100,3920,100,3840,100C3760,100,3680,100,3600,100C3520,100,3440,100,3360,100C3280,100,3200,100,3120,100C3040,100,2960,100,2880,100C2800,100,2720,100,2640,100C2560,100,2480,100,2400,100C2320,100,2240,100,2160,100C2080,100,2000,100,1920,100C1840,100,1760,100,1680,100C1600,100,1520,100,1440,100C1360,100,1280,100,1200,100C1120,100,1040,100,960,100C880,100,800,100,720,100C640,100,560,100,480,100C400,100,320,100,240,100C160,100,80,100,40,100L0,100Z"></path><defs><linearGradient id="sw-gradient-2" x1="0" x2="0" y1="1" y2="0"><stop stop-color="rgba(140, 110, 99, 1)" offset="0%"></stop><stop stop-color="rgba(140, 110, 99, 1)" offset="100%"></stop></linearGradient></defs><path style="transform:translate(0, 100px); opacity:0.8" fill="url(#sw-gradient-2)" d="M0,50L40,50C80,50,160,50,240,50C320,50,400,50,480,41.7C560,33,640,17,720,13.3C800,10,880,20,960,23.3C1040,27,1120,23,1200,23.3C1280,23,1360,27,1440,36.7C1520,47,1600,63,1680,71.7C1760,80,1840,80,1920,81.7C2000,83,2080,87,2160,75C2240,63,2320,37,2400,23.3C2480,10,2560,10,2640,16.7C2720,23,2800,37,2880,35C2960,33,3040,17,3120,18.3C3200,20,3280,40,3360,53.3C3440,67,3520,73,3600,68.3C3680,63,3760,47,3840,43.3C3920,40,4000,50,4080,51.7C4160,53,4240,47,4320,45C4400,43,4480,47,4560,40C4640,33,4720,17,4800,21.7C4880,27,4960,53,5040,60C5120,67,5200,53,5280,43.3C5360,33,5440,27,5520,30C5600,33,5680,47,5720,53.3L5760,60L5760,100L5720,100C5680,100,5600,100,5520,100C5440,100,5360,100,5280,100C5200,100,5120,100,5040,100C4960,100,4880,100,4800,100C4720,100,4640,100,4560,100C4480,100,4400,100,4320,100C4240,100,4160,100,4080,100C4000,100,3920,100,3840,100C3760,100,3680,100,3600,100C3520,100,3440,100,3360,100C3280,100,3200,100,3120,100C3040,100,2960,100,2880,100C2800,100,2720,100,2640,100C2560,100,2480,100,2400,100C2320,100,2240,100,2160,100C2080,100,2000,100,1920,100C1840,100,1760,100,1680,100C1600,100,1520,100,1440,100C1360,100,1280,100,1200,100C1120,100,1040,100,960,100C880,100,800,100,720,100C640,100,560,100,480,100C400,100,320,100,240,100C160,100,80,100,40,100L0,100Z"></path><defs><linearGradient id="sw-gradient-3" x1="0" x2="0" y1="1" y2="0"><stop stop-color="rgba(140, 110, 99, 1)" offset="0%"></stop><stop stop-color="rgba(140, 110, 99, 1)" offset="100%"></stop></linearGradient></defs><path style="transform:translate(0, 150px); opacity:0.7" fill="url(#sw-gradient-3)" d="M0,40L40,43.3C80,47,160,53,240,61.7C320,70,400,80,480,81.7C560,83,640,77,720,61.7C800,47,880,23,960,23.3C1040,23,1120,47,1200,58.3C1280,70,1360,70,1440,70C1520,70,1600,70,1680,73.3C1760,77,1840,83,1920,76.7C2000,70,2080,50,2160,46.7C2240,43,2320,57,2400,53.3C2480,50,2560,30,2640,28.3C2720,27,2800,43,2880,55C2960,67,3040,73,3120,76.7C3200,80,3280,80,3360,66.7C3440,53,3520,27,3600,16.7C3680,7,3760,13,3840,25C3920,37,4000,53,4080,50C4160,47,4240,23,4320,20C4400,17,4480,33,4560,41.7C4640,50,4720,50,4800,50C4880,50,4960,50,5040,43.3C5120,37,5200,23,5280,28.3C5360,33,5440,57,5520,56.7C5600,57,5680,33,5720,21.7L5760,10L5760,100L5720,100C5680,100,5600,100,5520,100C5440,100,5360,100,5280,100C5200,100,5120,100,5040,100C4960,100,4880,100,4800,100C4720,100,4640,100,4560,100C4480,100,4400,100,4320,100C4240,100,4160,100,4080,100C4000,100,3920,100,3840,100C3760,100,3680,100,3600,100C3520,100,3440,100,3360,100C3280,100,3200,100,3120,100C3040,100,2960,100,2880,100C2800,100,2720,100,2640,100C2560,100,2480,100,2400,100C2320,100,2240,100,2160,100C2080,100,2000,100,1920,100C1840,100,1760,100,1680,100C1600,100,1520,100,1440,100C1360,100,1280,100,1200,100C1120,100,1040,100,960,100C880,100,800,100,720,100C640,100,560,100,480,100C400,100,320,100,240,100C160,100,80,100,40,100L0,100Z"></path></svg>
        <%@include file="./components/footer.jsp" %>
    </body>
</html>
