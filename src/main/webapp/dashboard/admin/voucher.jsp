<%-- 
    Document   : voucher
    Created on : Mar 7, 2025, 9:23:18 PM
    Author     : Nguyen Tri Nghi - CE180897
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;600;800&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="../../css/dashboard.css">
        <title>Quản lý mã giảm giá</title>
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
                <div class="col-10" id="main" style="padding: 0 40px;">
                    <div class="row pt-4">
                        <div class="d-flex align-items-center justify-content-between" style="padding: 0;">
                            <div>
                                <h1>Quản lý mã giảm giá</h1>
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
                                                <a class="dropdown-item d-flex align-items-center gap-2" href="/dashboard/staff/viewcustomersforStaff">
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
                                <li class="breadcrumb-item">Quản trị viên</li>
                                <li class="breadcrumb-item active" aria-current="page">Quản lý mã giảm giá</li>
                            </ol>
                        </nav>
                    </div>     

                    <div class="row d-flex align-items-center" style="margin-top: 30px;">

                        <div class="col-md-6">
                            <a href="createvoucher" class="btn btn-success">
                                <i class="fa-solid fa-plus"></i> Tạo mã giảm 
                            </a>
                        </div>

                        <div class="col-md-6">
                            <form action="voucher" method="get" class="d-flex mb-3 align-items-center" 
                                  style="max-width: 400px; margin: 0 auto; border-radius: 25px; background: #f8f9fa; padding: 5px;">

                                <input type="search" name="search" class="form-control" id="inputName" placeholder="Nhập từ khóa..."

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
                                <i class="fa-solid fa-ticket"></i>
                                <h4 class="mb-0">Danh sách mã giảm giá</h4>
                            </div>

                            <div style="padding: 15px 15px 25px 15px;">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">Id</th>
                                            <th scope="col">Mã Voucher</th>
                                            <th scope="col">Giảm giá (%)</th>
                                            <th scope="col">Số tiền giảm</th>
                                            <th scope="col">Giá trị đơn tối thiểu</th>
                                            <th scope="col">Mức giảm tối đa</th>
                                            <th scope="col">Ngày bắt đầu</th>
                                            <th scope="col">Ngày kết thúc</th>
                                            <th scope="col">Trạng thái</th>
                                            <th scope="col">Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:set var="itemsPerPage" value="10" />
                                        <c:set var="totalVouchers" value="${fn:length(voucherList)}" />
                                        <c:set var="totalPages" value="${(totalVouchers + itemsPerPage - 1) / itemsPerPage}" />

                                        <c:set var="currentPage">
                                            <c:choose>
                                                <c:when test="${not empty param.page}">
                                                    ${param.page}
                                                </c:when>
                                                <c:otherwise>1</c:otherwise>
                                            </c:choose>
                                        </c:set>

                                        <c:set var="start" value="${(currentPage - 1) * itemsPerPage}" />
                                        <c:set var="end" value="${start + itemsPerPage}" />

                                        <c:forEach var="voucher" items="${voucherList}" varStatus="loop">
                                            <c:if test="${loop.index >= start and loop.index < end}">
                                                <tr>
                                                    <th scope="row">${voucher.voucherId}</th>
                                                    <td>${voucher.code}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${voucher.discountPercentage == 0}">
                                                                Giảm giá theo số tiền giảm
                                                            </c:when>
                                                            <c:otherwise>
                                                                ${voucher.discountPercentage}%
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${voucher.discountPercentage != 0}">
                                                                Giảm giá theo phần trăm đơn hàng
                                                            </c:when>
                                                            <c:otherwise>
                                                                <fmt:formatNumber value="${voucher.discountAmount}" type="number" maxFractionDigits="0"/>đ
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td><fmt:formatNumber value="${voucher.minOrderValue}" type="number" maxFractionDigits="0"/>đ</td>
                                                    <td><fmt:formatNumber value="${voucher.maxDiscount}" type="number" maxFractionDigits="0"/>đ</td>
                                                    <td>${voucher.startDate}</td>
                                                    <td>${voucher.endDate}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${voucher.active}">
                                                                <span class="text-success">Hoạt động</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-danger">Không hoạt động</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <a href="/dashboard/admin/editvoucher?voucherId=${voucher.voucherId}" class="btn btn-primary">Chỉnh sửa</a>
                                                    </td>
                                                </tr>
                                            </c:if>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <c:if test="${empty voucherList}">                     
                                    <div>
                                        <h5 style="color: #856404; text-align: center; background-color: #fff3cd; padding: 12px; border-radius: 5px; margin-top: 10px;">
                                            Không tìm thấy!
                                        </h5>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div> 
                    <c:if test="${totalPages > 1}">
                        <nav aria-label="Page navigation">
                            <ul class="pagination">
                                <!-- Nút Previous -->
                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="javascript:updatePage(${currentPage - 1})">Previous</a>
                                </li>

                                <!-- Hiển thị số trang -->
                                <c:forEach var="i" begin="1" end="${totalPages}">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="javascript:updatePage(${i})">${i}</a>
                                    </li>
                                </c:forEach>

                                <!-- Nút Next -->
                                <li class="page-item ${currentPage >= totalPages -1  ? 'disabled' : ''}">
                                    <a class="page-link" href="javascript:updatePage(${currentPage + 1})">Next</a>
                                </li>
                            </ul>
                        </nav>
                    </c:if>
                    <script>
                        function updatePage(page) {
                            let urlParams = new URLSearchParams(window.location.search);
                            urlParams.set('page', page); // Cập nhật số trang
                            window.location.search = urlParams.toString();
                        }
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


                    <script>
                        document.getElementById("sendVoucherToSelected").addEventListener("click", function () {
                            let selectedCustomers = [];
                            document.querySelectorAll(".voucherCheckbox:checked").forEach(function (checkbox) {
                                selectedCustomers.push(checkbox.value);
                            });

                            if (selectedCustomers.length === 0) {
                                Swal.fire({
                                    title: "Chưa chọn khách hàng!",
                                    text: "Vui lòng chọn ít nhất một khách hàng để gửi mã giảm giá.",
                                    icon: "warning",
                                    confirmButtonText: "OK"
                                });
                                return;
                            }

                            Swal.fire({
                            title: "Chọn mã giảm giá",
                                    input: "select",
                                    inputOptions: {
                        <c:forEach var="voucher" items="${vouchers}">
                                    "${voucher.code}": "${voucher.code} - ${voucher.discountAmount > 0 ? 'Giảm ' + voucher.discountAmount + 'đ' : 'Giảm ' + voucher.discountPercentage + '%'}",
                        </c:forEach>
                                                    },
                                                    inputPlaceholder: "Chọn mã giảm giá...",
                                            showCancelButton: true,
                                                    confirmButtonText: "Gửi",
                                                    cancelButtonText: "Hủy",
                                            }
                                            ).then((result) => {
                                            if (result.isConfirmed) {
                                                fetch("sendvoucherbulk", {
                                                    method: "POST",
                                                    headers: {"Content-Type": "application/json"},
                                                    body: JSON.stringify({customerIds: selectedCustomers, voucherCode: result.value})
                                                }).then(response => response.json())
                                                        .then(data => {
                                                            if (data.success) {
                                                                Swal.fire("Thành công!", "Gửi mã giảm giá thành công!", "success");
                                                            } else {
                                                                Swal.fire("Lỗi!", "Có lỗi xảy ra khi gửi mã giảm giá.", "error");
                                                            }
                                                        }).catch(error => {
                                                    Swal.fire("Lỗi!", "Không thể gửi yêu cầu đến server.", "error");
                                                });
                                                }
                                            }
                                            );
                                        });
                    </script>

                </div>
            </div>
        </div>  
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>

    </body>
</html>

