<%-- 
    Document   : petRoom
    Created on : Feb 11, 2025, 3:54:33 PM
    Author     : Nguyen Tien Thanh - CE181342
--%>

<%@page import="model.PetHotel"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@ page import="java.text.NumberFormat, java.util.Locale" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;600;800&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="../../css/dashboard.css">
        <title>Quản lý khách sạn thú cưng</title>
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
                                <h1>Quản lý khách sạn thú cưng</h1>
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
                                <li class="breadcrumb-item active" aria-current="page">Quản lý khách sạn thú cưng</li>
                            </ol>
                        </nav>
                    </div> 

                    <div class="row d-flex align-items-center" style="margin-top: 30px;">

                        <!-- Button Thêm Sản Phẩm -->
                        <div class="col-md-6">
                            <nav class="navbar navbar-light" style="background-color: #EEEEEE;">
                                <a href="createpethotel" class="btn btn-success">+ Tạo phòng thú cưng</a>
                            </nav>
                        </div>

                        <!-- Form Tìm Kiếm -->
                        <div class="col-md-6">
                            <form action="pethotel" method="get" class="d-flex mb-3 align-items-center" 
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

                    <!--                    <button class="btn btn-success" onclick="window.location.href = 'createpethotel'">
                                            <i class="fa fa-plus"></i> Thêm Phòng
                                        </button>-->




                    <div class="row" style="margin-top: 20px; margin-bottom: 50px;">
                        <div class="main-dashboard-table">
                            <div class="d-flex justify-content-center align-items-center gap-3 main-dashboard-table-header"
                                 style="background-color: #8C6E63; color: white; border-top-left-radius: 6px; border-top-right-radius: 6px;">                                                 
                                <i class="fa-solid fa-hotel fa-lg"></i>
                                <h4 class="mb-0">Danh sách phòng thú cưng</h4>
                            </div>

                            <div style="padding: 15px 15px 25px 15px;">
                                <table class="table table-hover">
                                    <thead class="table" style="text-align: center; vertical-align: middle; padding: 12px; font-weight: bold;">
                                        <tr>
                                            <th scope="col">Mã phòng</th>
                                            <th scope="col">Hình ảnh</th>
                                            <th scope="col">Tên phòng</th>
                                            <th scope="col">Loại</th>
                                            <th scope="col">Min (kg)</th>
                                            <th scope="col">Max (kg)</th>
                                            <th scope="col">Giá (VNĐ)</th>
                                            <!--                                            <th scope="col">Mô tả</th>-->
                                            <th scope="col">Số lượng</th>
                                            <th scope="col">Hiện trạng</th>
                                            <th scope="col">Trạng thái</th>
                                            <th scope="col">Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${not empty petRooms}">
                                                <c:forEach var="room" items="${petRooms}">
                                                    <tr>
                                                        <td style="text-align: center;">${room.roomId}</td>
                                                        <td style="text-align: center;">
                                                            <img src="<%= request.getContextPath()%>/img/pethotel/${room.roomImage}" alt="Hình ảnh phòng" style="width: 70px; height: auto; display: block; margin: auto;">
                                                        </td>                                                      
                                                        <td style="text-align: center;">${room.roomName}</td>
                                                        <td style="text-align: center;">${room.roomType}</td>
                                                        <td style="text-align: center;">${room.minWeight}</td>
                                                        <td style="text-align: center;">${room.maxWeight}</td>
                                                        <td style=" width: 8%; text-align: center;">
                                                            <fmt:formatNumber value="${room.pricePerNight}" type="number" maxFractionDigits="0"/>đ/Ngày
                                                        </td>
<!--                                                        <td style="text-align: left;">${room.description}</td>-->
                                                        <td style="text-align: center;">${room.quantity}</td>
                                                        <td style="width: 10%;">
                                                            <span style="padding: 5px; color: ${room.status eq 'Còn phòng' ? 'green' : 'red'};">
                                                                ${room.status}
                                                            </span>
                                                        </td>
                                                        <td style="width: 10%; text-align: center;">
                                                            <span style="padding: 5px; color: ${room.isActive ? 'green' : 'red'};">
                                                                ${room.isActive ? 'Còn hoạt động' : 'Ngừng hoạt động'}
                                                            </span>
                                                        </td>

                                                        <td>
                                                            <button type="button" class="btn btn-primary" onclick="editpethotel(${room.roomId})">Chỉnh sửa</button>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <tr>
                                                    <td colspan="10" class="text-center w-100">
                                                        <div class="alert alert-warning" role="alert">
                                                            Không có phòng nào được tìm thấy.
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:otherwise>
                                        </c:choose>
                                    </tbody>

                                </table>
                            </div>
                        </div>
                        <c:if test="${totalPages > 1}">
                            <nav aria-label="Page navigation">
                                <ul class="pagination justify-content-center">
                                    <!-- Nút Previous -->
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="javascript:updatePage(${currentPage - 1})">Trước</a>
                                    </li>

                                    <!-- Hiển thị danh sách số trang -->
                                    <c:forEach var="i" begin="1" end="${totalPages}">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="javascript:updatePage(${i})">${i}</a>
                                        </li>
                                    </c:forEach>

                                    <!-- Nút Next -->
                                    <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                                        <a class="page-link" href="javascript:updatePage(${currentPage + 1})">Tiếp</a>
                                    </li>
                                </ul>
                            </nav>
                        </c:if>
                    </div>  
                </div>
            </div>
        </div>
        <script>
            function editpethotel(roomId) {
                if (!roomId) {
                    alert("Lỗi: Không tìm thấy ID phòng!");
                    return;
                }
                // Chuyển trang đến editpethotel.jsp với roomId
                window.location.href = "editpethotel?roomId=" + roomId;
            }
        </script>

        <script>
            function updatePage(page) {
                let urlParams = new URLSearchParams(window.location.search);
                urlParams.set('page', page); // Cập nhật số trang
                localStorage.setItem("scrollPosition", window.scrollY); // Lưu vị trí cuộn
                window.location.search = urlParams.toString(); // Chuyển trang với số trang cập nhật
            }
        </script>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                let urlParams = new URLSearchParams(window.location.search);
                let storedPage = localStorage.getItem("currentPage");

                // Nếu không có `page` trên URL nhưng có trong `localStorage`, cập nhật lại URL
                if (!urlParams.has("page") && storedPage) {
                    urlParams.set("page", storedPage);
                    window.history.replaceState({}, '', `${window.location.pathname}?${urlParams.toString()}`);
                            }

                            // Cuộn về vị trí cũ sau khi load lại trang
                            let scrollPosition = localStorage.getItem("scrollPosition");
                            if (scrollPosition) {
                                window.scrollTo(0, scrollPosition);
                                localStorage.removeItem("scrollPosition"); // Xóa sau khi cuộn xong
                            }

                            // Lưu số trang và vị trí cuộn khi bấm vào các phần tử có thể thay đổi nội dung trang
                            document.querySelectorAll("a, button").forEach(element => {
                                element.addEventListener("click", function () {
                                    localStorage.setItem("currentPage", urlParams.get("page")); // Giữ trang hiện tại
                                    localStorage.setItem("scrollPosition", window.scrollY); // Lưu vị trí cuộn
                                });
                            });
                        });
        </script>


        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
                        document.addEventListener("DOMContentLoaded", function () {
                            // Kiểm tra trạng thái reload để tránh hiển thị lại thông báo sau khi đã reload
                            if (localStorage.getItem("reloaded") === "true") {
                                localStorage.removeItem("reloaded");
                                return;
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
                                    // Đánh dấu đã reload trong localStorage
                                    localStorage.setItem("reloaded", "true");
                                    // Xóa session và reload trang
                                    fetch('clear-session.jsp').then(() => {
                                        location.reload();
                                    });
                                });
                            }

                            // Lấy thông báo lỗi từ session
                            var errorMessage = "<c:out value='${sessionScope.errorMessage}' />";
                            if (errorMessage && errorMessage.trim() !== "") {
                                Swal.fire({
                                    icon: "error",
                                    title: "Lỗi!",
                                    text: errorMessage,
                                    confirmButtonText: "OK"
                                }).then(() => {
                                    fetch('clear-session.jsp'); // Xóa session lỗi
                                });
                            }
                        });
        </script>
        <%    session.removeAttribute("successMessage");
            session.removeAttribute("errorMessage");
        %>

        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    </body>
</html>
