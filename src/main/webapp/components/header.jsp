<%-- 
    Document   : header
    Created on : Feb 11, 2025, 5:24:38 PM
    Author     : Vu Quang Duc - CE181221
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;600;800&display=swap">
        <link rel="stylesheet" href="./css/header.css">
    </head>

    <body>
        <header class="header-container">
            <div class="container-fluid">
                <div class="row align-items-center">
                    <!-- LOGO HEADER -->
                    <div class="col">
                        <a href="#">
                            <img class="logo-header" src="./img/header/logo.png" alt="PawPect Logo">
                        </a>
                    </div>

                    <!-- NAVIGATION -->
                    <div class="col-6">
                        <nav class="row content-header-menu align-items-center justify-content-center text-center">
                            <div class="col-auto">
                                <a class="btn" href="#">Về PawPect</a>
                            </div>
                            <div class="col-auto dropdown">
                                <a class="btn dropdown-toggle" href="#" role="button">Sản phẩm cho Chó</a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="#">Đồ ăn</a></li>
                                    <li><a class="dropdown-item" href="#">Phụ kiện</a></li>
                                    <li><a class="dropdown-item" href="#">Đồ chơi</a></li>
                                </ul>
                            </div>
                            <div class="col-auto dropdown">
                                <a class="btn dropdown-toggle" href="#" role="button">Sản phẩm cho Mèo</a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="#">Đồ ăn</a></li>
                                    <li><a class="dropdown-item" href="#">Phụ kiện</a></li>
                                    <li><a class="dropdown-item" href="#">Đồ chơi</a></li>
                                </ul>
                            </div>
                            <div class="col-auto">
                                <a class="btn" href="#">Khách sạn thú cưng</a>
                            </div>
                        </nav>
                    </div>

                    <!-- ICONS: Search, User, Cart -->
                    <div class="col d-flex justify-content-end align-items-center gap-3">
                        <a class="btn" href="#"><i class="bi bi-search"></i></a>
                        <div class="search-container">
                            <input type="text" id="search-box" class="search-box" placeholder="Nhập từ khóa cần tìm...">
                        </div>
                        <!-- USER ICON -->
                        <div class="dropdown">
                            <a class="btn" href="#" role="button" data-bs-toggle="dropdown">
                                <i class="fa-solid fa-circle-user fa-2xl"></i>
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item d-flex align-items-center gap-3" href="#"><i
                                            class="fa-solid fa-right-to-bracket"></i>Đăng nhập</a></li>
                                <li><a class="dropdown-item d-flex align-items-center gap-3" href="#"><i
                                            class="fa-solid fa-file-pen"></i>Đăng ký</a></li>
                            </ul>
                        </div>

                        <!-- CART ICON -->
                        <a class="cart-btn" href="cart?action=view">
                            <i class="bi bi-cart-fill cart-icon"></i>
                            <span class="cart-text">2 Items</span>
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
    </body>

</html>