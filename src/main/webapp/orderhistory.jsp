<%-- 
    Document   : order
    Created on : Feb 15, 2025, 10:27:45 PM
    Author     : Vu Quang Duc - CE181221
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
            <nav aria-label="breadcrumb" class="mb-4">
                <ol class="breadcrumb p-3" style="background-color: white; border-radius: 5px;">
                    <li class="breadcrumb-item"><a href="#" class="text-decoration-none">Trang chủ</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Tài khoản</li>
                </ol>
            </nav>

            <div class="row g-4">
                <!-- Main Content -->
                <div class="col-md-8">
                    <!-- Top Cards -->
                    <div class="row g-4 mb-4">
                        <div class="col-md-4">
                            <div class="card h-100">
                                <div class="card-body d-flex align-items-center gap-3">
                                    <i class="bi bi-clipboard-check fs-4 text-primary"></i>
                                    <a href="#" class="text-decoration-none">Lịch sử đơn hàng</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card h-100">
                                <div class="card-body d-flex align-items-center gap-3">
                                    <i class="bi bi-calendar-date fs-4 text-primary"></i>
                                    <a href="#" class="text-decoration-none text-dark">Lịch sử đặt lịch</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card h-100">
                                <div class="card-body d-flex align-items-center gap-3">
                                    <i class="bi bi-person-circle fs-4"></i>
                                    <span>Xin chào, <span class="text-primary">[tên khách hàng]</span></span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Orders Section -->
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title mb-4">Đơn hàng của bạn</h5>

                            <!-- Order Tabs -->
                            <ul class="nav nav-tabs mb-4">
                                <li class="nav-item">
                                    <a class="nav-link <c:if test="${orderStatus == 'tc'}">active</c:if>" href="order?&action=view&status=tc"">Tất cả</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link <c:if test="${orderStatus == 'cxn'}">active</c:if>" href="order?&action=view&status=cxn">Chờ xác nhận</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link <c:if test="${orderStatus == 'clh'}">active</c:if>" href="order?&action=view&status=clh">Chờ lấy hàng</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link <c:if test="${orderStatus == 'cgh'}">active</c:if>" href="order?&action=view&status=cgh">Chờ giao hàng</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link <c:if test="${orderStatus == 'ht'}">active</c:if>" href="order?&action=view&status=ht">Hoàn thành</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link <c:if test="${orderStatus == 'dh'}">active</c:if>" href="order?&action=view&status=dh">Đã huỷ</a>
                                    </li>
                                </ul>

                            <c:choose>
                                <c:when test="${empty orders}">
                                    <!-- TH1: Khách hàng 'không' có đơn hàng -->
                                    <div>
                                        <h5 style="color: #856404; text-align: center; background-color: #fff3cd; padding: 12px; border-radius: 5px;">
                                            Bạn không có đơn hàng nào!
                                        </h5>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <!-- TH2: Khách hàng 'có' đơn hàng  -->
                                    <c:forEach items="${orders}" var="o">
                                        <!-- Order Item -->                           
                                        <div class="card mb-3 hover-card">
                                            <a href="order?&action=viewdetail&orderId=${o.orderId}" style="text-decoration: none; color: inherit;">
                                                <div class="card-body">
                                                    <div class="row">
                                                        <div class="col">
                                                            <h6 class="mb-3">
                                                                #${o.orderId + 2500000} -
                                                                <c:choose>
                                                                    <c:when test="${o.status == 'Chờ xác nhận'}"><span class="text-warning fw-bold">${o.status}</span></c:when>
                                                                    <c:when test="${o.status == 'Chờ lấy hàng'}"><span class="text-secondary fw-bold">${o.status}</span></c:when>
                                                                    <c:when test="${o.status == 'Chờ giao hàng'}"><span class="text-primary fw-bold">${o.status}</span></c:when>
                                                                    <c:when test="${o.status == 'Hoàn thành'}"><span class="text-success fw-bold">${o.status}</span></c:when>
                                                                    <c:otherwise><span class="text-danger fw-bold">${o.status}</span></c:otherwise> 
                                                                </c:choose>
                                                            </h6>
                                                            <p class="text-secondary mb-2">
                                                                Địa chỉ: ${o.address}
                                                            </p>
                                                            <p class="text-secondary">Ngày đặt: ${o.orderDate}</p>
                                                        </div>
                                                        <div class="col-auto text-end">
                                                            <h5 class="mb-3">
                                                                <f:formatNumber value="${o.totalAmount}" pattern="#,##0" />đ                                               
                                                            </h5>

                                                            <%--<c:choose>--%>
                                                                <c:if test="${o.status == 'Chờ xác nhận'}">
                                                                    <!-- Đơn hàng có trạng thái "Chờ xác nhận" thì mới được huỷ đơn -->
                                                                    <button class="btn-cancel btn btn-danger btn-sm"
                                                                            data-order-id="${o.orderId}"
                                                                            data-status="${o.status}"
                                                                            style="padding: 6px 15px;"
                                                                            onclick="huyDon(event)"
                                                                            >
                                                                        Huỷ đơn
                                                                    </button> 
                                                                </c:if>
                                                                <!-- Đơn hàng có trạng thái "Chờ xác nhận" thì mới được huỷ đơn -->
                                                                <%--<c:when test="${o.status == 'Chờ lấy hàng'}">
                                                                    <button class="btn-cancel btn btn-danger btn-sm"
                                                                            data-order-id="${o.orderId}"
                                                                            data-status="${o.status}"
                                                                            style="padding: 6px 15px;"
                                                                            onclick="huyDon(event)"
                                                                            >
                                                                        Yêu cầu huỷ đơn
                                                                    </button> 
                                                                </c:when>--%>
                                                            <%--</c:choose>--%>                      
                                                            <form id="cancelOrder${o.orderId}" action="order" method="POST">
                                                                <input type="hidden" name="action" value="cancel">
                                                                <input type="hidden" name="actionBack" value="view">
                                                                <input type="hidden" name="orderId" value="${o.orderId}">
                                                                <input type="hidden" name="statusOrder" value="Đã huỷ">
                                                                <input type="hidden" name="status" value="${param.status}">
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                            </a>                               
                                        </div> 
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <!-- Sidebar -->
                <div class="col-md-4">
                    <div class="list-group account-action">
                        <a href="#" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="fa-regular fa-user fa-lg" style="color: #0062ad;"></i>
                            <span>Thông tin cá nhân</span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="fa-solid fa-paw fa-lg" style="color: #8C6E63;"></i>
                            <span>Thú cưng của tôi</span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="fa-solid fa-key fa-lg" style="color: #eabd1a;"></i>
                            <span>Đổi mật khẩu</span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="fa-solid fa-arrow-right-from-bracket fa-lg" style="color: #d01616;"></i>
                            <span>Đăng xuất</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script>
                                                                                function huyDon(event) {
                                                                                    event.preventDefault();
                                                                                }

                                                                                $(document).ready(function () { // Đảm bảo code chạy sau khi trang đã load xong

                                                                                    $('.btn-cancel').click(function () { // Sử dụng class selector
                                                                                        let orderId = $(this).data('order-id'); // $(this) là nút được click      
                                                                                        let status = $(this).data('status');

//                                                                                        if (status === "Chờ xác nhận") {

                                                                                            Swal.fire({
                                                                                                title: 'Bạn chắc chắn muốn huỷ đơn #' + (2500000 + orderId) + '?',
                                                                                                text: 'Hành động này không thể hoàn tác!',
                                                                                                icon: 'warning',
                                                                                                showCancelButton: true,
                                                                                                confirmButtonColor: '#3085d6',
                                                                                                cancelButtonColor: '#d33',
                                                                                                confirmButtonText: 'Có, huỷ đơn!',
                                                                                                cancelButtonText: 'Không, quay lại'
                                                                                            }).then((result) => {
                                                                                                if (result.isConfirmed) {
                                                                                                    Swal.fire({
                                                                                                        title: 'Đang huỷ...',
                                                                                                        text: 'Vui lòng chờ trong giây lát.',
                                                                                                        icon: 'info',
                                                                                                        timer: 1300,
                                                                                                        timerProgressBar: true,
                                                                                                        showConfirmButton: false,
                                                                                                        allowOutsideClick: false, // Không cho bấm ra ngoài
                                                                                                        allowEscapeKey: false // Không cho nhấn ESC để thoát
                                                                                                    }).then(() => {
                                                                                                        Swal.fire({
                                                                                                            title: 'Đã huỷ!',
                                                                                                            text: 'Đơn hàng của bạn đã được huỷ.',
                                                                                                            icon: 'success',
                                                                                                            timer: 1600,
                                                                                                            timerProgressBar: true,
                                                                                                            showConfirmButton: false
                                                                                                        }).then(() => {
                                                                                                            let formId = "cancelOrder" + orderId; // Tạo ID duy nhất cho form
                                                                                                            let form = document.getElementById(formId);
                                                                                                            if (form) {
                                                                                                                form.submit();
                                                                                                            } else {
                                                                                                                console.error("Không tìm thấy form với ID: " + formId);
                                                                                                            }
                                                                                                        });
                                                                                                    });
                                                                                                }
                                                                                            });

//                                                                                        } else {
//                                                                                            Swal.fire({
//                                                                                                title: 'Bạn chắc chắn muốn gửi yêu cầu huỷ đơn hàng #' + (2500000 + orderId) + '?',
//                                                                                                text: 'Hành động này không thể hoàn tác!',
//                                                                                                icon: 'warning',
//                                                                                                showCancelButton: true,
//                                                                                                confirmButtonColor: '#3085d6',
//                                                                                                cancelButtonColor: '#d33',
//                                                                                                confirmButtonText: 'Có, gửi yêu cầu!',
//                                                                                                cancelButtonText: 'Không, quay lại'
//                                                                                            }).then((result) => {
//                                                                                                if (result.isConfirmed) {
//                                                                                                    Swal.fire({
//                                                                                                        title: 'Đã gửi!',
//                                                                                                        text: 'Yêu cầu huỷ đơn hàng của bạn đã gửi.',
//                                                                                                        icon: 'success',
//                                                                                                        timer: 1500,
//                                                                                                        timerProgressBar: true,
//                                                                                                        showConfirmButton: false
//                                                                                                    }).then(() => {
//                                                                                                        let formId = "cancelOrder" + orderId; // Tạo ID duy nhất cho form
//                                                                                                        let form = document.getElementById(formId);
//                                                                                                        if (form) {
//                                                                                                            form.submit();
//                                                                                                        } else {
//                                                                                                            console.error("Không tìm thấy form với ID: " + formId);
//                                                                                                        }
//                                                                                                    });
//                                                                                                }
//                                                                                            });
//                                                                                        }


                                                                                    });
                                                                                });
        </script>
    </body>
</html>
