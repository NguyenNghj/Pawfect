<%-- 
    Document   : accountCustomer
    Created on : Feb 11, 2025, 3:47:25 PM
    Author     : Vu Quang Duc - CE181221
--%>

<%@page import="model.Customers"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;600;800&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="../../css/dashboard.css">
        <title>Quản Lí Khách Hàng</title>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">

                <!-- SIDEBAR -->
                <jsp:include page="sidebar.jsp"/>


                <!-- MAIN -->
                <div class="col" id="main" style="padding: 0 40px;">
                    <div class="row pt-4">
                        <div class="d-flex align-items-center justify-content-between" style="padding: 0;">
                            <div>
                                <h1>Quản lí khách hàng</h1>
                                <%
                                    Cookie[] cookies = request.getCookies();
                                    String staffRole = "";
                                    String staffName = "";

                                    if (cookies != null) {
                                        for (Cookie cookie : cookies) {
                                            if ("staffRole".equals(cookie.getName())) {
                                                staffRole = cookie.getValue();
                                            } else if ("staffName".equals(cookie.getName())) {
                                                staffName = cookie.getValue();
                                            }

                                            if (!staffRole.isEmpty() && !staffName.isEmpty()) {
                                                break;
                                            }
                                        }
                                    }

                                    // Đặt vào request scope
                                    request.setAttribute("staffRole", staffRole);
                                    request.setAttribute("staffName", staffName);
                                %>
                            </div>

                            <c:choose>
                                <c:when test="${staffRole eq 'Admin'}">
                                    <div class="dropdown d-flex align-items-center gap-2">
                                        <span style="color: #D3A376; font-weight: bold;"><%= staffName%></span>
                                        <button class="btn dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                                            <img class="profile-img" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTf74k9hxcTCkLN2gyhCr9lzuzZax5iy0uDOA&s" alt="">
                                        </button>
                                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                            <li>
                                                <a class="dropdown-item d-flex align-items-center gap-2" href="/dashboard/admin/statistics">
                                                    <i class="fa-solid fa-repeat"></i> Chuyển qua giao diện quản lí
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="dropdown d-flex align-items-center gap-2">
                                        <span style = "color: #D3A376; font-weight: bold;"><%= staffName%></span>
                                        <a href="staffprofile">
                                            <button class="btn" type="button">
                                                <img class="profile-img" src="${staff.image}" alt="">
                                            </button>
                                        </a>
                                    </div>
                                </c:otherwise>
                            </c:choose>


                        </div>
                    </div>

                    <div class="row mt-2 bg-white p-3 d-flex align-items-center justify-content-center" 
                         style="border-radius: 20px; height: 60px;">
                        <nav style="--bs-breadcrumb-divider: '>'; padding: 0 5px;" aria-label="breadcrumb">
                            <ol class="breadcrumb mb-0" style ="font-weight: bold;">
                                <li class="breadcrumb-item">Bảng điều khiển</li>
                                <li class="breadcrumb-item">Nhân viên</li>
                                <li class="breadcrumb-item active" aria-current="page">Quản lí khách hàng</li>
                            </ol>
                        </nav>
                    </div>   

                    <div class="row d-flex align-items-center" style="margin-top: 30px;">

                        <!-- Nút gửi mã giảm giá chung -->
                        <div class="col-md-3 text-start">
                            <button class="btn btn-primary" id="sendVoucherToSelected">Gửi mã giảm giá</button>
                        </div>

                        <div class="col-md-3 text-start">
                            <button class="btn btn-success" id="sendVoucherBtn">Gửi mã giảm giá cho tất cả</button>
                        </div>

                        <!-- Form Tìm Kiếm -->
                        <div class="col-md-6 text-start">
                            <form action="viewcustomersforStaff" method="get" class="d-flex mb-3 align-items-center"
                                  style="max-width: 400px; border-radius: 25px; background: #f8f9fa; padding: 5px;">
                                <input type="text" name="search" class="form-control" placeholder="Nhập từ khóa..."
                                       style="flex: 1; border: none; outline: none; padding: 8px 12px; border-radius: 20px; font-size: 14px;">
                                <button type="submit" class="btn btn-primary"
                                        style="border-radius: 20px; padding: 6px 15px; font-size: 14px; font-weight: bold; background-color: #007bff; border: none; transition: 0.3s;">
                                    Tìm Kiếm
                                </button>
                            </form>
                        </div>

                    </div>

                    <div class="row" style="margin-top: 20px; margin-bottom: 50px;">
                        <div class="main-dashboard-table">
                            <div class="d-flex justify-content-center align-items-center gap-3 main-dashboard-table-header"
                                 style="background-color: #8C6E63; color: white; border-top-left-radius: 6px; border-top-right-radius: 6px;">
                                <i class="fa-solid fa-user-tie" style="font-size: 20px;"></i>
                                <h4 class="mb-0">Danh Sách Khách Hàng</h4>
                            </div>
                            <div style="padding: 15px;">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Họ và Tên</th>
                                            <th>Email</th>
                                            <th>Số điện thoại</th>
                                            <th>Địa chỉ</th>
                                            <th>Giới tính</th>
                                            <th>Ngày sinh</th>
                                            <th>Chọn gửi mã giảm giá</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            List<Customers> customerList = (List<Customers>) request.getAttribute("customerList");
                                            for (Customers customer : customerList) {
                                        %>
                                        <tr>
                                            <td><%= customer.getCustomerId()%></td>
                                            <td><%= customer.getFullName()%></td>
                                            <td><%= customer.getEmail()%></td>
                                            <td><%= customer.getPhone()%></td>
                                            <td><%= customer.getAddress()%></td>
                                            <td><%= customer.getGender()%></td>
                                            <td><%= customer.getBirthDate()%></td>
                                            <td>
                                                <% if (customer.isActive()) {%>
                                                <input type="checkbox" class="voucherCheckbox" value="<%= customer.getCustomerId()%>">
                                                <% } %>
                                            </td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                    </tbody>
                                </table>

                                <c:if test="${empty customerList}">
                                    <div>
                                        <h5 style="color: #856404; text-align: center; background-color: #fff3cd; padding: 12px; border-radius: 5px; margin-top: 10px;">
                                            Không tìm thấy!
                                        </h5>
                                    </div>
                                </c:if>

                            </div>
                        </div>
                    </div>


                </div>
            </div>
        </div>

        <!-- Modal Gửi Mã Giảm Giá (Danh Sách Chọn) -->
        <div class="modal fade" id="sendVoucherSelectedModal" tabindex="-1" aria-labelledby="sendVoucherSelectedLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="form-label" id="sendVoucherSelectedLabel" style = "color: black;">Gửi Mã Giảm Giá - Danh Sách Chọn</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="sendVoucherSelectedForm" action="sendvoucher" method="post">
                            <input type="hidden" name="customerIds" id="selectedCustomerIdsInput">
                            <div class="mb-3">
                                <label for="searchVoucher" class="form-label">Tìm kiếm Voucher:</label>
                                <input type="text" class="form-control" id="searchVoucherSelected" placeholder="Nhập mã hoặc giảm giá...">
                            </div>
                            <div class="mb-3">
                                <label for="voucherCodeSelected" class="form-label">Chọn Voucher:</label>
                                <select class="form-control" id="voucherCodeSelected" name="voucherCode" required>
                                    <option value="">-- Chọn voucher --</option>
                                    <c:forEach var="voucher" items="${vouchers}">
                                        <option value="${voucher.code}">
                                            ${voucher.code} - 
                                            <c:choose>
                                                <c:when test="${voucher.discountAmount > 0}">
                                                    Giảm ${voucher.discountAmount}đ
                                                </c:when>
                                                <c:when test="${voucher.discountPercentage > 0}">
                                                    Giảm ${voucher.discountPercentage}%
                                                </c:when>
                                            </c:choose>
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">Gửi Voucher</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>



        <!-- Modal Gửi Mã Giảm Giá (Tất Cả) -->
        <div class="modal fade" id="sendVoucherAllModal" tabindex="-1" aria-labelledby="sendVoucherAllLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="form-label" id="sendVoucherAllLabel" style = "color: black;">Gửi Mã Giảm Giá - Tất Cả Khách Hàng</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="sendVoucherAllForm" action="sendvoucher" method="post">
                            <input type="hidden" name="customerIds" id="allCustomerIdsInput">
                            <div class="mb-3">
                                <label for="searchVoucher" class="form-label">Tìm kiếm Voucher:</label>
                                <input type="text" class="form-control" id="searchVoucherAll" placeholder="Nhập mã hoặc giảm giá...">
                            </div>
                            <div class="mb-3">
                                <label for="voucherCodeAll" class="form-label">Chọn Voucher:</label>
                                <select class="form-control" id="voucherCodeAll" name="voucherCode" required>
                                    <option value="">-- Chọn voucher --</option>
                                    <c:forEach var="voucher" items="${vouchers}">
                                        <option value="${voucher.code}">
                                            ${voucher.code} - 
                                            <c:choose>
                                                <c:when test="${voucher.discountAmount > 0}">
                                                    Giảm ${voucher.discountAmount}đ
                                                </c:when>
                                                <c:when test="${voucher.discountPercentage > 0}">
                                                    Giảm ${voucher.discountPercentage}%
                                                </c:when>
                                            </c:choose>
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">Gửi Voucher</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>


        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script> 
        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Gửi mã giảm giá theo danh sách chọn
                document.getElementById("sendVoucherToSelected").addEventListener("click", function () {
                    let selectedCustomers = [];
                    document.querySelectorAll(".voucherCheckbox:checked").forEach(checkbox => {
                        selectedCustomers.push(checkbox.value);
                    });

                    if (selectedCustomers.length === 0) {
                        Swal.fire({
                            icon: "warning",
                            title: "Chưa chọn khách hàng!",
                            text: "Vui lòng chọn ít nhất một khách hàng để gửi mã giảm giá.",
                            confirmButtonText: "OK"
                        });
                        return;
                    }

                    // Gán danh sách ID vào input ẩn của modal "Danh Sách Chọn"
                    document.getElementById("selectedCustomerIdsInput").value = selectedCustomers.join(",");

                    // Mở modal "Danh Sách Chọn"
                    let sendVoucherSelectedModal = new bootstrap.Modal(document.getElementById('sendVoucherSelectedModal'));
                    sendVoucherSelectedModal.show();
                });

                // Gửi mã giảm giá cho tất cả khách hàng
                document.getElementById("sendVoucherBtn").addEventListener("click", function () {
                    let allCustomerIds = [];

                    // Lấy tất cả ID khách hàng từ bảng
                    document.querySelectorAll(".voucherCheckbox").forEach(checkbox => {
                        allCustomerIds.push(checkbox.value);
                    });

                    if (allCustomerIds.length === 0) {
                        Swal.fire({
                            icon: "warning",
                            title: "Không có khách hàng hợp lệ!",
                            text: "Không có khách hàng nào để gửi mã giảm giá.",
                            confirmButtonText: "OK"
                        });
                        return;
                    }

                    // Gán danh sách ID vào input ẩn của modal "Tất Cả"
                    document.getElementById("allCustomerIdsInput").value = allCustomerIds.join(",");

                    // Mở modal "Tất Cả"
                    let sendVoucherAllModal = new bootstrap.Modal(document.getElementById('sendVoucherAllModal'));
                    sendVoucherAllModal.show();
                });
            });
        </script>


        <script>
            document.addEventListener("DOMContentLoaded", function () {
                document.querySelectorAll(".sendVoucherBtn").forEach(button => {
                    button.addEventListener("click", function () {
                        let customerId = this.getAttribute("data-customer-id");
                        document.getElementById("customerIdInput").value = customerId;
                    });
                });
            });
        </script>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                function setupSearch(searchInputId, selectId) {
                    let searchInput = document.getElementById(searchInputId);
                    let selectVoucher = document.getElementById(selectId);

                    if (!searchInput || !selectVoucher)
                        return;

                    let defaultOption = selectVoucher.querySelector("option[value='']");

                    searchInput.addEventListener("input", function () {
                        let searchValue = this.value.toLowerCase();
                        let voucherOptions = selectVoucher.querySelectorAll("option:not([value=''])");

                        let hasMatch = false;
                        voucherOptions.forEach(option => {
                            let text = option.textContent.toLowerCase();
                            if (text.includes(searchValue)) {
                                option.style.display = "block";
                                hasMatch = true;
                            } else {
                                option.style.display = "none";
                            }
                        });

                        defaultOption.style.display = "block";

                        // Mở dropdown nếu có kết quả
                        if (hasMatch) {
                            selectVoucher.size = Math.min(5, voucherOptions.length + 1);
                        } else {
                            selectVoucher.size = 1;
                        }
                    });

                    selectVoucher.addEventListener("change", function () {
                        this.size = 1;
                    });
                }

                setupSearch("searchVoucherSelected", "voucherCodeSelected");
                setupSearch("searchVoucherAll", "voucherCodeAll");
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

    </body>
</html>