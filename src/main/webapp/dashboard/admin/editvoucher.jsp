<%-- 
    Document   : editvoucher
    Created on : Mar 8, 2025, 9:37:33 AM
    Author     : Nguyen Tri Nghi - CE180897
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;600;800&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="../../css/dashboard.css">
        <title>Chỉnh sửa mã giảm giá</title>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">

                <!-- SIDEBAR -->
                <jsp:include page="sidebar.jsp"/>
                <%
                    Cookie[] cookies = request.getCookies();
                    String staffRole = "";
                    String staffName = "";

                    if (cookies != null) {
                        for (Cookie cookie : cookies) {
                            String name = cookie.getName();
                            String value = cookie.getValue();

                            if ("staffRole".equals(name)) {
                                staffRole = value;
                            } else if ("staffName".equals(name)) {
                                staffName = value;
                            }

                            // Nếu đã lấy được cả hai giá trị thì thoát vòng lặp
                            if (!staffRole.isEmpty() && !staffName.isEmpty()) {
                                break;
                            }
                        }
                    }
                    request.setAttribute("staffRole", staffRole);
                    request.setAttribute("staffName", staffName);
                %>
                <!-- MAIN -->
                <div class="col" id="main" style="padding: 0 40px;">
                    <div class="row pt-4">
                        <div class="d-flex align-items-center justify-content-between" style="padding: 0;">
                            <div>
                                <h1>Chỉnh sửa mã giảm giá</h1>
                            </div>
                            <div class="dropdown d-flex align-items-center gap-2">
                                <span style = "color: #D3A376; font-weight: bold;"><%= staffName%></span>
                                <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <img class="profile-img" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTf74k9hxcTCkLN2gyhCr9lzuzZax5iy0uDOA&s" alt="">
                                </button>
                                <ul class="dropdown-menu ps-2 pe-2 pt-2 pb-2">
                                    <div class="d-grid gap-2">
                                        <li class="profile-img-switch-employee d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-repeat"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="/dashboard/staff/statistics">Chuyển qua giao diện nhân viên</a>
                                        </li>
                                    </div>
                                </ul>
                            </div>                                                               
                        </div>
                    </div>

                    <div class="row mt-2 bg-white p-3 d-flex align-items-center justify-content-center" 
                         style="border-radius: 20px; height: 60px;">
                        <nav style="--bs-breadcrumb-divider: '>'; padding: 0 5px;" aria-label="breadcrumb">
                            <ol class="breadcrumb mb-0" style ="font-weight: bold;">
                                <li class="breadcrumb-item">Dashboard</li>
                                <li class="breadcrumb-item"><a href="/dashboard/admin/voucher">Quản lý mã giảm giá</a></li>
                                <li class="breadcrumb-item active" aria-current="page">${voucher.code}</li>
                            </ol>
                        </nav>
                    </div>   

                    <div class="row" style="margin-top: 20px; margin-bottom: 50px;">
                        <form id="editVoucherForm" action="/dashboard/admin/editvoucher" method="post">

                            <input type="hidden" name="voucherId" value="${voucher.voucherId}">

                            <div class="mb-3">
                                <label for="editVoucherCode" class="form-label">Mã giảm giá</label>
                                <input type="text" class="form-control" name="code" value="${voucher.code}" disable>
                            </div>

                            <div class="mb-3">
                                <label for="editVoucherDescription" class="form-label">Mô tả</label>
                                <textarea class="form-control" name="description" rows="3">${voucher.description}</textarea>
                            </div>

                            <div class="mb-3">
                                <label for="editDiscountPercentage" class="form-label">Phần trăm giảm giá</label>
                                <input type="number" class="form-control" name="discountPercentage" min="0" max="100" value="${voucher.discountPercentage}">
                            </div>

                            <div class="mb-3">
                                <label for="editDiscountAmount" class="form-label">Số tiền giảm giá</label>
                                <input type="number" class="form-control" name="discountAmount" min="0" value="${voucher.discountAmount}">
                            </div>

                            <div class="mb-3">
                                <label for="editMinOrderValue" class="form-label">Giá trị đơn hàng tối thiểu</label>
                                <input type="number" class="form-control" name="minOrderValue" min="0" value="${voucher.minOrderValue}">
                            </div>

                            <div class="mb-3">
                                <label for="editMaxDiscount" class="form-label">Giảm giá tối đa</label>
                                <input type="number" class="form-control" name="maxDiscount" min="0" value="${voucher.maxDiscount}">
                            </div>

                            <div class="mb-3">
                                <label for="editStartDate" class="form-label">Ngày bắt đầu</label>
                                <input type="datetime-local" class="form-control" name="startDate" value="${voucher.startDate}">
                            </div>

                            <div class="mb-3">
                                <label for="editEndDate" class="form-label">Ngày kết thúc</label>
                                <input type="datetime-local" class="form-control" id="editEndDate" name="endDate" value="${voucher.endDate}">
                            </div>

                            <div class="mb-3">
                                <label for="editVoucherActive" class="form-label">Trạng thái</label>
                                <select class="form-select" name="active" id="editVoucherActive">
                                    <option value="true" ${voucher.active ? 'selected' : ''} id="optionActive">Hoạt động</option>
                                    <option value="false" ${!voucher.active ? 'selected' : ''}>Không hoạt động</option>
                                </select>
                            </div>

                            <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                            <a href="<c:url value='/dashboard/admin/voucher'/>" class="btn btn-secondary" id="back">Trở về</a>
                        </form>

                        <script>
                            document.addEventListener("DOMContentLoaded", function () {
                                let inputs = document.querySelectorAll("input[type='number']");
                                inputs.forEach(input => {
                                    input.value = Math.floor(parseFloat(input.value) || 0); // Loại bỏ phần thập phân
                                });
                            });
                        </script>


                        <script>
                            document.getElementById("editVoucherForm").addEventListener("submit", function (event) {
                                event.preventDefault(); // Ngăn chặn submit mặc định

                                Swal.fire({
                                    title: "Xác nhận!",
                                    text: "Bạn có chắc muốn cập nhật thông tin mã giảm giá?",
                                    icon: "question",
                                    showCancelButton: true,
                                    confirmButtonText: "Đồng ý",
                                    cancelButtonText: "Hủy"
                                }).then((result) => {
                                    if (result.isConfirmed) {
                                        event.target.submit(); // Gửi form nếu người dùng xác nhận
                                    }
                                });
                            });
                        </script>

                        <script>
                            document.addEventListener("DOMContentLoaded", function () {
                                const discountPercentage = document.querySelector('input[name="discountPercentage"]');
                                const discountAmount = document.querySelector('input[name="discountAmount"]');
                                discountPercentage.addEventListener("input", function () {
                                    if (discountPercentage.value) {
                                        discountAmount.disabled = true;
                                    } else {
                                        discountAmount.disabled = false;
                                    }
                                });
                                discountAmount.addEventListener("input", function () {
                                    if (discountAmount.value) {
                                        discountPercentage.disabled = true;
                                    } else {
                                        discountPercentage.disabled = false;
                                    }
                                });
                            });
                        </script>

                        <script>
                            document.addEventListener("DOMContentLoaded", function () {
                                const discountPercentageInput = document.querySelector("input[name='discountPercentage']");
                                const discountAmountInput = document.querySelector("input[name='discountAmount']");
                                const maxDiscountInput = document.querySelector("input[name='maxDiscount']");
                                // Khi nhập phần trăm giảm giá
                                discountPercentageInput.addEventListener("input", function () {
                                    if (this.value) {
                                        discountAmountInput.value = 0; // Đặt số tiền giảm giá về 0
                                        maxDiscountInput.removeAttribute("readonly"); // Cho phép chỉnh sửa
                                    }
                                });
                                // Khi nhập số tiền giảm giá
                                discountAmountInput.addEventListener("input", function () {
                                    if (this.value > 0) {
                                        maxDiscountInput.value = this.value; // Giảm giá tối đa = Số tiền giảm giá
                                        maxDiscountInput.setAttribute("readonly", "true"); // Khóa chỉnh sửa
                                    } else {
                                        maxDiscountInput.value = ""; // Nếu xóa số tiền giảm giá thì bỏ khóa giảm giá tối đa
                                        maxDiscountInput.removeAttribute("readonly");
                                    }
                                });
                                // Khi chỉnh sửa giảm giá tối đa
                                maxDiscountInput.addEventListener("input", function () {
                                    if (discountPercentageInput.value) {
                                        discountAmountInput.value = 0; // Nếu đang có phần trăm giảm giá, số tiền giảm giá = 0
                                    }
                                });
                            });
                        </script>

                        <script>
                            document.addEventListener("DOMContentLoaded", function () {
                                const endDateInput = document.getElementById("editEndDate");
                                const activeOption = document.getElementById("optionActive");

                                function checkEndDate() {
                                    const selectedDate = new Date(endDateInput.value);
                                    const currentDate = new Date();

                                    if (selectedDate < currentDate) {
                                        activeOption.disabled = true; // Vô hiệu hóa tùy chọn "Hoạt động"
                                    } else {
                                        activeOption.disabled = false; // Cho phép chọn lại nếu hợp lệ
                                    }
                                }

                                endDateInput.addEventListener("change", checkEndDate);
                                checkEndDate(); // Kiểm tra ngay khi tải trang
                            });
                        </script>

                        <script>
                            document.addEventListener("DOMContentLoaded", function () {
                                // Lấy thông báo thành công từ session
                                var successMessage = "<c:out value='${sessionScope.successMessage}' />";
                                if (successMessage && successMessage.trim() !== "") {
                                    Swal.fire({
                                        icon: "success",
                                        title: "Thành công!",
                                        text: successMessage,
                                        confirmButtonText: "OK"
                                    });

                                    // Xóa session sau khi hiển thị
                                    fetch('clear-session.jsp');
                                }

                                // Lấy thông báo lỗi từ session
                                var errorMessage = "<c:out value='${sessionScope.errorMessage}' />";
                                if (errorMessage && errorMessage.trim() !== "") {
                                    Swal.fire({
                                        icon: "error",
                                        title: "Lỗi!",
                                        text: errorMessage,
                                        confirmButtonText: "OK"
                                    });

                                    // Xóa session sau khi hiển thị
                                    fetch('clear-session.jsp');
                                }
                            });

                        </script>

                        <%
                            session.removeAttribute("successMessage");
                            session.removeAttribute("errorMessage");
                        %>
                        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
                    </div>
                </div>
            </div>
        </div>


        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>

    </body>
</html>

