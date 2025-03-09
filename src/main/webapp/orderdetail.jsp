<%-- 
    Document   : orderDetail
    Created on : Feb 15, 2025, 10:28:37 PM
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
                            <div class="card h-100">
                                <div class="card-body d-flex align-items-center gap-3">
                                    <i class="bi bi-clipboard-check fs-4 text-primary"></i>
                                    <a href="order?&action=view&status=tc" class="text-decoration-none text-dark">Lịch sử đơn hàng</a>
                                </div>
                            </div>

                        </div>
                        <div class="col-md-4">
                            <a href="#" class="text-decoration-none">
                                <div class="card h-100">
                                    <div class="card-body d-flex align-items-center gap-3">
                                        <i class="bi bi-calendar-date fs-4 text-primary"></i>
                                        <span >Lịch sử đặt lịch</span>
                                    </div>
                                </div>
                            </a>                      
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
                        <c:forEach items="${orders}" var="o">
                            <div class="card-body">
                                <header class="d-flex align-items-center mb-2">
                                    <a href="order?&action=view&status=tc" class="text-secondary me-3">
                                        <i class="bi bi-arrow-left"></i>
                                    </a>
                                    <h1 class="h4 mb-0">Đơn hàng của bạn</h1>
                                </header>

                                <!-- Đơn hàng có trạng thái "Chờ xác nhận" thì mới được huỷ đơn -->
                                <div class="text-secondary mb-4">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span>Đơn hàng: #${o.orderId + 2500000}</span>
                                        <c:if test="${o.status == 'Chờ xác nhận'}">
                                            <button class="btn btn-danger btn-sm btn-cancel"
                                                    data-bs-toggle="modal" data-bs-target="#cancelModal"
                                                    data-type="cancel"
                                                    style="padding: 8px 18px;"
                                                    >
                                                <span id="cancelType" style="font-size: 16px;">Huỷ đơn</span>
                                            </button>
                                        </c:if>
                                        <c:if test="${o.status == 'Chờ lấy hàng' && o.requestCancel == false}">
                                            <button class="btn btn-danger btn-sm btn-cancel"
                                                    data-bs-toggle="modal" data-bs-target="#cancelModal"
                                                    data-type="request"
                                                    style="padding: 8px 18px;"
                                                    >
                                                <span id="cancelType" style="font-size: 16px;">Yêu cầu huỷ đơn</span>
                                            </button>
                                        </c:if>

                                    </div>   
                                </div>

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
                                                            <span id="cancelMessage"><span style="font-weight: bold;"> <!-- Xu ly script ben duoi --> </span>
                                                                <!-- Xu ly script ben duoi -->
                                                            </span>
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

                                                    <input type="hidden" name="orderId" value="${o.orderId}">
                                                    <input type="hidden" name="confirmCancel" value="${o.requestCancel == false ? 'Đã huỷ' : 'Yêu cầu huỷ'}">
                                                    <input type="hidden" name="actionBack" value="viewdetail">
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

                                <!-- Package Tracking -->
                                <div class="card">

                                    <div class="card-body">
                                        <div class="mb-4">
                                            <div class="text-secondary small">Ngày đặt hàng</div>
                                            <div class="h3">${o.orderDate}</div>
                                        </div>

                                        <div class="mb-4">                                          
                                            <c:choose>
                                                <c:when test="${o.status == 'Chờ xác nhận'}"><div class="text-warning fw-bold">${o.status}</div></c:when>
                                                <c:when test="${o.status == 'Chờ lấy hàng'}"><div class="text-secondary fw-bold">${o.status}</div></c:when>
                                                <c:when test="${o.status == 'Chờ giao hàng'}"><div class="text-primary fw-bold">${o.status}</div></c:when>
                                                <c:when test="${o.status == 'Hoàn thành'}"><div class="text-success fw-bold">${o.status}</div></c:when>
                                                <c:when test="${o.status == 'Yêu cầu huỷ...'}"><div class="text-danger fw-bold">Giao hàng thành công</div></c:when>
                                                <c:otherwise><div class="text-danger fw-bold">${o.status}</div></c:otherwise> 
                                            </c:choose>

                                            <c:if test="${o.status == 'Hoàn thành'}">
                                                <div>${o.finishDate}</div>
                                            </c:if>

                                            <c:if test="${not empty o.reasonCancel}">
                                                <div><span class="text-danger" style="font-weight: 500;">Lý do huỷ:</span> ${o.reasonCancel}</div>
                                            </c:if>

                                        </div>

                                        <div class="row mb-4">
                                            <div class="col-md-7 mb-3 mb-md-0">
                                                <h6>Thông tin nhận hàng</h6>
                                                <div class="d-grid text-secondary">
                                                    <span>Họ tên: ${o.name}</span>
                                                    <span>Điện thoại: ${o.phone}</span>
                                                    <span>Địa chỉ: ${o.address}</span>
                                                    <span></span>
                                                </div>
                                                <!-- <address class="text-secondary">
                                                    Jane Doe<br>
                                                    1455 Market Street,<br>
                                                    San Francisco, CA 10977<br>
                                                    United States
                                                </address> -->
                                            </div>
                                            <div class="col-md-5">
                                                <h6 style="margin-bottom: 3px;">Phương thức giao hàng</h6>
                                                <div class="text-secondary">
                                                    ${o.shippingMethodName}
                                                </div>
                                                <h6 style="margin: 10px 0 3px 0;">Phương thức thanh toán</h6>
                                                <div class="text-secondary">
                                                    ${o.paymentMethodName}
                                                </div>
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <h6>Ghi chú giao hàng</h6>
                                            <textarea style="color: rgb(108 117 125);" class="form-control" id="exampleFormControlTextarea1" rows="3" readonly>${empty o.note ? 'Không có ghi chú.' : o.note}</textarea>
                                        </div>

                                        <div class="mb-1">
                                            <p><span style="color: chocolate;"><b>Nhân viên phụ trách: </b></span>${empty o.staffName ? 'Chờ xác nhận...' : o.staffName}</p>
                                        </div>
                                    </div>


                                </div>

                                <!-- Order Summary -->
                                <div class="card mt-4">
                                    <div class="card-header">
                                        <h2 class="h5 mb-0">Giỏ hàng của bạn</h2>
                                    </div>
                                    <div class="card-body">
                                        <div class="order-item">
                                            <c:forEach items="${orderitems}" var="oi">
                                                <div class="mb-4">
                                                    <!-- <div class="text-secondary small mb-2">PACKAGE 1 OF 2</div> -->
                                                    <div class="d-flex">
                                                        <div class="position-relative">
                                                            <img src="${oi.productImage}" alt="Product" class="rounded me-3" width="80" height="80">
                                                            <span class="position-absolute top-0 translate-middle badge rounded-pill bg-danger" style="left: 77%;">
                                                                ${oi.quantity}
                                                                <span class="visually-hidden">unread messages</span>
                                                            </span>
                                                        </div>
                                                        <div class="flex-grow-1">
                                                            <div class="fw-bold">${oi.productName}</div>
                                                            <div class="text-secondary">
                                                                <f:formatNumber value="${oi.productPrice}" pattern="#,##0" />đ                                                               
                                                            </div>
                                                        </div>
                                                        <div class="fw-bold">
                                                            <f:formatNumber value="${oi.getSubtotal()}" pattern="#,##0" />đ                                                            
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>                                         

                                        </div>

                                        <div class="border-top pt-3">
                                            <div class="d-flex justify-content-between mb-2">
                                                <div class="text-secondary">Tạm tính</div>
                                                <div>
                                                    <f:formatNumber value="${basicPrice}" pattern="#,##0" />đ                                                 
                                                </div>
                                            </div>
                                            <!-- Phí Ship -->
                                            <div class="d-flex justify-content-between mb-2">
                                                <div class="text-secondary">Phí vận chuyển</div>
                                                <div>
                                                    <f:formatNumber value="${o.shippingMethodFee}" pattern="#,##0" />đ                                                  
                                                </div>
                                            </div>
                                            <div class="d-flex justify-content-between mb-2">
                                                <div class="text-success">Khuyến mãi</div>
                                                <div class="text-success">
                                                    <c:choose>
                                                        <c:when test="${o.discountAmount != 0}">
                                                            - <f:formatNumber value="${o.totalAmount - o.discountAmount}" pattern="#,##0" />đ
                                                        </c:when>
                                                        <c:otherwise>
                                                            - <f:formatNumber value="0" pattern="#,##0" />đ
                                                        </c:otherwise>
                                                    </c:choose>

                                                </div>
                                            </div>
                                            <div class="d-flex justify-content-between align-items-center border-top pt-3 mt-3">
                                                <h5 class="text-primary">TỔNG TIỀN</h5>
                                                <c:choose>
                                                    <c:when test="${o.discountAmount != 0}">
                                                        <div class="d-flex align-items-center gap-3">
                                                            <div class="h5 m-0" style="text-decoration: line-through">
                                                                <f:formatNumber value="${o.totalAmount}" pattern="#,##0" />đ
                                                            </div>
                                                            <div class="h3 m-0 text-danger">
                                                                <f:formatNumber value="${o.discountAmount}" pattern="#,##0" />đ
                                                            </div>
                                                        </div>

                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="h3 m-0">
                                                            <f:formatNumber value="${o.totalAmount}" pattern="#,##0" />đ
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </div>                                              
                            </div>
                        </c:forEach>

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
