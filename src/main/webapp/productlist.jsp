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
                            if (selectedPetTypes === "1") {
                                selectedPetTypes = "2"
                            } else {
                                selectedPetTypes = "1"
                            }
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
                                            <li class="page-item ${currentPage >= totalPages -1 ? 'disabled' : ''}">
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
                                showCloseButton: true,
                                backdrop: false,
                                width: '300px',
                                timer: 2500,
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
        <svg id="wave" style="transform:rotate(0deg); transition: 0.3s" viewBox="0 0 1440 100" version="1.1" xmlns="http://www.w3.org/2000/svg"><defs><linearGradient id="sw-gradient-0" x1="0" x2="0" y1="1" y2="0"><stop stop-color="rgba(140, 110, 99, 1)" offset="0%"></stop><stop stop-color="rgba(140, 110, 99, 1)" offset="100%"></stop></linearGradient></defs><path style="transform:translate(0, 0px); opacity:1" fill="url(#sw-gradient-0)" d="M0,0L40,13.3C80,27,160,53,240,55C320,57,400,33,480,31.7C560,30,640,50,720,58.3C800,67,880,63,960,53.3C1040,43,1120,27,1200,25C1280,23,1360,37,1440,36.7C1520,37,1600,23,1680,16.7C1760,10,1840,10,1920,11.7C2000,13,2080,17,2160,15C2240,13,2320,7,2400,8.3C2480,10,2560,20,2640,20C2720,20,2800,10,2880,15C2960,20,3040,40,3120,48.3C3200,57,3280,53,3360,56.7C3440,60,3520,70,3600,73.3C3680,77,3760,73,3840,61.7C3920,50,4000,30,4080,28.3C4160,27,4240,43,4320,51.7C4400,60,4480,60,4560,56.7C4640,53,4720,47,4800,38.3C4880,30,4960,20,5040,23.3C5120,27,5200,43,5280,50C5360,57,5440,53,5520,51.7C5600,50,5680,50,5720,50L5760,50L5760,100L5720,100C5680,100,5600,100,5520,100C5440,100,5360,100,5280,100C5200,100,5120,100,5040,100C4960,100,4880,100,4800,100C4720,100,4640,100,4560,100C4480,100,4400,100,4320,100C4240,100,4160,100,4080,100C4000,100,3920,100,3840,100C3760,100,3680,100,3600,100C3520,100,3440,100,3360,100C3280,100,3200,100,3120,100C3040,100,2960,100,2880,100C2800,100,2720,100,2640,100C2560,100,2480,100,2400,100C2320,100,2240,100,2160,100C2080,100,2000,100,1920,100C1840,100,1760,100,1680,100C1600,100,1520,100,1440,100C1360,100,1280,100,1200,100C1120,100,1040,100,960,100C880,100,800,100,720,100C640,100,560,100,480,100C400,100,320,100,240,100C160,100,80,100,40,100L0,100Z"></path><defs><linearGradient id="sw-gradient-1" x1="0" x2="0" y1="1" y2="0"><stop stop-color="rgba(140, 110, 99, 1)" offset="0%"></stop><stop stop-color="rgba(140, 110, 99, 1)" offset="100%"></stop></linearGradient></defs><path style="transform:translate(0, 50px); opacity:0.9" fill="url(#sw-gradient-1)" d="M0,20L40,25C80,30,160,40,240,45C320,50,400,50,480,41.7C560,33,640,17,720,20C800,23,880,47,960,50C1040,53,1120,37,1200,28.3C1280,20,1360,20,1440,16.7C1520,13,1600,7,1680,18.3C1760,30,1840,60,1920,70C2000,80,2080,70,2160,58.3C2240,47,2320,33,2400,31.7C2480,30,2560,40,2640,41.7C2720,43,2800,37,2880,40C2960,43,3040,57,3120,66.7C3200,77,3280,83,3360,81.7C3440,80,3520,70,3600,68.3C3680,67,3760,73,3840,68.3C3920,63,4000,47,4080,35C4160,23,4240,17,4320,15C4400,13,4480,17,4560,28.3C4640,40,4720,60,4800,58.3C4880,57,4960,33,5040,33.3C5120,33,5200,57,5280,68.3C5360,80,5440,80,5520,71.7C5600,63,5680,47,5720,38.3L5760,30L5760,100L5720,100C5680,100,5600,100,5520,100C5440,100,5360,100,5280,100C5200,100,5120,100,5040,100C4960,100,4880,100,4800,100C4720,100,4640,100,4560,100C4480,100,4400,100,4320,100C4240,100,4160,100,4080,100C4000,100,3920,100,3840,100C3760,100,3680,100,3600,100C3520,100,3440,100,3360,100C3280,100,3200,100,3120,100C3040,100,2960,100,2880,100C2800,100,2720,100,2640,100C2560,100,2480,100,2400,100C2320,100,2240,100,2160,100C2080,100,2000,100,1920,100C1840,100,1760,100,1680,100C1600,100,1520,100,1440,100C1360,100,1280,100,1200,100C1120,100,1040,100,960,100C880,100,800,100,720,100C640,100,560,100,480,100C400,100,320,100,240,100C160,100,80,100,40,100L0,100Z"></path><defs><linearGradient id="sw-gradient-2" x1="0" x2="0" y1="1" y2="0"><stop stop-color="rgba(140, 110, 99, 1)" offset="0%"></stop><stop stop-color="rgba(140, 110, 99, 1)" offset="100%"></stop></linearGradient></defs><path style="transform:translate(0, 100px); opacity:0.8" fill="url(#sw-gradient-2)" d="M0,50L40,50C80,50,160,50,240,50C320,50,400,50,480,41.7C560,33,640,17,720,13.3C800,10,880,20,960,23.3C1040,27,1120,23,1200,23.3C1280,23,1360,27,1440,36.7C1520,47,1600,63,1680,71.7C1760,80,1840,80,1920,81.7C2000,83,2080,87,2160,75C2240,63,2320,37,2400,23.3C2480,10,2560,10,2640,16.7C2720,23,2800,37,2880,35C2960,33,3040,17,3120,18.3C3200,20,3280,40,3360,53.3C3440,67,3520,73,3600,68.3C3680,63,3760,47,3840,43.3C3920,40,4000,50,4080,51.7C4160,53,4240,47,4320,45C4400,43,4480,47,4560,40C4640,33,4720,17,4800,21.7C4880,27,4960,53,5040,60C5120,67,5200,53,5280,43.3C5360,33,5440,27,5520,30C5600,33,5680,47,5720,53.3L5760,60L5760,100L5720,100C5680,100,5600,100,5520,100C5440,100,5360,100,5280,100C5200,100,5120,100,5040,100C4960,100,4880,100,4800,100C4720,100,4640,100,4560,100C4480,100,4400,100,4320,100C4240,100,4160,100,4080,100C4000,100,3920,100,3840,100C3760,100,3680,100,3600,100C3520,100,3440,100,3360,100C3280,100,3200,100,3120,100C3040,100,2960,100,2880,100C2800,100,2720,100,2640,100C2560,100,2480,100,2400,100C2320,100,2240,100,2160,100C2080,100,2000,100,1920,100C1840,100,1760,100,1680,100C1600,100,1520,100,1440,100C1360,100,1280,100,1200,100C1120,100,1040,100,960,100C880,100,800,100,720,100C640,100,560,100,480,100C400,100,320,100,240,100C160,100,80,100,40,100L0,100Z"></path><defs><linearGradient id="sw-gradient-3" x1="0" x2="0" y1="1" y2="0"><stop stop-color="rgba(140, 110, 99, 1)" offset="0%"></stop><stop stop-color="rgba(140, 110, 99, 1)" offset="100%"></stop></linearGradient></defs><path style="transform:translate(0, 150px); opacity:0.7" fill="url(#sw-gradient-3)" d="M0,40L40,43.3C80,47,160,53,240,61.7C320,70,400,80,480,81.7C560,83,640,77,720,61.7C800,47,880,23,960,23.3C1040,23,1120,47,1200,58.3C1280,70,1360,70,1440,70C1520,70,1600,70,1680,73.3C1760,77,1840,83,1920,76.7C2000,70,2080,50,2160,46.7C2240,43,2320,57,2400,53.3C2480,50,2560,30,2640,28.3C2720,27,2800,43,2880,55C2960,67,3040,73,3120,76.7C3200,80,3280,80,3360,66.7C3440,53,3520,27,3600,16.7C3680,7,3760,13,3840,25C3920,37,4000,53,4080,50C4160,47,4240,23,4320,20C4400,17,4480,33,4560,41.7C4640,50,4720,50,4800,50C4880,50,4960,50,5040,43.3C5120,37,5200,23,5280,28.3C5360,33,5440,57,5520,56.7C5600,57,5680,33,5720,21.7L5760,10L5760,100L5720,100C5680,100,5600,100,5520,100C5440,100,5360,100,5280,100C5200,100,5120,100,5040,100C4960,100,4880,100,4800,100C4720,100,4640,100,4560,100C4480,100,4400,100,4320,100C4240,100,4160,100,4080,100C4000,100,3920,100,3840,100C3760,100,3680,100,3600,100C3520,100,3440,100,3360,100C3280,100,3200,100,3120,100C3040,100,2960,100,2880,100C2800,100,2720,100,2640,100C2560,100,2480,100,2400,100C2320,100,2240,100,2160,100C2080,100,2000,100,1920,100C1840,100,1760,100,1680,100C1600,100,1520,100,1440,100C1360,100,1280,100,1200,100C1120,100,1040,100,960,100C880,100,800,100,720,100C640,100,560,100,480,100C400,100,320,100,240,100C160,100,80,100,40,100L0,100Z"></path></svg>
        <%@include file="./components/footer.jsp" %>
    </body>

</html>

