<%-- 
    Document   : productlist
    Created on : Feb 18, 2025, 10:42:31 AM
    Author     : Nguyen Tri Nghi - CE180897
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product List</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="./css/productlist.css">
    </head>
    <body>
        <ol class="breadcrumb">
            <li><a class="trang-chu" href="index.html">Trang chủ</a></li>
            <li>Sản phẩm</li>
        </ol>

        <div class="all">
            <h2>Sản phẩm</h2>

            <!-- Bộ lọc -->
            <div class="filter">
                <div class="gia-box-filter filterbox">
                    <label class="nut-loc" onclick="applyFilter('price', 1)">Dưới 100.000đ</label>
                    <label class="nut-loc" onclick="applyFilter('price', 2)">100.000đ - 300.000đ</label>
                    <label class="nut-loc" onclick="applyFilter('price', 3)">Trên 300.000đ</label>
                </div>

                <div class="kieu-box-filter filterbox">
                    <label class="nut-loc" onclick="applyFilter('sort', 1)">Tăng dần</label>
                    <label class="nut-loc" onclick="applyFilter('sort', 2)">Giảm dần</label>
                    <label class="nut-loc" onclick="applyFilter('sort', 3)">Chữ cái</label>
                </div>
            </div>

            <script>
                function applyFilter(filterName, filterValue) {
                    let urlParams = new URLSearchParams(window.location.search);

                    // Nếu đã chọn filter đó thì bỏ filter đi
                    if (urlParams.get(filterName) == filterValue) {
                        urlParams.delete(filterName);
                    } else {
                        urlParams.set(filterName, filterValue);
                    }

                    urlParams.set('page', 1); // Khi lọc, reset về trang 1
                    window.location.search = urlParams.toString();
                }
            </script>

            <div class="row">
                <div class="col-12 col-md-3 mb-4 category-container">
                    <div class="category-header">DANH MỤC SẢN PHẨM</div>
                    <ul class="category-list">
                        <c:forEach var="category" items="${categories}">
                            <li class="category-item" onclick="applyCategory('${category.categoryName}')">
                                ${category.categoryName}
                            </li>
                        </c:forEach>
                    </ul>
                </div>

                <script>
                    function applyCategory(category) {
                        let urlParams = new URLSearchParams(window.location.search);

                        // Nếu đã chọn category đó thì bỏ category đi
                        if (urlParams.get('category') == category) {
                            urlParams.delete('category');
                        } else {
                            urlParams.set('category', category);
                        }

                        urlParams.set('page', 1); // Khi đổi category, reset về trang 1
                        window.location.search = urlParams.toString();
                    }
                </script>

                <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        let urlParams = new URLSearchParams(window.location.search);

                        let selectedPrice = urlParams.get("price");
                        let selectedSort = urlParams.get("sort");
                        let selectedCategory = urlParams.get("category");

                        // Thêm class 'active' vào nút lọc giá
                        document.querySelectorAll(".gia-box-filter .nut-loc").forEach(label => {
                            let filterValue = label.getAttribute("onclick").match(/\d+/)[0]; // Lấy số từ onclick
                            if (selectedPrice === filterValue) {
                                label.classList.add("active");
                            }
                        });

                        // Thêm class 'active' vào nút lọc kiểu sắp xếp
                        document.querySelectorAll(".kieu-box-filter .nut-loc").forEach(label => {
                            let filterValue = label.getAttribute("onclick").match(/\d+/)[0]; // Lấy số từ onclick
                            if (selectedSort === filterValue) {
                                label.classList.add("active");
                            }
                        });

                        // Thêm class 'active' vào danh mục sản phẩm
                        document.querySelectorAll(".category-item").forEach(item => {
                            let categoryValue = item.textContent.trim();
                            if (selectedCategory && categoryValue === selectedCategory) {
                                item.classList.add("active");
                            }
                        });
                    });</script>


                <div class="col-12 col-md-9">
                    <div class="row row-20">
                        <c:set var="itemsPerPage" value="9" />
                        <c:set var="totalProducts" value="${fn:length(products)}" />
                        <c:set var="totalPages" value="${(totalProducts + itemsPerPage - 1) / itemsPerPage}" />

                        <c:set var="currentPage" value="${param.page != null ? param.page : 1}" />
                        <c:set var="start" value="${(currentPage - 1) * itemsPerPage}" />
                        <c:set var="end" value="${start + itemsPerPage}" />

                        <c:forEach var="product" items="${products}" varStatus="loop">
                            <c:if test="${loop.index >= start && loop.index < end}">
                                <div class="col-md-4 col-6 mb-4 product-card">
                                    <div class="product-image">
                                        <img src="https://katybpetcare.com/watermark/product/292x292x1/upload/product/1035d7d836e1c7c15f261bc83d59e15a-4771.jpeg" alt="${product.productName}">
                                    </div>
                                    <div class="product-info">
                                        <h3 class="product-name">${product.productName}</h3>
                                        <p class="product-price">
                                            <fmt:formatNumber value="${product.productPrice}" pattern="#,##0" />đ
                                        </p>
                                        <button class="add-to-cart">
                                            <i class="cart-icon"></i>
                                        </button>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>

                        <!-- PHÂN TRANG -->
                        <c:if test="${totalPages > 1}">
                            <nav aria-label="Page navigation">
                                <ul class="pagination">
                                    <c:set var="queryParams" value="category=${param.category}&sort=${param.sort}" />

                                    <!-- Nút Previous -->
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="?${queryParams}&page=${currentPage - 1}">Previous</a>
                                    </li>

                                    <!-- Hiển thị số trang -->
                                    <c:forEach var="i" begin="1" end="${totalPages}">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="?${queryParams}&page=${i}">${i}</a>
                                        </li>
                                    </c:forEach>

                                    <!-- Nút Next -->
                                    <li class="page-item ${currentPage >= (totalPages-1) ? 'disabled' : ''}">
                                        <a class="page-link" href="?${queryParams}&page=${currentPage + 1}">Next</a>
                                    </li>
                                </ul>
                            </nav>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
