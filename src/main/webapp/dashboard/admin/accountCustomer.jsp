<%-- 
    Document   : accountCustomer
    Created on : Feb 11, 2025, 3:47:25 PM
    Author     : Vu Quang Duc - CE181221
--%>

<%@page import="model.Customers"%>
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
                %>
                <!-- MAIN -->
                <div class="col" id="main" style="padding: 0 40px;">
                    <div class="row pt-4">
                        <div class="d-flex align-items-center justify-content-between" style="padding: 0;">
                            <div>
                                <h1>Quản lý khách hàng</h1>
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
                                            <a class="dropdown-item" style="padding: 0;" href="/dashboard/staff/viewcustomersforStaff">Chuyển qua giao diện nhân viên</a>
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
                                <li class="breadcrumb-item">Bảng điều khiển</li>
                                <li class="breadcrumb-item">Quản trị viên</li>
                                <li class="breadcrumb-item active" aria-current="page">Quản lý khách hàng</li>
                            </ol>
                        </nav>
                    </div>   

                    <div class="row d-flex align-items-center" style="margin-top: 30px;">                        
                        <!-- Form Tìm Kiếm -->
                        <div class="col-md-6">
                            <form action="customers" method="get" class="d-flex mb-3 align-items-center" 
                                  style="max-width: 400px; border-radius: 25px; background: #f8f9fa; padding: 5px;">
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
                                            <th>Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            List<Customers> customerList = (List<Customers>) request.getAttribute("customerList");
                                            if (customerList != null) {
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
                                                <% if ("admin".equalsIgnoreCase(staffRole)) { %> 
                                                <% if (customer.isActive()) {%>
                                                <form action="customersban" method="get" onsubmit="return confirm('Bạn có chắc muốn cấm khách hàng này?');">
                                                    <input type="hidden" name="id" value="<%= customer.getCustomerId()%>">
                                                    <input type="hidden" name="action" value="ban">
                                                    <button type="submit" class="btn btn-danger">Cấm</button>

                                                </form>
                                                <% } else {%>
                                                <form action="customersban" method="get" onsubmit="return confirm('Bạn có chắc muốn gỡ cấm khách hàng này?');">
                                                    <input type="hidden" name="id" value="<%= customer.getCustomerId()%>">
                                                    <input type="hidden" name="action" value="unban">
                                                    <button type="submit" class="btn btn-primary"style="">Mở</button>
                                                </form>
                                                <% }%>

                                                <!-- Nút gửi mã giảm giá -->
                                                <form action="sendvoucher" method="post">
                                                    <input type="hidden" name="customerId" value="<%= customer.getCustomerId()%>">
                                                    <form action="sendDiscountCode" method="post">
                                                        <input type="hidden" name="customerId" value="<%= customer.getCustomerId()%>">
                                                    </form>
                                                </form>

                                                <% } else { %>
                                                <span class="text-muted">Không có quyền</span>
                                                <% } %>
                                            </td>

                                        </tr>
                                        <%
                                            }
                                        } else {%>
                                        <!-- Hiển thị thông báo nếu không tìm thấy khách hàng -->
                                    <div class="alert alert-warning text-center" role="alert">
                                        No customers found. Please try again with a different name.
                                    </div>
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

        <div class="modal fade" id="sendVoucherModal" tabindex="-1" aria-labelledby="sendVoucherModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="sendVoucherModalLabel">Gửi Mã Giảm Giá</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="sendVoucherForm" action="sendvoucher" method="post">
                            <input type="hidden" name="customerId" id="customerIdInput">

                            <div class="mb-3">
                                <label for="voucherCode" class="form-label">Chọn Voucher:</label>
                                <select class="form-control" id="voucherCode" name="voucherCode" required>
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

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                var sendVoucherModal = document.getElementById("sendVoucherModal");
                sendVoucherModal.addEventListener("show.bs.modal", function (event) {
                    var button = event.relatedTarget; // Button kích hoạt modal
                    var customerId = button.getAttribute("data-customer-id"); // Lấy customerId từ data attribute
                    document.getElementById("customerIdInput").value = customerId; // Gán vào input ẩn
                });
            });
        </script>


        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    </body>
</html>
