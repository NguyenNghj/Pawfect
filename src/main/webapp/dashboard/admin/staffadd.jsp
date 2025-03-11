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

        <meta charset="UTF-8">
        <title>Thêm Nhân Viên Mới</title>
        <!-- Thêm Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <title>Thêm Nhân Viên</title>
        <style>
            
            
            /* Thiết kế cơ bản cho nút */
       .form-control {
    width: 100% !important; /* Giảm chiều rộng xuống 60% */
    display: block; /* Đảm bảo input không bị inline */
    margin: 0 auto; /* Căn giữa nếu cần */
}
.container {
    width: 70%; /* Thu nhỏ còn 60% màn hình */
    margin: 0 auto; /* Căn giữa form */
}

form {
    background: #f8f9fa; /* Màu nền nhẹ */
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
}

input, select, button {
    width: 100%; /* Để các ô nhập kéo dài theo form */
    margin-bottom: 10px;
    padding: 8px;
}

        </style>
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
                <div class="container mt-5">
                    <h2 class="text-center">Thêm Nhân Viên Mới</h2>

                    <div class="card">
                        <div class="card-body">
                            <form action="staffadd" method="post">
                          <div class="mb-3">
    <label class="form-label">Vai Trò</label>
    <select class="form-control" name="roleName">
        <option value="Admin" ${staff.roleName eq 'Admin' ? 'selected' : ''}>Admin</option>
        <option value="Staff" ${staff.roleName eq 'Staff' ? 'selected' : ''}>Staff</option>
    </select>
</div>


                                <div class="mb-3">
                                    <label class="form-label">Mật Khẩu</label>
                                    <input type="password" class="form-control" name="password" required>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Họ và Tên</label>
                                    <input type="text" class="form-control" name="fullName" required>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Email</label>
                                    <input type="email" class="form-control" name="email" required>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Số Điện Thoại</label>
                                    <input type="text" class="form-control" name="phone" required>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Địa Chỉ</label>
                                    <input type="text" class="form-control" name="address">
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Giới Tính</label>
                                    <select class="form-select" name="gender">
                                        <option value="Male">Nam</option>
                                        <option value="Female">Nữ</option>
                                        <option value="Others">Khác</option>
                                    </select>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Ngày Sinh</label>
                                    <input type="date" class="form-control" name="birthDate">
                                </div>
    <c:if test="${param.error eq 'underage'}">
    <div class="alert alert-danger">Nhân viên phải trên 16 tuổi!</div>
</c:if>

                                <div class="mb-3">
                                    <label class="form-label">Ảnh (URL)</label>
                                    <input type="text" class="form-control" name="image">
                                </div>

                                <button type="submit" class="btn btn-primary w-100">Thêm Nhân Viên</button>
                            </form>
                        </div>
                    </div>

                    <!-- Hiển thị thông báo -->
                    <c:if test="${not empty param.success}">
                        <div class="alert alert-success mt-3">Thêm nhân viên thành công!</div>
                    </c:if>

                    <c:if test="${not empty param.error}">
                        <div class="alert alert-danger mt-3">Thêm nhân viên thất bại. Vui lòng thử lại!</div>
                    </c:if>

                    <a href="accountStaff.jsp" class="btn btn-secondary mt-3">Quay lại danh sách nhân viên</a>
                </div>
            </div>
        </div>
         <!-- Thêm Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>



    </div>
</div>
</div>


<script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>

</body>
</html>

