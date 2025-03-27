<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@include file="./components/header.jsp" %>


<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">       
        <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;600;800&display=swap" rel="stylesheet">
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="stylesheet" href="./css/productdetail.css">
        <title>${product.productName}</title>

    </head>

    <body>
        <script>
            (function () {
                if ((localStorage.getItem("isPagination") === "true" || localStorage.getItem("isRatingFilter") === "true")
                        && (localStorage.getItem("scrollPosition") || localStorage.getItem("ratingScrollPosition"))) {

                    let scrollTo = localStorage.getItem("isPagination") === "true"
                            ? localStorage.getItem("scrollPosition")
                            : localStorage.getItem("ratingScrollPosition");
                    window.scrollTo(0, parseInt(scrollTo));
                }
            })();
        </script>

        <div class="all">
            <div class="mt-4 bg-white p-3 mb-4 d-flex align-items-center justify-content-left" 
                 style="border-radius: 20px; height: 60px;">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0" style ="font-weight: bold;">
                        <li class="breadcrumb-item"><a href="pawfect" class="text-decoration-none">Trang chủ</a></li>
                        <li class="breadcrumb-item"><a href="/products?category=${product.categoryName}" class="text-decoration-none">${product.categoryName}</a></li>
                        <li class="breadcrumb-item active" aria-current="page" style="text-transform: uppercase;">
                            ${product.productName}
                        </li>
                    </ol>
                </nav>
            </div>
            <div class="container">
                <div class="product">
                    <div class="row">
                        <div class="col">
                            <div class="product-image-info">
                                <img src="/img/products/${product.productImage}" alt="${product.productName}">
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
                                    <div>
                                        <h4 class="thong-tin-san-pham">Thông tin sản phẩm</h4>
                                        <hr class="divider">
                                    </div>
                                    <p class="description">${product.description}</p>

                                    <div style="display: flex; align-items: center; gap: 10px;">
                                        <form onsubmit="return false;">
                                            <fieldset class="data-quantity" style="display: flex; align-items: center; border: none;">
                                                <button type="button" class="sub">−</button>
                                                <input type="number" class="input-number" min="1" value="1">
                                                <button type="button" class="add">+</button>
                                            </fieldset>
                                        </form>
                                        <p style="margin: 0;">${product.stock} có sẵn</p>
                                    </div>

                                    <c:if test="${product.stock > 0}">
                                        <div class="buttons">
                                            <button class="add-to-cart add-to-cart-nut nutnhan" data-product-id="${product.productId}" data-product-name="${product.productName}" data-product-stock="${product.stock}">
                                                <i class='bx bx-cart-add add-to-cart-logo'></i>
                                                THÊM VÀO GIỎ HÀNG
                                            </button>
                                            <button class="buy-now nutnhan" data-product-id="${product.productId}">MUA NGAY</button>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div>
                    <div class="review">
                        <h1 class="mb-4">Đánh giá - Nhận xét từ khách hàng</h1>

                        <!-- Rating Summary Section -->
                        <div class="rating-summary p-4 mb-4">
                            <div class="row align-items-center">
                                <div class="col-md-3 text-center mb-3 mb-md-0">
                                    <div class="rating-average">
                                        <fmt:formatNumber value="${averageStar > 0 ? averageStar : 0}" pattern="#0.0" />/5
                                    </div>
                                    <div class="stars my-2">
                                        <c:forEach var="i" begin="1" end="5">
                                            <c:choose>                                            
                                                <c:when test="${i <= averageStar}">
                                                    <i class="fas fa-star" style="color: #FFD43B;"></i>
                                                </c:when>

                                                <c:when test="${i - 1 < averageStar && i > averageStar}">
                                                    <i class="fas fa-star-half-alt" style="color: #FFD43B;"></i>
                                                </c:when>

                                                <c:otherwise>
                                                    <i class="far fa-star" style="color: #FFD43B;"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>


                                    </div>
                                    <div class="rating-count">(${totalFeedback} đánh giá)</div>
                                    <c:if test="${orderExist == true && feedbackExist == false}">
                                        <div class="mt-3">
                                            <button class="btn btn-primary"
                                                    data-bs-toggle="modal" data-bs-target="#feedbackModal"                   
                                                    >
                                                Gửi đánh giá của bạn
                                            </button>
                                        </div>
                                    </c:if>

                                </div>

                                <!-- Modal -->
                                <div class="modal fade" id="feedbackModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="feedbackModalLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <div class="modal-title fs-5" id="feedbackModalLabel">
                                                    <span>Đánh giá sản phẩm</span>
                                                    <h1><b>${product.productName}</b></h1>
                                                </div>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <form id="feedbackForm" action="/dashboard/staff/feedbackmanagement?action=feedback&filterRating=${param.rating}" method="post" enctype="multipart/form-data">
                                                <div class="modal-body">
                                                    <!-- Rating Stars -->
                                                    <div class="mb-3">
                                                        <label class="form-label">Đánh giá của bạn</label>
                                                        <div class="star-rating">
                                                            <i class="fas fa-star" data-rating="1"></i>
                                                            <i class="fas fa-star" data-rating="2"></i>
                                                            <i class="fas fa-star" data-rating="3"></i>
                                                            <i class="fas fa-star" data-rating="4"></i>
                                                            <i class="fas fa-star" data-rating="5"></i>
                                                        </div>
                                                        <input type="hidden" name="rating" id="rating-value" required>
                                                    </div>

                                                    <!-- Comment Textarea -->
                                                    <div class="form-floating mb-3">
                                                        <textarea name="comment" class="form-control" placeholder="Leave a comment here" id="customer-comment" style="height: 140px" required></textarea>
                                                        <label for="customer-comment">Nhập nội dung đánh giá của bạn</label>
                                                    </div>

                                                    <!-- Image Upload -->
                                                    <div class="mb-3">
                                                        <label class="form-label">Tải lên hình ảnh (tùy chọn)</label>
                                                        <div class="input-group custom-file-upload">
                                                            <input type="file" class="form-control" id="feedbackImage" name="feedbackImage" accept="image/*" hidden>
                                                            <button type="button" class="btn btn-outline-primary" id="upload-btn">
                                                                <i class="fas fa-camera"></i> Chọn ảnh
                                                            </button>
                                                            <span class="file-name ms-2" id="file-name">Chưa chọn ảnh</span>
                                                        </div>
                                                        <div class="image-preview mt-2" id="image-preview"></div>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" id="cancel-btn" data-bs-dismiss="modal">Hủy</button>
                                                    <button type="button" class="btn btn-primary" id="confirm-btn" data-product-id="${param.id}">
                                                        Gửi đánh giá
                                                    </button>
                                                </div>
                                                <input type="hidden" name="productId" id="productId" value="${param.id}">
                                            </form>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-9">
                                    <div class="d-flex flex-wrap gap-2">
                                        <a href="product?id=${param.id}&rating=tc" class="btn btn-outline-secondary btn-sm <c:if test="${param.rating == 'tc'}">active</c:if>">Tất cả</a>
                                        <a href="product?id=${param.id}&rating=5s" class="btn btn-outline-secondary btn-sm <c:if test="${param.rating == '5s'}">active</c:if>">5 Sao (${fiveStar})</a>
                                        <a href="product?id=${param.id}&rating=4s" class="btn btn-outline-secondary btn-sm <c:if test="${param.rating == '4s'}">active</c:if>">4 Sao (${fourStar})</a>
                                        <a href="product?id=${param.id}&rating=3s" class="btn btn-outline-secondary btn-sm <c:if test="${param.rating == '3s'}">active</c:if>">3 Sao (${threeStar})</a>
                                        <a href="product?id=${param.id}&rating=2s" class="btn btn-outline-secondary btn-sm <c:if test="${param.rating == '2s'}">active</c:if>">2 Sao (${twoStar})</a>
                                        <a href="product?id=${param.id}&rating=1s" class="btn btn-outline-secondary btn-sm <c:if test="${param.rating == '1s'}">active</c:if>">1 Sao (${oneStar})</a>
                                        <a href="product?id=${param.id}&rating=img" class="btn btn-outline-secondary btn-sm <c:if test="${param.rating == 'img'}">active</c:if>">Có hình ảnh (${haveImg})</a>
                                        </div>
                                    </div>
                                </div>

                            </div>


                            <div class="reviews-list">

                            <c:if test="${empty feedbacks}">
                                <div>
                                    <h5 style="color: #856404; text-align: center; background-color: #fff3cd; padding: 12px; border-radius: 5px; margin-top: 10px;">
                                        Không có đánh giá nào!
                                    </h5>
                                </div>
                            </c:if>

                            <c:forEach items="${feedbacks}" var="f" varStatus="loop">
                                <c:if test="${f.isVisible == true}">
                                    <!-- Review 1 (Example with employee response) -->
                                    <div class="review-item p-3 mb-3 feedback-item"
                                         style="<c:if test='${loop.index >= 4}'>display: none;</c:if>" >
                                        <div class="reviewer-name fw-bold">${f.customerName}</div>
                                        <div class="stars">
                                            <c:forEach var="i" begin="1" end="5">
                                                <c:choose>
                                                    <c:when test="${i <= f.rating}">
                                                        <i class="fas fa-star" style="color: #FFD43B;"></i>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="far fa-star" style="color: #FFD43B;"></i>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </div>
                                        <div class="mb-2">
                                            <span style="color: #95a5a6;">${f.feedbackDate}</span>
                                        </div>
                                        <p class="review-text">${f.comment}</p>

                                        <c:if test="${not empty f.imagePath}">
                                            <div class="mt-2">
                                                <img
                                                    src=".${f.imagePath}"
                                                    alt="Product review image"
                                                    style="width: 140px; height: 120px; object-fit: cover;"
                                                    />
                                            </div>
                                        </c:if>

                                        <c:if test="${not empty f.reply}">
                                            <!-- Employee Response -->
                                            <div class="employee-response mt-2">
                                                <div class="employee-name fw-bold">Nhân viên ${f.staffName}</div>
                                                <p class="response-text">${f.reply}</p>
                                            </div>
                                        </c:if>

                                    </div>
                                </c:if>
                            </c:forEach>                           
                        </div> 
                        <div style="text-align: center">
                            <!-- Nút Xem thêm -->
                            <button id="loadMore" class="btn btn-success"
                                    style="--bs-btn-padding-y: .45rem; --bs-btn-padding-x: 1.7rem; --bs-btn-font-size: 1.1rem;">
                                Xem thêm đánh giá
                            </button>
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
                            <c:if test="${product.productId != param.id}"> 
                                <c:if test="${loop.index >= start && loop.index < end}">
                                    <div class="col-md-4 col-6 mb-4 product-card">
                                        <div class="product-image">
                                            <img src="/img/products/${product.productImage}" alt="${product.productName}">
                                        </div>
                                        <div class="product-info">
                                            <a class="product-name" href="product?id=${product.productId}&rating=${param.rating}">${product.productName}</a>
                                            <p class="product-price">
                                                <fmt:formatNumber value="${product.productPrice}" pattern="#,##0" />đ
                                            </p>
                                            <a href="#">
                                                <button class="add-to-cart" data-product-id="${product.productId}" data-product-name="${product.productName}" data-product-stock="${product.stock}">
                                                    <i class="cart-icon"></i>
                                                    <input type="hidden" class="input-number" value="1">
                                                </button>
                                            </a>
                                        </div>
                                    </div>
                                </c:if>
                            </c:if>
                        </c:forEach>
                    </div> <!-- End of .row -->

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

    <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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
            const stock = ${product.stock}; // Lấy số lượng tồn kho từ JSP

            function updateButtonState() {
                let currentValue = parseInt(inputField.value);
                subButton.disabled = currentValue <= 1; // Nếu số lượng <= 1, vô hiệu hóa nút "-"
                addButton.disabled = currentValue >= stock; // Nếu số lượng >= stock, vô hiệu hóa nút "+"
            }

            subButton.addEventListener("click", function () {
                let currentValue = parseInt(inputField.value);
                if (currentValue > 1) {
                    inputField.value = currentValue - 1;
                }
                updateButtonState();
            });

            addButton.addEventListener("click", function () {
                let currentValue = parseInt(inputField.value);
                if (currentValue < stock) {
                    inputField.value = currentValue + 1;
                }
                updateButtonState();
            });

            // Kiểm tra khi nhập số lượng trực tiếp vào ô input
            inputField.addEventListener("input", function () {
                let value = parseInt(inputField.value);
                if (isNaN(value) || value < 1) {
                    inputField.value = 1; // Giá trị tối thiểu là 1
                } else if (value > stock) {
                    inputField.value = stock; // Không cho nhập quá số lượng tồn kho
                }
                updateButtonState();
            });

            // Cập nhật trạng thái nút ngay khi tải trang
            updateButtonState();
        });

    </script>

    <script>
        $('.add-to-cart').click(function (event) {
            event.preventDefault(); // Ngăn chặn hành động mặc định của thẻ <a>

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

            const stock = $(this).data('product-stock');
            const quantityToAdd = $('.input-number').val();
            $('.input-number').val(1);
            console.log("quantityToAdd:", quantityToAdd);
            let productId = $(this).data('product-id');
            console.log("productId:", productId);
            var productName = $(this).data('product-name');
            console.log("productName:", productName);
            var action = "add";
            var customerId = customerCookie; // ID của khách hàng (cần lấy từ session hoặc cookie)

            $.ajax({
                url: "cart",
                type: "POST",
                data: {
                    action: action,
                    productId: productId,
                    customerId: customerId,
                    stock: stock,
                    quantity: quantityToAdd
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


        $('.buy-now').click(function (event) {

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

            const stock = ${product.stock};
            const quantityToAdd = $('.input-number').val();
            let productId = $(this).data('product-id');
            console.log("productId:", productId);
            var action = "add";
            var customerId = customerCookie; // ID của khách hàng (cần lấy từ session hoặc cookie)

            $.ajax({
                url: "cart",
                type: "POST",
                data: {
                    action: action,
                    productId: productId,
                    customerId: customerId,
                    quantity: quantityToAdd,
                    stock: stock
                },
                dataType: "json",
                success: function (response) {
                    if (response.status === "success") {

                        console.log("Đã chuyển tới giỏ hàng!");
                        window.location.href = "cart?&action=view";

                    } else {
                        console.error("Lỗi mua ngay!!", response.message);
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

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // Lấy các phần tử DOM
            const stars = document.querySelectorAll('.star-rating .fa-star');
            const ratingInput = document.getElementById('rating-value');
            const uploadBtn = document.getElementById('upload-btn');
            const fileInput = document.getElementById('feedbackImage');
            const fileName = document.getElementById('file-name');
            const imagePreview = document.getElementById('image-preview');
            const confirmBtn = document.getElementById('confirm-btn');
            const cancelBtn = document.getElementById('cancel-btn');
            const feedbackModal = document.getElementById('feedbackModal');
            let selectedRating = 0;

            // Kiểm tra phần tử tồn tại
            if (!stars.length || !ratingInput || !uploadBtn || !fileInput || !fileName || !imagePreview || !confirmBtn || !cancelBtn || !feedbackModal) {
                console.error('Một hoặc nhiều phần tử không được tìm thấy');
                return;
            }

            // Xử lý sao đánh giá
            stars.forEach(star => {
                star.addEventListener('mouseover', () => highlightStars(star.getAttribute('data-rating')));
                star.addEventListener('mouseout', () => highlightStars(selectedRating));
                star.addEventListener('click', () => {
                    selectedRating = star.getAttribute('data-rating');
                    ratingInput.value = selectedRating;
                    highlightStars(selectedRating);
                });
            });

            function highlightStars(rating) {
                stars.forEach(star => {
                    star.classList.toggle('selected', star.getAttribute('data-rating') <= rating);
                });
            }

            // Xử lý upload ảnh
            uploadBtn.addEventListener('click', () => {
                console.log('Nút upload được nhấn');
                fileInput.click();
            });

            fileInput.addEventListener('change', function () {
                const file = this.files[0];
                console.log('File selected:', file);
                if (file) {
                    fileName.textContent = file.name;
                    const reader = new FileReader();
                    reader.onload = e => {
                        console.log('FileReader onload:', e.target.result.substring(0, 50) + '...');
                        const base64String = e.target.result;
                        const img = document.createElement('img');
                        img.src = base64String;
                        img.alt = 'Preview';
                        imagePreview.innerHTML = '';
                        imagePreview.appendChild(img);
                        imagePreview.classList.add('active');
                        console.log('Image preview display:', imagePreview.style.display);
                    };
                    reader.onerror = e => console.error('FileReader error:', e);
                    reader.readAsDataURL(file);
                } else {
                    resetImage();
                }
            });

            // Hàm reset toàn bộ modal
            function resetModal() {
                selectedRating = 0;
                ratingInput.value = '';
                highlightStars(0);
                document.getElementById("customer-comment").value = '';
                resetImage();
                console.log('Modal reset: sao, comment, và ảnh đã được xóa');
            }

            // Hàm reset ảnh
            function resetImage() {
                fileInput.value = '';
                fileName.textContent = 'Chưa chọn ảnh';
                imagePreview.innerHTML = '';
                imagePreview.classList.remove('active');
            }

            // Xử lý nút gửi đánh giá
            confirmBtn.addEventListener("click", function (event) {
                event.preventDefault();
                localStorage.setItem("scrollFeedback", window.scrollY);

                const customerId = getCookie("customerId");
                if (!customerId) {
                    showAlert("Bạn chưa đăng nhập!", "Vui lòng đăng nhập trước khi gửi đánh giá.", "warning");
                    return;
                }

                const commentContent = document.getElementById("customer-comment").value.trim();
                const ratingContent = ratingInput.value;
                const productId = confirmBtn.getAttribute("data-product-id");
                document.getElementById("productId").value = productId;

                if (!ratingContent) {
                    showAlert("Đánh giá không được để trống!", "Vui lòng chọn số sao trước khi gửi.", "error");
                    return;
                }

                if (!commentContent) {
                    showAlert("Nội dung đánh giá không được để trống!", "Vui lòng nhập nội dung trước khi gửi.", "error");
                    return;
                }

                Swal.fire({
                    title: "Xác nhận gửi?",
                    text: "Bạn có chắc chắn muốn gửi đánh giá này?",
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#3085d6",
                    cancelButtonColor: "#d33",
                    confirmButtonText: "Đồng ý!",
                    cancelButtonText: "Hủy!"
                }).then(result => {
                    if (result.isConfirmed) {
                        Swal.fire({
                            title: "Thành công!",
                            text: "Đánh giá đã được gửi.",
                            icon: "success",
                            allowOutsideClick: false, 
                            allowEscapeKey: false,
                            timer: 1500,
                            showConfirmButton: false
                        }).then(() => {
                            document.getElementById("feedbackForm").submit();
                        });
                    }
                });
            });

            // Xử lý nút Hủy và đóng modal
            cancelBtn.addEventListener("click", resetModal);
            feedbackModal.addEventListener('hidden.bs.modal', resetModal);

            // Hàm tiện ích lấy cookie
            function getCookie(name) {
                const cookies = document.cookie.split(';');
                for (let cookie of cookies) {
                    const [key, value] = cookie.trim().split('=');
                    if (key === name)
                        return value;
                }
                return null;
            }

            // Hàm tiện ích hiển thị Swal alert
            function showAlert(title, text, icon) {
                Swal.fire({title, text, icon, confirmButtonText: "OK"});
            }

            // Khôi phục vị trí cuộn
            const scrollFeedback = localStorage.getItem("scrollFeedback");
            if (scrollFeedback) {
                window.scrollTo(0, scrollFeedback);
                localStorage.removeItem("scrollFeedback");
            }
        });
    </script>

    <%-- Luu vi tri cuon trang khi chon option hien feedback san pham --%>
    <script>

        document.addEventListener("DOMContentLoaded", function () {
            // Lưu vị trí cuộn hiện tại khi click vào các liên kết lọc đánh giá
            const ratingFilterLinks = document.querySelectorAll('.rating-summary .btn-outline-secondary');
            ratingFilterLinks.forEach(link => {
                link.addEventListener('click', function (e) {
                    // Lưu vị trí cuộn hiện tại
                    localStorage.setItem("ratingScrollPosition", window.scrollY);
                    localStorage.setItem("isRatingFilter", "true");
                });
            });

            // Khôi phục vị trí cuộn sau khi trang được tải lại nếu đang lọc đánh giá
            if (localStorage.getItem("isRatingFilter") === "true" && localStorage.getItem("ratingScrollPosition")) {
                window.scrollTo(0, localStorage.getItem("ratingScrollPosition"));
                // Không xóa dữ liệu ngay lập tức để cho phép load hoàn tất
                setTimeout(function () {
                    localStorage.removeItem("ratingScrollPosition");
                    localStorage.removeItem("isRatingFilter");
                }, 100);
            }
        });
    </script>

    <%-- Xu ly xem them product feedback --%>
    <script>
        let initialFeedbacks = $(".feedback-item").length; // Tổng số feedback có sẵn
        let itemsToShow = 4; // Số feedback hiển thị ban đầu

        $(".feedback-item").slice(itemsToShow).hide(); // Ẩn feedback vượt quá số quy định

        // Ẩn nút "Xem thêm" nếu tổng feedback nhỏ hơn hoặc bằng itemsToShow
        if (initialFeedbacks <= itemsToShow) {
            $("#loadMore").hide();
        }


        $(document).ready(function () {
            $("#loadMore").click(function () {
                let hiddenFeedbacks = $(".feedback-item:hidden"); // Lấy feedback chưa hiển thị
                let itemsToShow = hiddenFeedbacks.slice(0, 4); // Lấy số feedback muốn hiển thị tiếp theo

                if (itemsToShow.length > 0) {
                    itemsToShow.fadeIn(); // Hiển thị chúng
                }

                if ($(".feedback-item:hidden").length === 0) {
                    $("#loadMore").hide(); // Ẩn nút nếu không còn feedback nào
                }
            });
        });
    </script>
</body>
</html>
