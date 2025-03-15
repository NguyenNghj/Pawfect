<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="./components/header.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lịch sử đặt lịch</title>
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
                        <li class="breadcrumb-item active" aria-current="page">Lịch sử đặt lịch</li>
                    </ol>
                </nav>
            </div>

            <div class="row g-4">
                <!-- Main Content -->
                <div class="col-md-8">
                    <%
                        String message = (String) session.getAttribute("message");
                        String messageType = (String) session.getAttribute("messageType");
                        if (message != null) {
                    %>
                    <div class="alert alert-<%= "success".equals(messageType) ? "success" : "danger"%>">
                        <%= message%>
                    </div>
                    <%
                            session.removeAttribute("message");
                            session.removeAttribute("messageType");
                        }
                    %>
                    <!-- Booking History -->
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title mb-4">Lịch đã đặt của bạn</h5>
                            <ul class="nav nav-tabs mb-4">
                                <li class="nav-item">
                                    <a class="nav-link <c:if test="${status == 'tc'}">active</c:if>" href="bookinghistory?status=tc" style="font-weight: bold; border-width: 2px;">Tất cả</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link <c:if test="${status == 'dd'}">active</c:if>" href="bookinghistory?status=dd" style="font-weight: bold; border-width: 2px;">Đã duyệt</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link <c:if test="${status == 'cxn'}">active</c:if>" href="bookinghistory?status=cxn" style="font-weight: bold; border-width: 2px;">Chờ xác nhận</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link <c:if test="${status == 'dh'}">active</c:if>" href="bookinghistory?status=dh" style="font-weight: bold; border-width: 2px;">Đã hủy</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link <c:if test="${status == 'dnp'}">active</c:if>" href="bookinghistory?status=dnp" style="font-weight: bold; border-width: 2px;">Đã nhận phòng</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link <c:if test="${status == 'dtp'}">active</c:if>" href="bookinghistory?status=dtp" style="font-weight: bold; border-width: 2px;">Đã trả phòng</a>
                                    </li>
                                </ul>

                            <c:choose>
                                <c:when test="${not empty booking}">
                                    <c:forEach var="b" items="${booking}" varStatus="loop">
                                        <div class="card mb-3 hover-card booking-item" data-status="${b.status}" style="<c:if test='${loop.index >= 4}'>display: none;</c:if>">
                                            <a href="bookinghistorydetail?id=${b.bookingId}" style="text-decoration: none; color: inherit;">
                                                <div class="card-body">
                                                    <div class="row">
                                                        <div class="col">
                                                            <h6 class="mb-3">
                                                                ${b.roomName} - 
                                                                <span class="text-${b.status eq 'Đã duyệt' ? 'success' 
                                                                                    : (b.status eq 'Chờ xác nhận' ? 'warning' 
                                                                                    : (b.status eq 'Đã hủy' ? 'danger' 
                                                                                    : (b.status eq 'Đã nhận phòng' ? 'info' 
                                                                                    : (b.status eq 'Đã trả phòng' ? 'secondary' : 'secondary'))))} fw-bold">
                                                                          ${b.status}
                                                                      </span>
                                                                </h6>
                                                                <p class="text-secondary mb-2">
                                                                    Thú cưng: ${b.petName}
                                                                </p>
                                                                <p class="text-secondary mb-2">
                                                                    Ngày đặt lịch: 
                                                                    <fmt:formatDate value="${b.bookingDate}" pattern="dd/MM/yyyy HH:mm" />
                                                                </p>
                                                            </div>
                                                            <div class="col-auto text-end">
                                                                <h5 class="mb-0 text-primary fw-bold">
                                                                    <fmt:formatNumber value="${b.totalPrice}" pattern="#,##0" />đ
                                                                </h5>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </a>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div>
                                            <h5 style="color: #856404; text-align: center; background-color: #fff3cd; padding: 12px; border-radius: 5px;">
                                                Bạn chưa có đặt phòng nào.
                                            </h5>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                <div style="text-align: center">
                                    <!-- Nút Xem thêm -->
                                    <button id="loadMore" class="btn btn-success"
                                            style="--bs-btn-padding-y: .45rem; --bs-btn-padding-x: 1.7rem; --bs-btn-font-size: 1.1rem;">
                                        Xem thêm đặt lịch
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
                                <span>Thú cưng của tôi</span>
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
                                <span style="color: #D3A376;"><b>Lịch sử đặt lịch</b></span>
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
                function validateForm() {
                    let isValid = true;

                    // Lấy giá trị input
                    let fullName = document.getElementsByName("fullName")[0].value.trim();
                    let birthDate = document.getElementsByName("birthDate")[0].value;

                    let password = document.getElementsByName("password")[0].value;
                    let phoneNumber = document.getElementsByName("phoneNumber")[0].value.trim();
                    let address = document.getElementsByName("address")[0].value.trim();

                    // Định dạng kiểm tra

                    let phonePattern = /^[0-9]{9,}$/;
                    let today = new Date().toISOString().split("T")[0];

                    // Xóa thông báo lỗi cũ
                    document.getElementById("fullNameError").innerHTML = "";
                    document.getElementById("birthDateError").innerHTML = "";

                    document.getElementById("phoneError").innerHTML = "";
                    document.getElementById("addressError").innerHTML = "";

                    // Kiểm tra Họ tên
                    if (fullName.length < 3) {
                        document.getElementById("fullNameError").innerHTML = "Họ tên phải có ít nhất 3 ký tự!";
                        isValid = false;
                    }

                    // Kiểm tra Ngày sinh
                    if (!birthDate) {
                        document.getElementById("birthDateError").innerHTML = "Vui lòng chọn ngày sinh!";
                        isValid = false;
                    } else if (birthDate > today) {
                        document.getElementById("birthDateError").innerHTML = "Ngày sinh không thể lớn hơn ngày hiện tại!";
                        isValid = false;
                    }

                    // Kiểm tra Email


                    // Kiểm tra Số điện thoại
                    if (!phonePattern.test(phoneNumber)) {
                        document.getElementById("phoneError").innerHTML = "Số điện thoại phải có ít nhất 9 chữ số!";
                        isValid = false;
                    }

                    // Kiểm tra Địa chỉ
                    if (address.length < 5) {
                        document.getElementById("addressError").innerHTML = "Địa chỉ phải có ít nhất 5 ký tự!";
                        isValid = false;
                    }

                    return isValid;
                }
            </script>
            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    let priceElements = document.querySelectorAll(".format-price");
                    priceElements.forEach(element => {
                        let price = parseFloat(element.innerText);
                        element.innerText = new Intl.NumberFormat('vi-VN', {style: 'currency', currency: 'VND'}).format(price);
                    });
                });
            </script>


            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
            <script>
                let initialPets = $(".booking-item").length; // Tổng số feedback có sẵn
                let itemsToShow = 4; // Số feedback hiển thị ban đầu

                $(".booking-item").slice(itemsToShow).hide(); // Ẩn feedback vượt quá số quy định

                // Ẩn nút "Xem thêm" nếu tổng feedback nhỏ hơn hoặc bằng itemsToShow
                if (initialPets <= itemsToShow) {
                    $("#loadMore").hide();
                }


                $(document).ready(function () {
                    $("#loadMore").click(function () {
                        let hiddenPets = $(".booking-item:hidden"); // Lấy feedback chưa hiển thị
                        let itemsToShow = hiddenPets.slice(0, 4); // Lấy số feedback muốn hiển thị tiếp theo

                        if (itemsToShow.length > 0) {
                            itemsToShow.fadeIn(); // Hiển thị chúng
                        }

                        if ($(".booking-item:hidden").length === 0) {
                            $("#loadMore").hide(); // Ẩn nút nếu không còn feedback nào
                        }
                    });
                });
            </script>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        </body>
    </html>
