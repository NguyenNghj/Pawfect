<%-- 
    Document   : header
    Created on : Feb 11, 2025, 5:24:38 PM
    Author     : Vu Quang Duc - CE181221
--%>

<%@page import="dao.CategoryDAO"%>
<%@page import="model.Category"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;600;800&display=swap">
        <link rel="stylesheet" href="./css/header.css">
    </head>

    <body>              
        <header class="header-container">
            <div class="container-fluid">
                <div class="row align-items-center">
                    <!-- LOGO HEADER -->
                    <div class="col-auto">
                        <a href="pawfect">
                            <img class="logo-header" src="./img/header/logo.png" alt="PawPect Logo">
                        </a>
                    </div>

                    <!-- NAVIGATION -->
                    <%
                        CategoryDAO categoryDAO = new CategoryDAO();
                        List<Category> categories = categoryDAO.getAllActiveCategories();
                    %>

                    <!-- NAVIGATION -->
                    <div class="col-6 col-lg">
                        <nav class="row content-header-menu align-items-center justify-content-center text-center">
                            <div class="col-auto">
                                <a class="btn" href="aboutus.jsp">Về PawPect</a>
                            </div>

                            <!-- Dropdown Sản phẩm cho Chó -->
                            <div class="col-auto dropdown">
                                <a class="btn dropdown-toggle" href="products?pettype=1&page=1" role="button" data-bs-toggle="dropdown" aria-expanded="false" id="dropdownMenuLinkDog">
                                    Sản phẩm cho Chó
                                </a>


                                <ul class="dropdown-menu">
                                    <%
                                        for (Category category : categories) {
                                    %>
                                    <li>
                                        <a class="dropdown-item" href="products?pettype=1&page=1&category=<%= category.getCategoryName()%>">
                                            <%= category.getCategoryName()%>
                                        </a>
                                    </li>
                                    <%
                                        }
                                    %>
                                </ul>
                            </div>

                            <!-- Dropdown Sản phẩm cho Mèo -->
                            <div class="col-auto dropdown">
                                <a class="btn dropdown-toggle" href="products?pettype=2&page=1" role="button" data-bs-toggle="dropdown" aria-expanded="false" id="dropdownMenuLinkCat">
                                    Sản phẩm cho Mèo
                                </a>
                                <script>
                                    // Select both elements by their IDs
                                    const dropdownLinks = ['dropdownMenuLinkCat', 'dropdownMenuLinkDog'];

                                    // Loop through each element and add event listeners
                                    dropdownLinks.forEach(function (linkId) {
                                        document.getElementById(linkId).addEventListener('click', function (e) {
                                            e.preventDefault(); // Ngừng hành động mặc định của thẻ <a>
                                            const dropdown = new bootstrap.Dropdown(this); // Kích hoạt dropdown thủ công
                                            dropdown.toggle(); // Đổi trạng thái dropdown
                                        });
                                    });
                                </script>


                                <ul class="dropdown-menu">
                                    <%
                                        for (Category category : categories) {
                                    %>
                                    <li>
                                        <a class="dropdown-item" href="products?pettype=2&page=1&category=<%= category.getCategoryName()%>">
                                            <%= category.getCategoryName()%>
                                        </a>
                                    </li>
                                    <%
                                        }
                                    %>
                                </ul>
                            </div>

                            <div class="col-auto">
                                <a class="btn" href="pethotel">Khách sạn thú cưng</a>
                            </div>
                        </nav>
                    </div>


                    <script>
                        document.addEventListener("DOMContentLoaded", function () {
                            document.querySelectorAll(".btn.dropdown-toggle").forEach(function (button) {
                                button.addEventListener("click", function (event) {
                                    // Kiểm tra nếu dropdown đang mở thì ngăn điều hướng
                                    if (this.nextElementSibling && this.nextElementSibling.classList.contains("show")) {
                                        event.preventDefault(); // Ngăn chặn hành vi mặc định
                                    } else {
                                        // Chuyển hướng đến URL trong href
                                        window.location.href = this.getAttribute("href");
                                    }
                                });
                            });
                        });
                    </script>

                    <!-- ICONS: Search, User, Cart -->
                    <div class="col-auto d-flex justify-content-end align-items-center gap-3">
                        <a class="btn" href="#"><i class="bi bi-search"></i></a>
                        <div class="search-container">
                            <input type="text" id="search-box" class="search-box" placeholder="Nhập từ khóa cần tìm...">
                        </div>

                        <script>
                            document.getElementById("search-box").addEventListener("keypress", function (event) {
                                if (event.key === "Enter") {
                                    let keyword = this.value.trim();
                                    if (keyword) {
                                        window.location.href = "/products?search=" + encodeURIComponent(keyword);
                                    }
                                }
                            });

                        </script>

                        </scrip>
                        <!-- USER ICON -->
                        <%
                            String username = null;
                            Cookie[] cookies = request.getCookies();
                            if (cookies
                                    != null) {
                                for (Cookie cookie : cookies) {
                                    if ("customerId".equals(cookie.getName())) {
                                        username = cookie.getValue();
                                        break;
                                    }
                                }
                            }
                        %>

                        <div class="dropdown">
                            <a class="btn" href="#" role="button" data-bs-toggle="dropdown">
                                <i class='bx bxs-user-circle'></i>
                            </a>
                            <ul class="dropdown-menu">
                                <% if (username
                                            != null) { %>
                                <li><a class="dropdown-item d-flex align-items-center gap-3" href="profile">
                                        <i class="bx bxs-user-detail"></i> Thông tin
                                    </a></li>
                                <li><a class="dropdown-item d-flex align-items-center gap-3" href="logout">
                                        <i class="bx bx-log-out"></i> Đăng xuất
                                    </a></li>
                                    <% } else { %>
                                <li><a class="dropdown-item d-flex align-items-center gap-3" href="login">
                                        <i class="bx bxs-key"></i> Đăng nhập
                                    </a></li>
                                <li><a class="dropdown-item d-flex align-items-center gap-3" href="register">
                                        <i class="bx bx-lock-alt"></i> Đăng ký
                                    </a></li>
                                    <% }%>
                            </ul>
                        </div>

                        <!-- CART ICON -->
                        <a class="cart-btn" href="cart?action=view" id="cartLink">
                            <i class="bi bi-cart-fill cart-icon"></i>
                            <span id="cart-count" class="cart-text">
                                <c:choose>
                                    <c:when test="${empty totalQuantity}">
                                        0
                                    </c:when>
                                    <c:otherwise>
                                        ${totalQuantity} 
                                    </c:otherwise>
                                </c:choose>

                            </span>
                            &nbsp;<span class="cart-text">Items</span>
                        </a>
                    </div>
                </div>
            </div>
        </header>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const searchButton = document.querySelector(".bi-search");
                const searchContainer = document.querySelector(".search-container");

                searchButton.addEventListener("click", function (event) {
                    event.stopPropagation(); // Ngăn chặn sự kiện lan ra ngoài
                    searchContainer.style.display = searchContainer.style.display === "block" ? "none" : "block";
                });

                // Khi nhấn ra ngoài ô tìm kiếm và nút search thì ẩn ô tìm kiếm
                document.addEventListener("click", function (event) {
                    if (!searchContainer.contains(event.target) && !searchButton.contains(event.target)) {
                        searchContainer.style.display = "none";
                    }
                });
            });
        </script>

        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <script>
            document.getElementById("cartLink").addEventListener("click", function (event) {
                // Hàm lấy giá trị cookie theo tên
                function getCookie(name) {
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
                let cartCookie = getCookie("customerId");

                if (!cartCookie) {
                    event.preventDefault(); // Ngăn chặn chuyển hướng
                    Swal.fire({
                        icon: "warning",
                        title: "Bạn chưa đăng nhập!",
                        text: "Bạn cần đăng nhập để sử dụng giỏ hàng."
                    });
                }
            });
        </script>
    </body>

</html>