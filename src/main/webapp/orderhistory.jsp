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
                    <li class="breadcrumb-item"><a href="pawfect" class="text-decoration-none">Trang chủ</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Tài khoản</li>
                </ol>
            </nav>

            <div class="row g-4">
                <!-- Main Content -->
                <div class="col-md-8">
                    <!-- Top Cards -->
                    <div class="row g-4 mb-4">
                        <div class="col-md-4">
                            <a href="#" class="text-decoration-none">
                                <div class="card h-100 active-card">
                                    <div class="card-body d-flex align-items-center gap-3">
                                        <i class="bi bi-clipboard-check fs-4 text-light fw-bold"></i>
                                        <span style="color: white; font-weight: bold">Lịch sử đơn hàng</span>
                                    </div>
                                </div>
                            </a>

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
                            <a href="profile" class="text-decoration-none">
                                <div class="card h-100">
                                    <div class="card-body d-flex align-items-center gap-3">
                                        <i class="bi bi-person-circle fs-4"></i>
                                        <span>Xin chào, <span class="text-primary">${customer.fullName}</span></span>
                                    </div>
                                </div>
                            </a>
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
                                        <a class="nav-link <c:if test="${orderStatus == 'ych'}">active</c:if>" href="order?&action=view&status=ych">Yêu cầu huỷ</a>
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
                                                            <h5 class="mb-3">
                                                                <c:choose>
                                                                    <c:when test="${o.discountAmount != 0}">
                                                                        <f:formatNumber value="${o.discountAmount}" pattern="#,##0" />đ
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
                        </div>
                    </div>
                </div>

                <!-- Sidebar -->
                <div class="col-md-4">
                    <div class="list-group account-action">
                        <a href="profile" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="fa-regular fa-user fa-lg" style="color: #0062ad;"></i>
                            <span>Thông tin cá nhân</span>
                        </a>
                        <a href="viewpet" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="fa-solid fa-paw fa-lg" style="color: #8C6E63;"></i>
                            <span>Thú cưng của tôi</span>
                        </a>
                        <a href="changepassword" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
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
    </body>
</html>
