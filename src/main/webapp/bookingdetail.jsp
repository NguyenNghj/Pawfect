<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lịch sử đặt lịch</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="./css/account.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            function confirmCancel(bookingId) {
                Swal.fire({
                    title: "Xác nhận hủy đơn hàng?",
                    text: "Bạn có chắc chắn muốn hủy đơn hàng này? Hành động này không thể hoàn tác!",
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#d33",
                    cancelButtonColor: "#3085d6",
                    confirmButtonText: "Có, hủy ngay!",
                    cancelButtonText: "Không, giữ lại"
                }).then((result) => {
                    if (result.isConfirmed) {
                        document.getElementById("cancelForm-" + bookingId).submit();
                    }
                });
            }
        </script>

    </head>
    <body>
        <div class="container py-4"> 
            <!-- Breadcrumb -->
            <nav aria-label="breadcrumb" class="mb-4">
                <ol class="breadcrumb p-3" style="background-color: white; border-radius: 5px;">
                    <li class="breadcrumb-item"><a href="pawfect" class="text-decoration-none">Trang chủ</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Lịch sử đặt lịch</li>
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
                                    <a href="bookinghistory" class="text-decoration-none" style="color: black;">Lịch sử đặt lịch</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card h-100">
                                <div class="card-body d-flex align-items-center gap-3">
                                    <i class="bi bi-person-circle fs-4"></i>
                                    <span>Xin chào, <span class="text-primary">${customer.fullName}</span></span>
                                </div>
                            </div>
                        </div>
                    </div>
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
                    <div class="container py-4" style="max-width: 1000px; margin: auto; background: #ffffff; border-radius: 10px; box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1); padding: 20px;">
                        <h2 style="text-align: center; font-size: 24px; font-weight: bold; color: #333; margin-bottom: 20px;">Chi tiết đặt phòng</h2>

                        <c:if test="${not empty booking}">
                            <div style="display: flex; flex-direction: row; justify-content: space-between; gap: 20px;">
                                <!-- Cột thông tin khách hàng -->
                                <div style="flex: 1; background: #f8f9fa; padding: 15px; border-radius: 8px; box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);">
                                    <h5 style="font-size: 18px; font-weight: 600; margin-bottom: 10px; color: #007bff;">Thông tin khách hàng</h5>
                                    <p><strong>Họ tên:</strong> ${booking.customerName}</p>
                                    <p><strong>Số điện thoại:</strong> ${customer.phone}</p>
                                    <p><strong>Email:</strong> ${customer.email}</p>
                                    <br><h5 style="font-size: 18px; font-weight: 600; margin-bottom: 10px; color: #007bff;">Nhân viên phụ trách</h5>
                                    <p>${booking.staffName}</p>
                                </div>

                                <!-- Cột thông tin đặt phòng -->
                                <div style="flex: 1; background: #f8f9fa; padding: 15px; border-radius: 8px; box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);">
                                    <h5 style="font-size: 18px; font-weight: 600; margin-bottom: 10px; color: #007bff;">Thông tin đặt phòng</h5>
                                    <p><strong>Tên phòng:</strong> ${booking.roomName}</p>
                                    <p><strong>Ngày check-in:</strong> 
                                        <br><fmt:formatDate value="${booking.checkIn}" pattern="HH:mm - dd/MM/yyyy" />
                                    </p>
                                    <p><strong>Ngày check-out:</strong> 
                                        <br><fmt:formatDate value="${booking.checkOut}" pattern="HH:mm - dd/MM/yyyy" />
                                    </p>
                                    <p><strong>Ngày đặt lịch:</strong> 
                                        <br><fmt:formatDate value="${booking.bookingDate}" pattern="HH:mm - dd/MM/yyyy" />
                                    </p>

                                </div>

                                <!-- Cột thông tin tổng tiền -->
                                <div style="flex: 1; background: #f8f9fa; padding: 15px; border-radius: 8px; box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);">
                                    <h5 style="font-size: 18px; font-weight: 600; margin-bottom: 10px; color: #007bff;">Trạng thái</h5> 
                                        <span style="padding: 6px 12px; border-radius: 5px; font-size: 14px; color: #fff; background-color:
                                              ${booking.status eq 'Đã duyệt' ? '#28a745' : (booking.status eq 'Chờ xác nhận' ? '#ffc107' : (booking.status eq 'Đã hủy' ? '#dc3545' : '#6c757d'))};">
                                            ${booking.status}
                                        </span>
                                    </p>
                                    <h5 style="font-size: 18px; font-weight: 600; margin-bottom: 10px; color: #007bff;">Ghi chú</h5>
                                    <p>${booking.note}</p>

                                    <h5 style="font-size: 18px; font-weight: 600; margin-bottom: 10px; color: #007bff;">Tổng chi phí</h5>
                                    <p class="format-price" style="font-size: 20px; font-weight: bold; color: black;">${booking.totalPrice}</p>
                                </div>
                            </div>

                            <!-- Nút điều hướng -->
                            <div style="display: flex; justify-content: center; gap: 15px; margin-top: 20px;">
                                <a href="bookinghistory" style="padding: 10px 15px; border-radius: 5px; font-size: 14px; font-weight: bold; text-decoration: none; text-align: center; background-color: #6c757d; color: white; border: none;">Quay lại</a>

                                <c:if test="${booking.status eq 'Chờ xác nhận'}">
                                    <form id="cancelForm-${booking.bookingId}" action="cancelbooking" method="post">
                                        <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                        <button type="button" style="padding: 10px 15px; border-radius: 5px; font-size: 14px; font-weight: bold; background-color: #dc3545; color: white; border: none;" onclick="confirmCancel(${booking.bookingId})">
                                            Hủy đơn hàng
                                        </button>
                                    </form>
                                </c:if>
                            </div>
                        </c:if>

                        <c:if test="${empty booking}">
                            <p style="text-align: center; font-size: 16px; font-weight: bold; color: #dc3545;">Không tìm thấy thông tin đặt phòng.</p>
                        </c:if>
                    </div>


                </div>

                <!-- Sidebar -->
                <div class="col-md-4">
                    <div class="list-group account-action">

                        <!-- Thông tin cá nhân -->
                        <a href="profile" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="fa-regular fa-user fa-lg" style="color: #0062ad;"></i>
                            <span style="color: #1c49c2;"><b>Thông tin cá nhân</b></span>
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


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
