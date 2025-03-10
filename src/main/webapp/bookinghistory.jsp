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
                    <div class="card">
                        <div class="card-body">
                            <h2 class="h4 mb-3">Lịch sử đặt phòng</h2>

                            <!-- Bộ lọc trạng thái -->
                            <div class="d-flex gap-2 mb-3 p-2 rounded shadow-sm">
                                <button class="btn btn-outline-primary filter-btn active" data-status="all">
                                    Tất cả
                                </button>
                                <button class="btn btn-outline-success filter-btn" data-status="Đã duyệt">
                                    Đã duyệt
                                </button>
                                <button class="btn btn-outline-warning filter-btn" data-status="Chờ xác nhận">
                                    Chờ xác nhận
                                </button>
                                <button class="btn btn-outline-danger filter-btn" data-status="Đã hủy">
                                    Đã hủy
                                </button>
                                <button class="btn btn-outline-info filter-btn" data-status="Đã nhận phòng">
                                    Đã nhận phòng
                                </button>
                                <button class="btn btn-outline-secondary filter-btn" data-status="Đã trả phòng">
                                    Đã trả phòng
                                </button>
                            </div>

                            <c:choose>
                                <c:when test="${not empty booking}">
                                    <table class="table table-striped table-bordered">
                                        <thead class="table-primary">
                                            <tr>
                                                <th>Tên phòng</th>
                                                <th>Ngày đặt lịch</th>
                                                <th>Tổng tiền</th>
                                                <th>Trạng thái</th>
                                                <th>Chi tiết</th>
                                            </tr>
                                        </thead>
                                        <tbody id="booking-table">
                                            <c:forEach var="b" items="${booking}">
                                                <tr class="booking-row" data-status="${b.status}">
                                                    <td>${b.roomName}</td>
                                                    <td>
                                                        <fmt:formatDate value="${b.bookingDate}" pattern="dd/MM/yyyy HH:mm" />
                                                    </td>
                                                    <td class="format-price">${b.totalPrice}</td>
                                                    <td>
                                                        <span class="badge bg-${b.status eq 'Đã duyệt' ? 'success' 
                                                                                : (b.status eq 'Chờ xác nhận' ? 'warning' 
                                                                                : (b.status eq 'Đã hủy' ? 'danger' 
                                                                                : (b.status eq 'Đã nhận phòng' ? 'info' 
                                                                                : (b.status eq 'Đã trả phòng' ? 'secondary' : 'secondary'))))}">
                                                                  ${b.status}
                                                              </span>
                                                        </td>
                                                        <td>
                                                            <a href="bookinghistorydetail?id=${b.bookingId}" class="btn btn-primary btn-sm">
                                                                Xem chi tiết
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="text-muted">Bạn chưa có đặt phòng nào.</p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
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
            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    const filterButtons = document.querySelectorAll(".filter-btn");
                    const rows = document.querySelectorAll(".booking-row");

                    filterButtons.forEach(button => {
                        button.addEventListener("click", function () {
                            // Loại bỏ lớp active khỏi tất cả nút
                            filterButtons.forEach(btn => btn.classList.remove("active"));
                            this.classList.add("active");

                            const filterStatus = this.getAttribute("data-status");

                            rows.forEach(row => {
                                const rowStatus = row.getAttribute("data-status");
                                if (filterStatus === "all" || rowStatus === filterStatus) {
                                    row.style.display = "";
                                } else {
                                    row.style.display = "none";
                                }
                            });
                        });
                    });
                });
            </script>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        </body>
    </html>
