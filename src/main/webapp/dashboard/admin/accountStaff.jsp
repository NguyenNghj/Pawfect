<%-- 
    Document   : createcategory
    Created on : Mar 1, 2025, 6:00:11 PM
    Author     : Nguyen Tri Nghi - CE180897
--%>

<%@page import="model.Staff"%>
<%@page import="model.Staff"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;600;800&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="../../css/dashboard.css">
        <title>Quản Lí Nhân Viên</title>

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
                                <h1>Quản Lý Nhân Viên</h1>
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

                    <div class="row mt-2 bg-white p-3 d-flex align-items-center justify-content-center" 
                         style="border-radius: 20px; height: 60px;">
                        <nav style="--bs-breadcrumb-divider: '>'; padding: 0 5px;" aria-label="breadcrumb">
                            <ol class="breadcrumb mb-0" style ="font-weight: bold;">
                                <li class="breadcrumb-item">Dashboard</li>
                                <li class="breadcrumb-item active" aria-current="page">Quản lí nhân viên</li>
                            </ol>
                        </nav>
                    </div>         

                    <div class="row d-flex align-items-center" style="margin-top: 30px;">
                        <!-- Button Thêm Sản Phẩm -->
                        <div class="col-md-6">
                            <nav class="navbar navbar-light" style="background-color: #EEEEEE;">
                                <a href="staffadd" class="btn btn-success">+ Thêm Nhân Viên</a>
                            </nav>
                        </div>

                        <!-- Form Tìm Kiếm -->
                        <div class="col-md-6">
                            <form action="staff" method="get" class="d-flex mb-3 align-items-center" 
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
                    <!-- Hiển THị List -->

                    <div class="row" style="margin-top: 20px; margin-bottom: 50px;">
                        <div class="main-dashboard-table">
                            <div class="d-flex justify-content-center align-items-center gap-3 main-dashboard-table-header"
                                 style="background-color: #8C6E63; color: white; border-top-left-radius: 6px; border-top-right-radius: 6px;">
                                <i class="fa-solid fa-address-card"></i>
                                <h4 class="mb-0">Danh Sách Nhân Viên</h4>
                            </div>
                            <div style="padding: 15px 15px 25px 15px;">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Vai trò</th>
                                            <th>Mật khẩu</th>
                                            <th>Họ và Tên</th>
                                            <th>Email</th>
                                            <th>SDT</th>
                                            <th>Địa chỉ</th>
                                            <th>Giới tính</th>
                                            <th>Ngày sinh</th>
                                            <th>Trạng Thái</th> 
                                            <th>Hành động</th> <!-- Thêm cột này -->
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            List<Staff> staffList = (List<Staff>) request.getAttribute("staffList");

                                            for (Staff staff : staffList) {
                                        %>
                                        <tr>
                                            <td><%= staff.getStaffId()%></td>
                                            <td><%= staff.getRoleName()%></td>
                                            <td><%= staff.getPassword()%></td>
                                            <td><%= staff.getFullName()%></td>
                                            <td><%= staff.getEmail()%></td>
                                            <td><%= staff.getPhone()%></td>
                                            <td><%= staff.getAddress()%></td>
                                            <td><%= staff.getGender()%></td>
                                            <td><%= staff.getBirthDate()%></td>
                                            <td><%= staff.isActive() ? "Hoạt động" : "Đã nghỉ"%></td>
                                            <td>
                                                <a href="editstaff?staffId=<%= staff.getStaffId()%>" 
                                                   style="display: inline-block; padding: 5px 10px; font-size: 12px; background-color: #007bff;
                                                   color: white; text-decoration: none; border-radius: 3px; font-weight: bold; transition: 0.3s;">
                                                    Chỉnh Sửa
                                                </a>

                                            </td>

                                        </tr>
                                        <%
                                            }

                                        %>
                                    </tbody>
                                </table>
                                <c:if test="${empty staffList}">                     
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
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Lấy thông báo lỗi từ request
                var errorMessage = "<c:out value='${errorMessage}' />";
                if (errorMessage && errorMessage.trim() !== "") {
                    Swal.fire({
                        icon: "error",
                        title: "Lỗi!",
                        text: errorMessage,
                        confirmButtonText: "OK"
                    });
                }

                // Lấy thông báo thành công từ session
                var successMessage = "<c:out value='${sessionScope.successMessage}' />";
                if (successMessage && successMessage.trim() !== "") {
                    Swal.fire({
                        icon: "success",
                        title: "Thành công!",
                        text: successMessage,
                        confirmButtonText: "OK"
                    }).then(() => {
                        fetch('clear-session.jsp'); // Xóa session sau khi hiển thị
                    });
                }
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
        <%            session.removeAttribute("successMessage");
            session.removeAttribute("errorMessage");
        %>
        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>

    </body>
</html>

