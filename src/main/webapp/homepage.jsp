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
        <title>PawFect</title>
    </head>

    <body>
        <%
            String message = (String) session.getAttribute("message");
            String messageType = (String) session.getAttribute("messageType");
            if (message != null) {
        %>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            Swal.fire({
                position: "top-end",
                icon: '<%= "success".equals(messageType) ? "success" : "error"%>',
                title: "<%= message%>",
                showConfirmButton: false,
                timer: 1000
            });
        </script>
        <%
                session.removeAttribute("message");
                session.removeAttribute("messageType");
            }
        %>
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

        <section class="section-wave">
            <div class="wave wave1"></div>
            <div class="wave wave2"></div>
            <div class="wave wave3"></div>
            <div class="wave wave4"></div>
        </section>

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
                                    <img src="/img/products/${product.productImage}" alt="${product.productName}">
                                </div>
                                <div class="product-info">
                                    <a class="product-name" href="product?id=${product.productId}&rating=tc">${product.productName}</a>
                                    <p class="product-price">
                                        <fmt:formatNumber value="${product.productPrice}" pattern="#,##0" />đ
                                    </p>
                                    <a href="#">
                                        <button class="add-to-cart"
                                                data-product-id="${product.productId}"
                                                data-product-name="${product.productName}"
                                                data-product-stock="${product.stock}">
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
<!--                                        <img src="https://randomuser.me/api/portraits/women/65.jpg" alt="Customer" class="customer-avatar">-->
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

                const stock = $(this).data('product-stock');
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
                        stock: stock,
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
