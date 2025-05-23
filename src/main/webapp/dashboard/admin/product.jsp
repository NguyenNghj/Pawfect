<%-- 
    Document   : product
    Created on : Feb 11, 2025, 3:54:05 PM
    Author     : Vu Quang Duc - CE181221
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
        <title>Quản lý sản phẩm</title>
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
                                <h1>Quản lý sản phẩm</h1>
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
                                <li class="breadcrumb-item active" aria-current="page">Quản lý sản phẩm</li>
                            </ol>
                        </nav>
                    </div>   


                    <div class="row d-flex align-items-center" style="margin-top: 30px;">
                        <!-- Button Thêm Sản Phẩm -->
                        <div class="col-md-6">
                            <a href="/dashboard/admin/createproduct" class="btn btn-success">
                                <i class="fa-solid fa-plus"></i> Tạo sản phẩm
                            </a>
                        </div>

                        <!-- Form Tìm Kiếm -->

                        <div class="col-md-6">
                            <form action="product" method="get" class="d-flex mb-3 align-items-center" 
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
                                <i class="fa-solid fa-boxes-stacked fa-lg"></i>
                                <h4 class="mb-0">Danh sách sản phẩm</h4>
                            </div>
                            <div style="padding: 15px 15px 25px 15px;">
                                <div class="filter-section" style="margin-bottom: 15px;">
                                    <ul class="nav nav-tabs" id="priceFilterTabs">
                                        <li class="nav-item">
                                            <a class="nav-link ${empty param.priceRange || param.priceRange == 'all' ? 'active' : ''}" 
                                               href="javascript:filterProducts('all')" 
                                               style="font-weight: bold; border-width: 2px;">Tất cả</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link ${param.priceRange == 'under100k' ? 'active' : ''}" 
                                               href="javascript:filterProducts('under100k')" 
                                               style="font-weight: bold; border-width: 2px;">Dưới 100,000đ</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link ${param.priceRange == '100kto300k' ? 'active' : ''}" 
                                               href="javascript:filterProducts('100kto300k')" 
                                               style="font-weight: bold; border-width: 2px;">100,000đ - 300,000đ</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link ${param.priceRange == 'over300k' ? 'active' : ''}" 
                                               href="javascript:filterProducts('over300k')" 
                                               style="font-weight: bold; border-width: 2px;">Trên 300,000đ</a>
                                        </li>
                                    </ul>
                                </div>
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">Id</th>
                                            <th scope="col">Hình ảnh</th>
                                            <th scope="col">Thể loại</th>
                                            <th scope="col">Tên sản phẩm</th>
                                            <th scope="col">Dành cho</th>
                                            <th scope="col">Giá</th>
                                            <th scope="col">Tồn kho</th>
                                            <th scope="col">Trạng thái</th>
                                            <th scope="col">Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:set var="itemsPerPage" value="10" />
                                        <c:set var="totalProducts" value="${fn:length(productList)}" />
                                        <c:set var="totalPages" value="${(totalProducts + itemsPerPage - 1) / itemsPerPage}" />

                                        <!-- Ensure currentPage is set correctly -->
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

                                        <c:forEach var="product" items="${productList}" varStatus="loop">
                                            <c:if test="${loop.index >= start and loop.index < end}">
                                                <tr>
                                                    <th scope="row">${product.productId}</th>
                                                    <td><img src="/img/products/${product.productImage}" alt="Hình ảnh" width="50"></td>
                                                    <td>${product.categoryName}</td>
                                                    <td>${product.productName}</td>
                                                    <td>${product.productPetType}</td>
                                                    <td><fmt:formatNumber value="${product.productPrice}" type="number" maxFractionDigits="0"/>đ</td>
                                                    <td>${product.stock}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${product.active}">
                                                                <span class="text-success">Đang bán</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-danger">Ngừng bán</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <a href="/dashboard/admin/editproduct?productId=${product.productId}" class="btn btn-primary">Chỉnh sửa</a>
                                                    </td>
                                                </tr>
                                            </c:if>
                                        </c:forEach>
                                    </tbody>
                                </table>       
                                <c:if test="${empty productList}">                     
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
                        function updatePage(page) {
                            let urlParams = new URLSearchParams(window.location.search);
                            urlParams.set('page', page); // Cập nhật số trang
                            window.location.search = urlParams.toString();
                        }

                        function filterProducts(priceRange) {
                            // Lấy các tham số hiện tại từ URL
                            let urlParams = new URLSearchParams(window.location.search);

                            // Cập nhật hoặc thêm tham số priceRange
                            urlParams.set('priceRange', priceRange);

                            // Reset lại trang về 1 khi thay đổi bộ lọc
                            urlParams.set('page', '1');

                            // Chuyển hướng đến URL mới với các tham số đã cập nhật
                            window.location.search = urlParams.toString();
                        }
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

