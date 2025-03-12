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
        <title>JSP Page</title>
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
                                <h1>Chỉnh sửa thông tin mã giảm giá</h1>
                            </div>
                            <div class="dropdown d-flex align-items-center gap-2">
                                <span><%= staffName%></span>
                                <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <img class="profile-img" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTf74k9hxcTCkLN2gyhCr9lzuzZax5iy0uDOA&s" alt="">
                                </button>
                                <ul class="dropdown-menu ps-2 pe-2 pt-2 pb-2">
                                    <div class="d-grid gap-2">
                                        <li class="profile-img-switch-employee d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-repeat"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="/dashboard/staff/dashboard.jsp">Switch to employee</a>
                                        </li>
                                        <li class="profile-img-switch-store d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-store"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="#">Go to store</a>
                                        </li>
                                        <hr style="margin: 0;">
                                        <li class="profile-img-info1 d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-user-pen"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="adminprofile">Profile</a>
                                        </li>
                                        <li class="profile-img-info2 d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-right-from-bracket" style="font-size: 20px;"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="logoutadmin">Logout</a>
                                        </li>
                                    </div>
                                </ul>
                            </div>                                                              
                        </div>
                    </div>

                    <div class="row mt-2">
                        <nav style="--bs-breadcrumb-divider: '>'; padding: 0 5px;" aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item">Dashboard</li>
                                <li class="breadcrumb-item"><a href="/dashboard/admin/voucher">Quản lý mã giảm giá</a></li>
                                <li class="breadcrumb-item active" aria-current="page">${voucher.code}</li>
                            </ol>
                        </nav>
                    </div>   

                    <!--                    <div class="row">   
                                            <div class="col-3 p-0" style="margin-top: 60px;">
                                                <button type="button" class="btn btn-primary">
                                                    <i class="fa-solid fa-plus"></i>
                                                    New Product
                                                </button>
                                            </div>        
                                        </div>-->


                    <div class="row" style="margin-top: 20px; margin-bottom: 50px;">
                        <form id="editVoucherForm" action="/dashboard/admin/editvoucher" method="post">

                            <input type="hidden" name="voucherId" value="${voucher.voucherId}">

                            <div class="mb-3">
                                <label for="editVoucherCode" class="form-label">Mã giảm giá</label>
                                <input type="text" class="form-control" name="code" value="${voucher.code}" disable>
                            </div>

                            <div class="mb-3">
                                <label for="editVoucherDescription" class="form-label">Mô tả</label>
                                <textarea class="form-control" name="description" rows="3" required>${voucher.description}</textarea>
                            </div>

                            <div class="mb-3">
                                <label for="editDiscountPercentage" class="form-label">Phần trăm giảm giá</label>
                                <input type="number" class="form-control" name="discountPercentage" min="0" max="100" value="${voucher.discountPercentage}" required>
                            </div>

                            <div class="mb-3">
                                <label for="editDiscountAmount" class="form-label">Số tiền giảm giá</label>
                                <input type="number" class="form-control" name="discountAmount" min="0" value="${voucher.discountAmount}" required>
                            </div>

                            <div class="mb-3">
                                <label for="editMinOrderValue" class="form-label">Giá trị đơn hàng tối thiểu</label>
                                <input type="number" class="form-control" name="minOrderValue" min="0" value="${voucher.minOrderValue}" required>
                            </div>

                            <div class="mb-3">
                                <label for="editMaxDiscount" class="form-label">Giảm giá tối đa</label>
                                <input type="number" class="form-control" name="maxDiscount" min="0" value="${voucher.maxDiscount}" required>
                            </div>

                            <div class="mb-3">
                                <label for="editStartDate" class="form-label">Ngày bắt đầu</label>
                                <input type="datetime-local" class="form-control" name="startDate" value="${voucher.startDate}" required>
                            </div>

                            <div class="mb-3">
                                <label for="editEndDate" class="form-label">Ngày kết thúc</label>
                                <input type="datetime-local" class="form-control" name="endDate" value="${voucher.endDate}" required>
                            </div>

                            <div class="mb-3">
                                <label for="editVoucherActive" class="form-label">Trạng thái</label>
                                <select class="form-select" name="active">
                                    <option value="true" ${voucher.active ? 'selected' : ''}>Hoạt động</option>
                                    <option value="false" ${!voucher.active ? 'selected' : ''}>Không hoạt động</option>
                                </select>
                            </div>

                            <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                            <a href="<c:url value='/dashboard/admin/voucher'/>" class="btn btn-secondary" id="back">Trở về</a>
                        </form>

                        <script>
                            document.addEventListener("DOMContentLoaded", function () {
                                var errorMessage = "<c:out value='${errorMessage}' />";
                                if (errorMessage && errorMessage.trim() !== "") {
                                    Swal.fire({
                                        icon: "error",
                                        title: "Lỗi!",
                                        text: errorMessage,
                                        confirmButtonText: "OK"
                                    });
                                }
                            });
                        </script>


                        <script>
                            document.getElementById("editVoucherForm").addEventListener("submit", function (event) {
                                var startDate = new Date(document.querySelector("input[name='startDate']").value);
                                var endDate = new Date(document.querySelector("input[name='endDate']").value);

                                if (startDate > endDate) {
                                    event.preventDefault(); // Ngăn chặn form submit
                                    Swal.fire({
                                        icon: "error",
                                        title: "Lỗi!",
                                        text: "Ngày bắt đầu không thể lớn hơn ngày kết thúc.",
                                        confirmButtonText: "OK"
                                    });
                                }
                            });
                        </script>

                    </div>

                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>

    </body>
</html>

