<%-- 
    Document   : productlist
    Created on : Feb 18, 2025, 10:42:31 AM
    Author     : Nguyen Tri Nghi - CE180897
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.net.URLEncoder" %>
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
            <li>
                <a class="trang-chu" href="index.html">Trang chủ</a>
            </li>
            <li>Sản phẩm</li>
        </ol>

        <div class="all">
            <h2> 
                Sản phẩm
            </h2>

            <div class="filter">
                <div class="gia-box-filter filterbox">
                    <label class="nut-loc" onclick="applyFilter('mucgia', 1)">Dưới 100.000đ</label>
                    <label class="nut-loc" onclick="applyFilter('mucgia', 2)">100.000đ - 300.000đ</label>
                    <label class="nut-loc" onclick="applyFilter('mucgia', 3)">Trên 300.000đ</label>
                </div>

                <div class="kieu-box-filter filterbox">
                    <label class="nut-loc" for="tang-dan" onclick="applyFilter('sapxep', 1)">Tăng dần</label>
                    <label class="nut-loc" for="giam-dan" onclick="applyFilter('sapxep', 2)">Giảm dần</label>
                    <label class="nut-loc" for="chu-cai" onclick="applyFilter('sapxep', 3)">Chữ cái</label>
                </div>

            </div>

            <script>
                function applyFilter(filterName, filterValue) {
                    let urlParams = new URLSearchParams(window.location.search);

                    // Update the filter parameter in the URL
                    urlParams.set(filterName, filterValue);

                    // Get the current category filter if any
                    let currentCategory = urlParams.get('danhmuc');

                    // Append the category filter if it exists
                    if (currentCategory) {
                        urlParams.set('danhmuc', currentCategory);
                    }

                    // Redirect to the new URL with the updated parameters
                    window.location.search = urlParams.toString();
                }
            </script>

            <div class="row">
                <div class="col-12 col-md-3 mb-4 category-container">
                    <div class="category-header">DANH MỤC SẢN PHẨM</div>
                    <ul class="category-list">
                        <c:forEach var="category" items="${categories}">
                            <li class="category-item" onclick="window.location.href = '?danhmuc=${category.categoryName}'">
                                ${category.categoryName}
                            </li>
                        </c:forEach>
                    </ul>
                </div>

                <div class="col-12 col-md-9">
                    <div class="row row-20">
                        <c:forEach var="product" items="${products}">
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
                        </c:forEach>
                    </div>

                </div>
            </div>

      

        </div>


    </body>
</html>
