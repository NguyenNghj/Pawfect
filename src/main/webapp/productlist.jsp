<%-- 
    Document   : productlist
    Created on : Feb 18, 2025, 10:42:31 AM
    Author     : Nguyen Tri Nghi - CE180897
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@include file="./components/header.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product List</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;600;800&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="./css/productlist.css">
    </head>
    <body>

        <div class="all">
            <div class="mt-4 bg-white p-3 mb-4 d-flex align-items-center justify-content-left" 
                 style="border-radius: 20px; height: 60px;">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0" style ="font-weight: bold;">
                        <li class="breadcrumb-item"><a href="pawfect" class="text-decoration-none">Trang chủ</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Danh sách sản phẩm</li>
                    </ol>
                </nav>
            </div>

            <h2 style = "margin: 0">Sản phẩm</h2>

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

                <div class="pettype-box-filter filterbox">
                    <label class="nut-loc" onclick="applyFilter('pettype', 1)">Chó</label>
                    <label class="nut-loc" onclick="applyFilter('pettype', 2)">Mèo</label>
                </div>
            </div>


            <script>
                function applyFilter(filterName, filterValue) {
                    let urlParams = new URLSearchParams(window.location.search);

                    if (filterName === "pettype") {
                        let selectedPetTypes = urlParams.get("pettype");

                        if (selectedPetTypes === filterValue.toString()) {
                            // Nếu đang chọn 1 hoặc 2 và bấm lần nữa → Xóa khỏi filter
                            urlParams.delete("pettype");
                        } else if (selectedPetTypes === "3") {
                            // Nếu đang chọn "3" (Chó + Mèo), bỏ bớt giá trị được click
                            selectedPetTypes = filterValue.toString();
                            urlParams.set("pettype", selectedPetTypes);
                        } else if (selectedPetTypes) {
                            // Nếu đang chọn 1 giá trị khác, chọn cả Chó và Mèo
                            urlParams.set("pettype", "3");
                        } else {
                            // Nếu chưa chọn gì, đặt giá trị được click
                            urlParams.set("pettype", filterValue.toString());
                        }
                    } else {
                        if (urlParams.get(filterName) === filterValue.toString()) {
                            urlParams.delete(filterName);
                        } else {
                            urlParams.set(filterName, filterValue);
                        }
                    }

                    urlParams.set('page', 1);
                    window.location.search = urlParams.toString();
                }

            </script>

            <div class="row">
                <div class="col-12 col-md-3 mb-4 category-container">
                    <div class="category-header">DANH MỤC SẢN PHẨM</div>
                    <ul class="category-list">
                        <c:forEach var="category" items="${categories}">
                            <!-- Check if category is active before rendering it -->
                            <c:if test="${category.active}">
                                <li class="category-item" onclick="applyCategory('${category.categoryName}')">
                                    ${category.categoryName}
                                </li>
                            </c:if>
                        </c:forEach>
                    </ul>
                </div>


                <script>
                    function applyCategory(category) {
                        let urlParams = new URLSearchParams(window.location.search);

                        // Nếu đã chọn category đó thì bỏ category đi
                        if (urlParams.get('category') === category) {
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
                        let selectedPetType = urlParams.get("pettype");

                        function toggleActive(selector, selectedValue) {
                            document.querySelectorAll(selector).forEach(label => {
                                let filterValue = label.getAttribute("onclick").match(/\d+/)[0]; // Lấy số từ onclick

                                if (selectedValue === filterValue) {
                                    label.classList.toggle("active"); // Toggle active
                                } else {
                                    label.classList.remove("active");
                                }
                            });
                        }

                        toggleActive(".gia-box-filter .nut-loc", selectedPrice);
                        toggleActive(".kieu-box-filter .nut-loc", selectedSort);

                        // Xử lý danh mục sản phẩm
                        document.querySelectorAll(".category-item").forEach(item => {
                            let categoryValue = item.textContent.trim();
                            if (selectedCategory && categoryValue === selectedCategory) {
                                item.classList.toggle("active");
                            } else {
                                item.classList.remove("active");
                            }
                        });

                        // Xử lý nhiều giá trị cho pettype
                        let selectedPetTypes = selectedPetType ? selectedPetType.split(",") : [];

                        document.querySelectorAll(".pettype-box-filter .nut-loc").forEach(label => {
                            let filterValue = label.getAttribute("onclick").match(/\d+/)[0];

                            if (selectedPetTypes.includes("3")) {
                                label.classList.add("active");
                            } else if (selectedPetTypes.includes(filterValue)) {
                                label.classList.toggle("active");
                            } else {
                                label.classList.remove("active");
                            }
                        });
                    });

                </script>



                <div class="col-12 col-md-9">
                    <div class="row row-20">
                        <c:set var="itemsPerPage" value="9" />
                        <c:set var="totalProducts" value="${fn:length(products)}" />
                        <c:set var="totalPages" value="${(totalProducts + itemsPerPage - 1) / itemsPerPage}" />

                        <c:set var="currentPage" value="${param.page != null ? param.page : 1}" />
                        <c:set var="start" value="${(currentPage - 1) * itemsPerPage}" />
                        <c:set var="end" value="${start + itemsPerPage}" />

                        <c:choose>
                            <c:when test="${empty products}">
                                <p style = "display: flex; justify-content: center; font-size: 20px;" >Không tìm thấy sản phẩm</p>                               
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="product" items="${products}" varStatus="loop">
                                    <c:if test="${loop.index >= start && loop.index < end}">
                                        <div class="col-md-4 col-6 mb-4 product-card">
                                            <div class="product-image">
                                                <img src="/img/products/${product.productImage}" alt="${product.productName}">
                                            </div>
                                            <div class="product-info">
                                                <a class="product-name" href="product?id=${product.productId}&rating=tc">${product.productName}</a>
                                                <p class="product-price">
                                                    <fmt:formatNumber value="${product.productPrice}" pattern="#,##0" />đ
                                                </p>
                                                <a href="#">
                                                    <button class="add-to-cart" data-product-id="${product.productId}"
                                                            data-product-name="${product.productName}"
                                                            data-product-stock="${product.stock}">
                                                        <i class="cart-icon"></i>
                                                    </button>
                                                </a>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>

                                <!-- PHÂN TRANG -->
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
                                            <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                                                <a class="page-link" href="javascript:updatePage(${currentPage + 1})">Next</a>
                                            </li>
                                        </ul>
                                    </nav>
                                </c:if>
                            </c:otherwise>
                        </c:choose>

                        <script>
                            function updatePage(page) {
                                let urlParams = new URLSearchParams(window.location.search);
                                urlParams.set('page', page); // Cập nhật số trang
                                window.location.search = urlParams.toString();
                            }
                        </script>

                    </div>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Khôi phục vị trí cuộn khi trang tải lại
                if (localStorage.getItem("scrollPosition")) {
                    window.scrollTo(0, localStorage.getItem("scrollPosition"));
                    localStorage.removeItem("scrollPosition"); // Xóa dữ liệu sau khi dùng để tránh lỗi cuộn không mong muốn
                }

                // Hàm lưu vị trí cuộn trước khi làm mới trang
                function saveScrollPosition() {
                    localStorage.setItem("scrollPosition", window.scrollY);
                }

                // Bắt sự kiện khi người dùng nhấn vào phân trang
                document.querySelectorAll(".pagination .page-link").forEach(link => {
                    link.addEventListener("click", saveScrollPosition);
                });

                // Bắt sự kiện khi người dùng nhấn vào bộ lọc hoặc sắp xếp
                document.querySelectorAll(".nut-loc, .category-item").forEach(button => {
                    button.addEventListener("click", saveScrollPosition);
                });
            });
        </script>

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

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script>

            $('.add-to-cart').click(function (event) {

                // Hàm lấy giá trị cookie theo tên
                function getCookie(name) {
                    event.preventDefault(); // Ngăn chặn hành động mặc định của thẻ <a>

                    let cookies = document.cookie.split("; ");
                    for (let i = 0; i < cookies.length; i++) {
                        let cookie = cookies[i].split("=");
                        if (cookie[0] === name) {
                            return cookie[1]; // Trả về giá trị cookie
                        }
                    }
                    return null;
                }

                // Kiểm tra xem cookie có tồn tại không (ví dụ: 'cartItems')
                let customerCookie = getCookie("customerId");

                if (!customerCookie) {
                    Swal.fire({
                        icon: "warning",
                        title: "Bạn chưa đăng nhập!",
                        text: "Bạn cần đăng nhập để thêm sản phẩm vào giỏ hàng."
                    });
                    return;
                }

                let stock = $(this).data('product-stock');
                let productId = $(this).data('product-id');
                console.log("productId:", productId);
                let productName = $(this).data('product-name');
                console.log("productName:", productName);
                let action = "add";
                let customerId = customerCookie; // ID của khách hàng (cần lấy từ session hoặc cookie)

                $.ajax({
                    url: "cart",
                    type: "POST",
                    data: {
                        action: action,
                        productId: productId,
                        customerId: customerId,
                        quantity: "1",
                        stock: stock
                    },
                    dataType: "json",
                    success: function (response) {
                        if (response.status === "success") {

                            $("#cart-count").text(response.totalQuantity); // Cập nhật phần tử trong header của bạn

                            console.log("Đã thêm sản phẩm vào giỏ hàng!");
                            Swal.fire({
                                position: "top-end",
                                icon: "success",
                                title: "Thêm giỏ hàng thành công!",
                                text: productName + " đã được thêm vào giỏ hàng.",
                                showConfirmButton: false,
                                backdrop: false,
                                width: '300px',
                                timer: 3000,
                                returnFocus: false
                            });
                        } else {
                            console.error("Lỗi thêm vào giỏ hàng:", response.message);
                            // Kiểm tra nếu lỗi là do vượt tồn kho
                            if (response.message === "Vượt quá tồn kho") {
                                Swal.fire({
                                    icon: "error",
                                    title: "Số lượng vượt quá tồn kho! Giỏ hàng hiện tại " + response.quantityFromCart,
                                    text: "Chỉ còn " + response.stock + " sản phẩm trong kho."
                                });
                            } else {
                                alert("Lỗi: " + response.message);
                            }
                        }
                    },
                    error: function (error) {
                        console.error("Lỗi AJAX:", error);
                        alert("Lỗi kết nối đến server.");
                    }
                });
            });
        </script>

    </body>
</html>

