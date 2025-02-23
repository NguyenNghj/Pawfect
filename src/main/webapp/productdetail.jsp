<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <link rel="stylesheet" href="css/productdetail.css">
        <title>${product.productName}</title>
    </head>

    <body>
        <ol class="breadcrumb">
            <li><a class="trang-chu" href="index.jsp">Trang chủ</a></li>
            <li>${product.categoryName}</li>
            <li>${product.productName}</li>
        </ol>

        <div class="all">
            <div class="container">
                <div class="product">
                    <div class="row">
                        <div class="col">
                            <div class="product-image-info">
                                <img src="${product.productImage}" alt="${product.productName}">
                            </div>
                        </div>
                        <div class="col">
                            <div class="full-thongtin">
                                <div class="phantren-thongtin">
                                    <h2 class="product-ten">${product.productName}</h2>
                                    <h4 class="product-price-info">Giá: <span class="price"><fmt:formatNumber value="${product.productPrice}" pattern="#,##0" />đ</span></h4>
                                    <h5 class="pettype">Dành cho ${product.productPetType}</h5>
                                    <h5 class="${product.stock > 0 ? 'stock-conhang' : 'stock-hethang'}">${product.stock > 0 ? 'Còn hàng' : 'Hết hàng'}</h5>
                                </div>

                                <div class="phanduoi-thongtin">
                                    <h4 class="thong-tin-san-pham">Thông tin sản phẩm</h4>
                                    <hr class="divider">
                                    <p class="description">${product.description}</p>

                                    <form>
                                        <fieldset class="data-quantity">
                                            <button type="button" class="sub">−</button>
                                            <input type="number" class="input-number" min="1" value="1">
                                            <button type="button" class="add">+</button>
                                        </fieldset>
                                    </form>

                                    <div class="buttons">
                                        <button class="add-to-cart-nut nutnhan"><i class='bx bx-cart-add add-to-cart-logo'></i> THÊM VÀO GIỎ HÀNG</button>
                                        <button class="buy-now nutnhan">MUA NGAY</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="san-pham-tuong-tu">
                    <h1 class="san-pham-tuong-tu-text">SẢN PHẨM TƯƠNG TỰ</h1>
                    <div class="row product-row">
                        <c:set var="itemsPerPage" value="3" />
                        <c:set var="totalProducts" value="${fn:length(productList)}" />
                        <c:set var="totalPages" value="${(totalProducts + itemsPerPage - 1) / itemsPerPage}" />

                        <c:set var="currentPage" value="${param.page != null ? param.page : 1}" />
                        <c:set var="start" value="${(currentPage - 1) * itemsPerPage}" />
                        <c:set var="end" value="${start + itemsPerPage}" />

                        <c:forEach var="product" items="${productList}" varStatus="loop">
                            <c:if test="${loop.index >= start && loop.index < end}">
                                <div class="col-md-4 col-6 mb-4 product-card">
                                    <div class="product-image">
                                        <img src="${product.productImage}" alt="${product.productName}">
                                    </div>
                                    <div class="product-info">
                                        <h3 class="product-name">${product.productName}</h3>
                                        <p class="product-price">
                                            <fmt:formatNumber value="${product.productPrice}" pattern="#,##0" />đ
                                        </p>
                                        <a href="#">
                                            <button class="add-to-cart" data-product-id="${product.productId}" data-product-name="${product.productName}">
                                                <i class="cart-icon"></i>
                                            </button>
                                        </a>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>

                        <c:if test="${totalPages > 1}">
                            <nav aria-label="Page navigation">
                                <ul class="pagination">
                                    <c:set var="queryParams" value="id=${param.id}" />

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
                                    <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                                        <a class="page-link" href="?${queryParams}&page=${currentPage + 1}">Next</a>
                                    </li>
                                </ul>
                            </nav>
                        </c:if>
                    </div>
                </div>
            </div>

            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    // Nếu là chuyển trang trong chi tiết sản phẩm, khôi phục vị trí cuộn
                    if (localStorage.getItem("scrollPosition") && localStorage.getItem("isPagination") === "true") {
                        window.scrollTo(0, localStorage.getItem("scrollPosition"));
                    }

                    // Xóa dữ liệu sau khi khôi phục để tránh lỗi khi quay lại trang trước
                    localStorage.removeItem("scrollPosition");
                    localStorage.removeItem("isPagination");

                    // Lưu vị trí cuộn khi nhấn phân trang trong trang chi tiết sản phẩm
                    document.querySelectorAll(".page-link").forEach(link => {
                        link.addEventListener("click", function () {
                            localStorage.setItem("scrollPosition", window.scrollY);
                            localStorage.setItem("isPagination", "true"); // Đánh dấu là phân trang
                        });
                    });

                    // Khi click vào sản phẩm trong danh sách (chuyển trang chi tiết), không lưu vị trí cuộn
                    document.querySelectorAll(".product-card a").forEach(link => {
                        link.addEventListener("click", function () {
                            localStorage.removeItem("scrollPosition"); // Xóa để luôn cuộn lên đầu
                            localStorage.removeItem("isPagination");
                        });
                    });
                });
            </script>

            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    const subButton = document.querySelector(".sub");
                    const addButton = document.querySelector(".add");
                    const inputField = document.querySelector("input[type='number']");

                    subButton.addEventListener("click", function () {
                        let currentValue = parseInt(inputField.value);
                        if (currentValue > 1) {
                            inputField.value = currentValue - 1;
                        }
                    });

                    addButton.addEventListener("click", function () {
                        let currentValue = parseInt(inputField.value);
                        inputField.value = currentValue + 1;
                    });
                });
            </script>
    </body>
</html>