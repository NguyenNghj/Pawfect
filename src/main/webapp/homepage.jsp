<%-- 
    Document   : homepage
    Created on : Feb 25, 2025, 5:11:31 PM
    Author     : Nguyen Tri Nghi - CE180897
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@include file="./components/header.jsp" %>

<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">     
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;600;800&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">   
        <link rel="stylesheet" href="./css/homepage.css">
        <script src="./js/homepageProductFeedback.js"></script>
        <title>Document</title>
    </head>

    <body>

        <div class="container info">
            <div class="row">
                <div class="col-sm-8 left-info">
                    <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel" data-bs-interval="10000"
                         data-bs-pause="hover">
                        <div class="carousel-indicators">
                            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active"
                                    aria-current="true" aria-label="Slide 1"></button>
                            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1"
                                    aria-label="Slide 2"></button>
                            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2"
                                    aria-label="Slide 3"></button>
                        </div>
                        <div class="carousel-inner slide-hinhanh">
                            <div class="carousel-item active">
                                <img src="./img/homepage/slide1.png" class="d-block w-100" alt="...">
                            </div>
                            <div class="carousel-item">
                                <img src="./img/homepage/slide2.jpg" class="d-block w-100" alt="...">
                            </div>
                            <div class="carousel-item">
                                <img src="./img/homepage/slide3.jpg" class="d-block w-100" alt="...">
                            </div>
                        </div>
                        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators"
                                data-bs-slide="prev">
                            <span class="carousel-control-prev-icon out-infologo" aria-hidden="true"></span>
                            <span class="visually-hidden">Previous</span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators"
                                data-bs-slide="next">
                            <span class="carousel-control-next-icon out-infologo" aria-hidden="true"></span>
                            <span class="visually-hidden">Next</span>
                        </button>
                    </div>
                </div>

                <div class="col-sm-4 right-info">
                    <div>
                        <h2 style="font-weight: bold;">Theo dõi chúng tôi</h2>
                        <div class="all-inflogo">
                            <div class="out-infologo">
                                <i class='bx bxl-facebook infologo'></i>
                            </div>
                            <div class="out-infologo">
                                <i class='bx bxl-instagram infologo'></i>
                            </div>
                            <div class="out-infologo">
                                <i class='bx bxl-tiktok infologo'></i>
                            </div>
                        </div>
                    </div>

                    <h2 style="font-weight: bold;">Địa chỉ</h2>
                    <div class="contact">
                        <div class="out-infologo">
                            <i class='bx bx-location-plus infologo'></i>
                        </div>
                        <span class="diachi">600 Nguyễn Văn Cừ Nối Dài, An Bình, Bình Thủy, Cần Thơ</span>
                    </div>

                    <img class="infoimg" src="./img/homepage/chomeo.png" alt="">

                </div>
            </div>
        </div>

        <div class="pawfect">

            <div class="pawfect-text">PAWFECT</div>
            <div class="we-are">
                <h1 style="font-weight: bold;">Chúng tôi đơn giản là yêu thú cưng.</h1>
                <span class="dang-tim-kiem">
                    Bạn đang tìm kiếm một địa chỉ mua hàng và lưu trú chăm sóc thú cưng chuyên nghiệp tại Cần Thơ? <br>
                    PAWFECT chính là sự lựa chọn hoàn hảo dành cho bạn và “boss” nhà mình.
                </span>
            </div>

            <div class="chitiet">
                <p class=chitiet-hover>
                    <a>Chi tiết</a>
                </p>
            </div>

        </div>




        <div class="dich-vu-noi-bat">
            <div class="dich-vu-noi-bat-text">Dịch vụ nổi bật</div>

            <div class="dich-vu-noi-bat-chi-tiet">
                <a href="/products" class="chi-tiet-dich-vu">
                    <div class="dich-vu-box">
                        <i class='bx bx-purchase-tag-alt dich-vu-icon'></i>
                        <h3>Sản phẩm</h3>
                    </div>
                </a>

                <a href="/pethotel" class="chi-tiet-dich-vu">
                    <div class="dich-vu-box">
                        <i class='bx bx-notepad dich-vu-icon'></i>
                        <h3>Đặt lịch</h3>
                    </div>
                </a>
            </div>
        </div>



        <div class="motsohinhanh">

            <h4 class="motsohinhanh-text">Một số hình ảnh</h4>

            <div class="hinhanh">
                <div class="hinhanh-hang1">
                    <div class="hinhanhne">
                        <img src="./img/pethotel/dog/VIP/VIPdog1.jpg">
                    </div>
                    <div class="hinhanhne">
                        <img src="./img/pethotel/dog/VIP/VIPdog2.jpg">
                    </div>
                    <div class="hinhanhne">
                        <img src="./img/pethotel/dog/Luxury/Luxurydog1.jpg">
                    </div>
                </div>
                <div class="hinhanh-hang2">
                    <div class="hinhanhne">
                        <img src="./img/pethotel/dog/Luxury/Luxurydog2.jpg">
                    </div>
                    <div class="hinhanhne">
                        <img src="./img/pethotel/cat/Luxury/Luxurycat1.jpg">
                    </div>
                    <div class="hinhanhne">
                        <img src="./img/pethotel/cat/Luxury/Luxurycat2.jpg">
                    </div>
                </div>
            </div>
        </div>

        <div class="motsosanpham">
            <h4 class="motsosanpham-text">Một số sản phẩm</h4>
            <div class="container">
                <div class="row g-4"> 
                    <c:forEach var="product" items="${products}" varStatus="status" end="7">
                        <div class="col-lg-3 col-md-4 col-sm-6 col-12">
                            <div class="product-card">
                                <div class="product-image">
                                    <img src="${product.productImage}" alt="${product.productName}">
                                </div>
                                <div class="product-info">
                                    <a class="product-name" href="product?id=${product.productId}">${product.productName}</a>
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
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>



        <div class="phanhoi">
            <section class="reviews-section">
                <div class="container">
                    <div class="section-title">
                        <h2>Đánh giá từ khách hàng</h2>
                        <p>Phản hồi từ những khách hàng đã sử dụng dịch vụ</p>
                    </div>

                    <div class="carousel-container">
                        <div class="carousel-track" id="reviewsTrack">

                            <c:forEach items="${feedbacks}" var="f" begin="0" end="9">
                                <!-- Review Card 1 -->
                                <div class="review-card collapsed">
                                    <div class="customer-info">
                                        <!--<img src="https://randomuser.me/api/portraits/women/65.jpg" alt="Customer" class="customer-avatar">-->
                                        <div>
                                            <h4 class="customer-name">${f.customerName}</h4>
                                            <div class="customer-date">${f.feedbackDate}</div>
                                        </div>
                                    </div>
                                    <div>
                                        <h5>${f.productName}</h5>   
                                    </div>
                                    <div class="rating">
                                        <c:forEach var="i" begin="1" end="5">
                                            <c:choose>
                                                <c:when test="${i <= f.rating}">
                                                    <i class="fa-solid fa-star" style="color: #FFD43B;"></i>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fa-regular fa-star" style="color: #FFD43B;"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                        <span>(${f.rating})</span>
                                    </div>
                                    <div class="review-content">
                                        <p class="review-text">
                                            "${f.comment}"
                                        </p>

                                        <c:if test="${not empty f.reply}">
                                            <!-- Phan hoi cua nhan vien --> 
                                            <div class="staff-response">
                                                <div class="staff-header">
                                                    <img src="https://randomuser.me/api/portraits/women/28.jpg" alt="Staff" class="staff-avatar">
                                                    <div>
                                                        <h5 class="staff-name">NV ${f.staffName}</h5>
                                                        <div class="staff-position">Nhân viên cửa hàng</div>
                                                    </div>
                                                </div>
                                                <p class="staff-text">
                                                    "${f.reply}"
                                                </p>
                                            </div>
                                        </c:if>

                                        <button class="read-more-btn">
                                            <span class="btn-text">Đọc thêm</span>
                                            <i class="fas fa-chevron-down"></i>
                                        </button>
                                    </div>
                                </div>
                            </c:forEach>                                                     

                        </div>
                    </div>

                    <div class="navigation-buttons">
                        <button class="nav-button" id="prevBtn">
                            <i class="fas fa-arrow-left"></i>
                        </button>
                        <button class="nav-button" id="nextBtn">
                            <i class="fas fa-arrow-right"></i>
                        </button>
                    </div>
                </div>
            </section>
        </div>

        <div class="tieuchi mb-5">
            <div class="container">
                <div class="row tatcatieuchi">
                    <div class="col-md-3 col-6">
                        <div class="tieuchi-item">
                            <div class="tieuchi-icon">
                                <i class='bx bx-like'></i>
                            </div>
                            <span class="tieuchi-text">Chất Lượng</span>
                            <span>Chúng tôi luôn đảm bảo về chất lượng sản phẩm.</span>
                        </div>
                    </div>
                    <div class="col-md-3 col-6">
                        <div class="tieuchi-item">
                            <div class="tieuchi-icon">
                                <i class='bx bx-certification'></i>
                            </div>
                            <span class="tieuchi-text">Uy Tín</span>
                            <span>Chúng tôi luôn đặt uy tín lên hàng đầu</span>
                        </div>
                    </div>
                    <div class="col-md-3 col-6">
                        <div class="tieuchi-item">
                            <div class="tieuchi-icon">
                                <i class='bx bx-purchase-tag'></i>
                            </div>
                            <span class="tieuchi-text">Giá Hợp Lí</span>
                            <span>Giá cả luôn ở mức khách hàng hài lòng</span>
                        </div>
                    </div>
                    <div class="col-md-3 col-6">
                        <div class="tieuchi-item">
                            <div class="tieuchi-icon">
                                <i class='bx bx-home-heart'></i>
                            </div>
                            <span class="tieuchi-text">Tận Tâm</span>
                            <span>Yêu thương thú cưng và khách hàng như gia đình.</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script> 
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

                var productId = $(this).data('product-id');
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
                        quantity: "1"
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
                            alert("Lỗi: " + response.message);
                        }
                    },
                    error: function (error) {
                        console.error("Lỗi AJAX:", error);
                        alert("Lỗi kết nối đến server.");
                    }
                });
            });
        </script>
        
        <%@include file="./components/footer.jsp" %>
    </body>

</html>
