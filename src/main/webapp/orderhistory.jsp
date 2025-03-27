<%-- 
    Document   : order
    Created on : Feb 15, 2025, 10:27:45 PM
    Author     : Vu Quang Duc - CE181221
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@include file="./components/header.jsp" %>
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
                        <li class="breadcrumb-item active" aria-current="page">Lịch sử đơn hàng</li>
                    </ol>
                </nav>
            </div>

            <div class="row g-4">
                <!-- Main Content -->
                <div class="col-md-8">
                    <!-- Orders Section -->
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title mb-4" >Đơn hàng của bạn</h5>

                            <!-- Order Tabs -->
                            <ul class="nav nav-tabs mb-4">
                                <li class="nav-item">
                                    <a class="nav-link <c:if test="${orderStatus == 'tc'}">active</c:if>" href="order?&action=view&status=tc" style="font-weight: bold; border-width: 2px;">Tất cả</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link <c:if test="${orderStatus == 'cxn'}">active</c:if>" href="order?&action=view&status=cxn" style="font-weight: bold; border-width: 2px;">Chờ xác nhận</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link <c:if test="${orderStatus == 'clh'}">active</c:if>" href="order?&action=view&status=clh" style="font-weight: bold; border-width: 2px;">Chờ lấy hàng</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link <c:if test="${orderStatus == 'cgh'}">active</c:if>" href="order?&action=view&status=cgh" style="font-weight: bold; border-width: 2px;">Chờ giao hàng</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link <c:if test="${orderStatus == 'ht'}">active</c:if>" href="order?&action=view&status=ht" style="font-weight: bold; border-width: 2px;">Hoàn thành</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link <c:if test="${orderStatus == 'ych'}">active</c:if>" href="order?&action=view&status=ych" style="font-weight: bold; border-width: 2px;">Yêu cầu huỷ</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link <c:if test="${orderStatus == 'dh'}">active</c:if>" href="order?&action=view&status=dh" style="font-weight: bold; border-width: 2px;">Đã huỷ</a>
                                    </li>
                                </ul>

                            <c:choose>
                                <c:when test="${empty orders}">
                                    <!-- TH1: Khách hàng 'không' có đơn hàng -->
                                    <div>
                                        <h5 style="color: #856404; text-align: center; background-color: #fff3cd; padding: 12px; border-radius: 5px;">
                                            Không tìm thấy!
                                        </h5>
                                    </div>
                                </c:when>
                                <c:otherwise>

                                    <!-- TH2: Khách hàng 'có' đơn hàng  -->
                                    <c:forEach items="${orders}" var="o" varStatus="loop">

                                        <!-- Order Item -->                           
                                        <div class="card mb-3 hover-card order-item" style="<c:if test='${loop.index >= 4}'>display: none;</c:if>">
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
                                                                    <c:when test="${o.status == 'Yêu cầu huỷ...'}"><span class="text-danger fw-bold">${o.status}</span></c:when>
                                                                    <c:otherwise><span class="text-danger fw-bold">${o.status}</span></c:otherwise> 
                                                                </c:choose>
                                                            </h6>
                                                            <p class="text-secondary mb-2">
                                                                Địa chỉ: ${o.address}
                                                            </p>
                                                            <p class="text-secondary">Ngày đặt: ${o.orderDate}</p>
                                                        </div>
                                                        <div class="col-auto text-end">
                                                            <h5 class="mb-3 text-primary fw-bold">
                                                                <c:choose>
                                                                    <c:when test="${o.discountAmount != 0}">
                                                                        <c:choose>
                                                                            <c:when test="${o.totalAmount - o.discountAmount < 0}">
                                                                                <f:formatNumber value="0" pattern="#,##0" />đ
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <f:formatNumber value="${o.totalAmount}" pattern="#,##0" />đ
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                        
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <f:formatNumber value="${o.totalAmount}" pattern="#,##0" />đ
                                                                    </c:otherwise>
                                                                </c:choose>                                               
                                                            </h5>

                                                            <%--<c:choose>--%>
                                                            <c:if test="${o.status == 'Chờ xác nhận'}">
                                                                <!-- Đơn hàng có trạng thái "Chờ xác nhận" thì mới được huỷ đơn -->
                                                                <button class="btn-cancel btn btn-danger btn-sm"
                                                                        data-bs-toggle="modal" data-bs-target="#cancelModal"
                                                                        style="padding: 6px 15px;"
                                                                        data-type="cancel"
                                                                        data-order-id="${o.orderId}"
                                                                        data-request="${o.requestCancel}"
                                                                        onclick="huyDon(event)"
                                                                        >
                                                                    <span id="cancelType">Huỷ đơn</span>
                                                                </button>

                                                            </c:if>
                                                            <c:if test="${o.status == 'Chờ lấy hàng' && o.requestCancel == false}">
                                                                <button class="btn btn-danger btn-sm btn-cancel"
                                                                        data-bs-toggle="modal" data-bs-target="#cancelModal"
                                                                        data-type="request"
                                                                        data-order-id="${o.orderId}"
                                                                        data-request="${o.requestCancel}"
                                                                        style="padding: 6px 15px;"
                                                                        onclick="huyDon(event)"
                                                                        >
                                                                    <span id="cancelType">Yêu cầu huỷ đơn</span>
                                                                </button>
                                                            </c:if>

                                                        </div>                                                                                                                 
                                                    </div>
                                                </div>
                                            </a>                                           
                                        </div> 

                                    </c:forEach>
                                    <!-- Modal Cancel -->
                                    <div class="modal fade" id="cancelModal" tabindex="-1" aria-labelledby="cancelModalLabel" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h1 class="modal-title fs-5" id="cancelModalLabel">Xác Nhận Huỷ Đơn Hàng</h1>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <form id="cancelForm" action="order?action=cancel" method="post">
                                                    <div class="modal-body">                           
                                                        <div class="mb-3">
                                                            <div class="mb-2" style="text-align: justify;">
                                                                <span id="cancelMessage"><span style="font-weight: bold;"> <!-- Xu ly script ben duoi --> </span> <!-- Xu ly script ben duoi --> </span>
                                                            </div>
                                                            <label for="message-text" class="col-form-label"><span style="color: red; font-weight: bold;">Lý Do Huỷ</span></label>
                                                            <select id="reason" name="reasonCancel" class="form-select" aria-label="Default select example" required oninvalid="this.setCustomValidity('Vui lòng chọn lý do huỷ!')" oninput="this.setCustomValidity('')">
                                                                <option value="" selected>Chọn lý do</option>
                                                                <option value="Tôi muốn cập nhật địa chỉ / sđt nhận hàng">Tôi muốn cập nhật địa chỉ / sđt nhận hàng</option>
                                                                <option value="Người bán không trả lời thắc mắc / yêu cầu của tôi">Người bán không trả lời thắc mắc / yêu cầu của tôi</option>
                                                                <option value="Thay đổi đơn hàng">Thay đổi đơn hàng</option>
                                                                <option value="Tôi không có nhu cầu mua nữa">Tôi không có nhu cầu mua nữa</option>
                                                            </select>
                                                        </div>

                                                        <input type="hidden" name="orderId" id="modalOrderId">
                                                        <input type="hidden" name="confirmCancel" id="modalOrderRequest">
                                                        <input type="hidden" name="actionBack" value="view">
                                                        <input type="hidden" name="statusType" value="${param.status}">
                                                        <input type="hidden" name="reasonCancel">

                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                        <button type="submit" class="btn btn-primary" id="confirmCancelBtn">Huỷ đơn</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            <div style="text-align: center">
                                <!-- Nút Xem thêm -->
                                <button id="loadMore" class="btn btn-success"
                                        style="--bs-btn-padding-y: .45rem; --bs-btn-padding-x: 1.7rem; --bs-btn-font-size: 1.1rem;">
                                    Xem thêm đơn hàng
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
                            <span style="color: #D3A376;"><b>Lịch sử đơn hàng</b></span>
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


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script>
                                                                            function huyDon(event) {
                                                                                event.preventDefault();
                                                                                let button = event.currentTarget; // Lấy nút được nhấn
                                                                                let orderId = button.getAttribute("data-order-id");
                                                                                let requestCancel = button.getAttribute("data-request");

                                                                                console.log("Gia tri order: ", orderId);
                                                                                console.log("Gia tri request: ", requestCancel);

                                                                                document.querySelector("#modalOrderId").value = orderId;

                                                                                // Kiểm tra điều kiện
                                                                                if (requestCancel === "false") {
                                                                                    document.querySelector("#modalOrderRequest").value = "Đã huỷ"; // Nếu requestCancel = false → Gán "Đã huỷ"
                                                                                } else {
                                                                                    document.querySelector("#modalOrderRequest").value = "Yêu cầu huỷ"; // Nếu requestCancel = true → Gán "Yêu cầu huỷ"
                                                                                }
                                                                            }


                                                                            document.addEventListener("DOMContentLoaded", function () {
                                                                                document.querySelectorAll(".btn-cancel").forEach(button => {
                                                                                    button.addEventListener("click", function () {
                                                                                        let cancelType = this.getAttribute("data-type"); // Lấy loại nút (cancel/request)
                                                                                        let modalTitle = document.getElementById("cancelModalLabel");
                                                                                        let cancelMessage = document.getElementById("cancelMessage");
                                                                                        let confirmCancelInput = document.querySelector("input[name='confirmCancel']");
                                                                                        let confirmButton = document.getElementById("confirmCancelBtn"); // Lấy nút xác nhận

                                                                                        if (cancelType === "cancel") {
                                                                                            modalTitle.textContent = "Xác Nhận Huỷ Đơn Hàng";
                                                                                            cancelMessage.innerHTML = "<b>Lưu ý:</b> Nếu bạn xác nhận huỷ, toàn bộ đơn hàng sẽ được huỷ. Trường hợp bạn đã thanh toán đơn hàng, tiền sẽ được hoàn về tài khoản trong vòng 24 giờ và lâu hơn đối với các phương thức thanh toán khác.";
                                                                                            confirmCancelInput.value = "Đã huỷ";
                                                                                            confirmButton.textContent = "Huỷ đơn"; // Thay đổi text nút xác nhận
                                                                                        } else {
                                                                                            modalTitle.textContent = "Yêu Cầu Huỷ Đơn Hàng";
                                                                                            cancelMessage.innerHTML = "<b>Lưu ý:</b> Bạn đang gửi yêu cầu huỷ, cần người bán xác nhận. Chúng tôi sẽ thông báo cho bạn biết sau khi xử lý yêu cầu.";
                                                                                            confirmCancelInput.value = "Yêu cầu huỷ";
                                                                                            confirmButton.textContent = "Gửi yêu cầu"; // Thay đổi text nút xác nhận
                                                                                        }
                                                                                    });
                                                                                });
                                                                            });


                                                                            document.getElementById("cancelForm").addEventListener("submit", function (event) {
                                                                                event.preventDefault(); // Ngăn form gửi đi ngay lập tức

                                                                                var reason = document.getElementById("reason").value;
                                                                                let text = $("#cancelType").text();

                                                                                if (reason === "") {
                                                                                    Swal.fire({
                                                                                        icon: "warning",
                                                                                        title: "Lỗi!",
                                                                                        text: "Vui lòng chọn lý do huỷ đơn hàng.",
                                                                                    });
                                                                                } else {
                                                                                    Swal.fire({
                                                                                        icon: "info",
                                                                                        title: "Đang xử lý...",
                                                                                        text: "Vui lòng chờ trong giây lát.",
                                                                                        timer: 1400,
                                                                                        timerProgressBar: true,
                                                                                        allowOutsideClick: false,
                                                                                        showConfirmButton: false // Ẩn nút OK
                                                                                    }).then(() => {
                                                                                        if (text === "Yêu cầu huỷ đơn") {
                                                                                            Swal.fire({
                                                                                                icon: "success",
                                                                                                title: "Yêu cầu huỷ đơn thành công!",
                                                                                                text: "Chúng tôi sẽ xem xét yêu cầu huỷ đơn của bạn.",
                                                                                            }).then(() => {
                                                                                                document.getElementById("cancelForm").submit(); // Gửi form sau khi hiển thị thông báo thành công
                                                                                            });
                                                                                        } else {
                                                                                            Swal.fire({
                                                                                                icon: "success",
                                                                                                title: "Huỷ đơn thành công!",
                                                                                                text: "Chúng tôi sẽ xử lý đơn huỷ và hoàn tiền nếu bạn đã thanh toán.",
                                                                                            }).then(() => {
                                                                                                document.getElementById("cancelForm").submit(); // Gửi form sau khi hiển thị thông báo thành công
                                                                                            });
                                                                                        }
                                                                                    });
                                                                                }
                                                                            });

        </script>


        <%-- Xu ly xem them product feedback --%>
        <script>
            let initialFeedbacks = $(".order-item").length; // Tổng số feedback có sẵn
            let itemsToShow = 4; // Số feedback hiển thị ban đầu

            $(".order-item").slice(itemsToShow).hide(); // Ẩn feedback vượt quá số quy định

            // Ẩn nút "Xem thêm" nếu tổng feedback nhỏ hơn hoặc bằng itemsToShow
            if (initialFeedbacks <= itemsToShow) {
                $("#loadMore").hide();
            }


            $(document).ready(function () {
                $("#loadMore").click(function () {
                    let hiddenFeedbacks = $(".order-item:hidden"); // Lấy feedback chưa hiển thị
                    let itemsToShow = hiddenFeedbacks.slice(0, 4); // Lấy số feedback muốn hiển thị tiếp theo

                    if (itemsToShow.length > 0) {
                        itemsToShow.fadeIn(); // Hiển thị chúng
                    }

                    if ($(".order-item:hidden").length === 0) {
                        $("#loadMore").hide(); // Ẩn nút nếu không còn feedback nào
                    }
                });
            });
        </script>

        <svg id="wave" style="transform:rotate(0deg); transition: 0.3s" viewBox="0 0 1440 100" version="1.1" xmlns="http://www.w3.org/2000/svg"><defs><linearGradient id="sw-gradient-0" x1="0" x2="0" y1="1" y2="0"><stop stop-color="rgba(140, 110, 99, 1)" offset="0%"></stop><stop stop-color="rgba(140, 110, 99, 1)" offset="100%"></stop></linearGradient></defs><path style="transform:translate(0, 0px); opacity:1" fill="url(#sw-gradient-0)" d="M0,0L40,13.3C80,27,160,53,240,55C320,57,400,33,480,31.7C560,30,640,50,720,58.3C800,67,880,63,960,53.3C1040,43,1120,27,1200,25C1280,23,1360,37,1440,36.7C1520,37,1600,23,1680,16.7C1760,10,1840,10,1920,11.7C2000,13,2080,17,2160,15C2240,13,2320,7,2400,8.3C2480,10,2560,20,2640,20C2720,20,2800,10,2880,15C2960,20,3040,40,3120,48.3C3200,57,3280,53,3360,56.7C3440,60,3520,70,3600,73.3C3680,77,3760,73,3840,61.7C3920,50,4000,30,4080,28.3C4160,27,4240,43,4320,51.7C4400,60,4480,60,4560,56.7C4640,53,4720,47,4800,38.3C4880,30,4960,20,5040,23.3C5120,27,5200,43,5280,50C5360,57,5440,53,5520,51.7C5600,50,5680,50,5720,50L5760,50L5760,100L5720,100C5680,100,5600,100,5520,100C5440,100,5360,100,5280,100C5200,100,5120,100,5040,100C4960,100,4880,100,4800,100C4720,100,4640,100,4560,100C4480,100,4400,100,4320,100C4240,100,4160,100,4080,100C4000,100,3920,100,3840,100C3760,100,3680,100,3600,100C3520,100,3440,100,3360,100C3280,100,3200,100,3120,100C3040,100,2960,100,2880,100C2800,100,2720,100,2640,100C2560,100,2480,100,2400,100C2320,100,2240,100,2160,100C2080,100,2000,100,1920,100C1840,100,1760,100,1680,100C1600,100,1520,100,1440,100C1360,100,1280,100,1200,100C1120,100,1040,100,960,100C880,100,800,100,720,100C640,100,560,100,480,100C400,100,320,100,240,100C160,100,80,100,40,100L0,100Z"></path><defs><linearGradient id="sw-gradient-1" x1="0" x2="0" y1="1" y2="0"><stop stop-color="rgba(140, 110, 99, 1)" offset="0%"></stop><stop stop-color="rgba(140, 110, 99, 1)" offset="100%"></stop></linearGradient></defs><path style="transform:translate(0, 50px); opacity:0.9" fill="url(#sw-gradient-1)" d="M0,20L40,25C80,30,160,40,240,45C320,50,400,50,480,41.7C560,33,640,17,720,20C800,23,880,47,960,50C1040,53,1120,37,1200,28.3C1280,20,1360,20,1440,16.7C1520,13,1600,7,1680,18.3C1760,30,1840,60,1920,70C2000,80,2080,70,2160,58.3C2240,47,2320,33,2400,31.7C2480,30,2560,40,2640,41.7C2720,43,2800,37,2880,40C2960,43,3040,57,3120,66.7C3200,77,3280,83,3360,81.7C3440,80,3520,70,3600,68.3C3680,67,3760,73,3840,68.3C3920,63,4000,47,4080,35C4160,23,4240,17,4320,15C4400,13,4480,17,4560,28.3C4640,40,4720,60,4800,58.3C4880,57,4960,33,5040,33.3C5120,33,5200,57,5280,68.3C5360,80,5440,80,5520,71.7C5600,63,5680,47,5720,38.3L5760,30L5760,100L5720,100C5680,100,5600,100,5520,100C5440,100,5360,100,5280,100C5200,100,5120,100,5040,100C4960,100,4880,100,4800,100C4720,100,4640,100,4560,100C4480,100,4400,100,4320,100C4240,100,4160,100,4080,100C4000,100,3920,100,3840,100C3760,100,3680,100,3600,100C3520,100,3440,100,3360,100C3280,100,3200,100,3120,100C3040,100,2960,100,2880,100C2800,100,2720,100,2640,100C2560,100,2480,100,2400,100C2320,100,2240,100,2160,100C2080,100,2000,100,1920,100C1840,100,1760,100,1680,100C1600,100,1520,100,1440,100C1360,100,1280,100,1200,100C1120,100,1040,100,960,100C880,100,800,100,720,100C640,100,560,100,480,100C400,100,320,100,240,100C160,100,80,100,40,100L0,100Z"></path><defs><linearGradient id="sw-gradient-2" x1="0" x2="0" y1="1" y2="0"><stop stop-color="rgba(140, 110, 99, 1)" offset="0%"></stop><stop stop-color="rgba(140, 110, 99, 1)" offset="100%"></stop></linearGradient></defs><path style="transform:translate(0, 100px); opacity:0.8" fill="url(#sw-gradient-2)" d="M0,50L40,50C80,50,160,50,240,50C320,50,400,50,480,41.7C560,33,640,17,720,13.3C800,10,880,20,960,23.3C1040,27,1120,23,1200,23.3C1280,23,1360,27,1440,36.7C1520,47,1600,63,1680,71.7C1760,80,1840,80,1920,81.7C2000,83,2080,87,2160,75C2240,63,2320,37,2400,23.3C2480,10,2560,10,2640,16.7C2720,23,2800,37,2880,35C2960,33,3040,17,3120,18.3C3200,20,3280,40,3360,53.3C3440,67,3520,73,3600,68.3C3680,63,3760,47,3840,43.3C3920,40,4000,50,4080,51.7C4160,53,4240,47,4320,45C4400,43,4480,47,4560,40C4640,33,4720,17,4800,21.7C4880,27,4960,53,5040,60C5120,67,5200,53,5280,43.3C5360,33,5440,27,5520,30C5600,33,5680,47,5720,53.3L5760,60L5760,100L5720,100C5680,100,5600,100,5520,100C5440,100,5360,100,5280,100C5200,100,5120,100,5040,100C4960,100,4880,100,4800,100C4720,100,4640,100,4560,100C4480,100,4400,100,4320,100C4240,100,4160,100,4080,100C4000,100,3920,100,3840,100C3760,100,3680,100,3600,100C3520,100,3440,100,3360,100C3280,100,3200,100,3120,100C3040,100,2960,100,2880,100C2800,100,2720,100,2640,100C2560,100,2480,100,2400,100C2320,100,2240,100,2160,100C2080,100,2000,100,1920,100C1840,100,1760,100,1680,100C1600,100,1520,100,1440,100C1360,100,1280,100,1200,100C1120,100,1040,100,960,100C880,100,800,100,720,100C640,100,560,100,480,100C400,100,320,100,240,100C160,100,80,100,40,100L0,100Z"></path><defs><linearGradient id="sw-gradient-3" x1="0" x2="0" y1="1" y2="0"><stop stop-color="rgba(140, 110, 99, 1)" offset="0%"></stop><stop stop-color="rgba(140, 110, 99, 1)" offset="100%"></stop></linearGradient></defs><path style="transform:translate(0, 150px); opacity:0.7" fill="url(#sw-gradient-3)" d="M0,40L40,43.3C80,47,160,53,240,61.7C320,70,400,80,480,81.7C560,83,640,77,720,61.7C800,47,880,23,960,23.3C1040,23,1120,47,1200,58.3C1280,70,1360,70,1440,70C1520,70,1600,70,1680,73.3C1760,77,1840,83,1920,76.7C2000,70,2080,50,2160,46.7C2240,43,2320,57,2400,53.3C2480,50,2560,30,2640,28.3C2720,27,2800,43,2880,55C2960,67,3040,73,3120,76.7C3200,80,3280,80,3360,66.7C3440,53,3520,27,3600,16.7C3680,7,3760,13,3840,25C3920,37,4000,53,4080,50C4160,47,4240,23,4320,20C4400,17,4480,33,4560,41.7C4640,50,4720,50,4800,50C4880,50,4960,50,5040,43.3C5120,37,5200,23,5280,28.3C5360,33,5440,57,5520,56.7C5600,57,5680,33,5720,21.7L5760,10L5760,100L5720,100C5680,100,5600,100,5520,100C5440,100,5360,100,5280,100C5200,100,5120,100,5040,100C4960,100,4880,100,4800,100C4720,100,4640,100,4560,100C4480,100,4400,100,4320,100C4240,100,4160,100,4080,100C4000,100,3920,100,3840,100C3760,100,3680,100,3600,100C3520,100,3440,100,3360,100C3280,100,3200,100,3120,100C3040,100,2960,100,2880,100C2800,100,2720,100,2640,100C2560,100,2480,100,2400,100C2320,100,2240,100,2160,100C2080,100,2000,100,1920,100C1840,100,1760,100,1680,100C1600,100,1520,100,1440,100C1360,100,1280,100,1200,100C1120,100,1040,100,960,100C880,100,800,100,720,100C640,100,560,100,480,100C400,100,320,100,240,100C160,100,80,100,40,100L0,100Z"></path></svg>
        <%@include file="./components/footer.jsp" %>
    </body>
</html>
