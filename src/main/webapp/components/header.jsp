<%-- 
    Document   : header
    Created on : Feb 11, 2025, 5:24:38 PM
    Author     : Vu Quang Duc - CE181221
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="<%= request.getContextPath() %>/css/header.css">
        <title>JSP Page</title>
    </head>
    <body>
        <header>
            <div class="container-fluid">
                <div class="row align-items-center">
                    <!-- LOGO HEADER -->
                    <div class="col-2">
                        <a href="">
                            <img class="logo-header" src="../images/logos/Logo.png" alt="">
                        </a>
                    </div>
                    <!-- CONTENT HEADER -->
                    <div class="col">
                        <div class="row align-items-center content-header-all-icon">
                            <div class="col-7">
                                <form class="d-flex align-items-center position-relative" style="width: 96%;" role="search">
                                    <input class="form-control" type="search" placeholder="Search" aria-label="Search">
                                    <i class="content-header-search-icon fa-solid fa-magnifying-glass position-absolute"></i>
                                </form>
                            </div>                       
                            <!-- HOTLINE -->
                            <div class="col-auto d-flex align-items-center gap-3">
                                <i class="fa-solid fa-phone-volume fa-shake fa-2xl"></i>
                                <div style="color: white;">
                                    <b class="d-grid">
                                        <span>Hotline:</span>
                                        <span>0123456789</span>
                                    </b>
                                </div>
                            </div>
                            <!-- USER ICON -->
                            <div class="col-auto d-flex justify-content-end">                     
                                <div class="dropdown dropdown2">
                                    <a class="btn" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                        <i class="fa-solid fa-circle-user fa-2xl"></i>
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu2">
                                        <li>                                
                                            <a class="dropdown-item d-flex align-items-center gap-3" href="#">
                                                <i class="fa-solid fa-right-to-bracket "></i>
                                                <span>Login</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item d-flex align-items-center gap-3" href="#">
                                                <i class="fa-solid fa-file-pen"></i>
                                                <span>Register</span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>

                            <!-- CART ICON -->
                            <div class="col-auto">
                                <a class="btn" href="#" role="button">
                                    <i class="fa-brands fa-opencart fa-2xl"></i>
                                </a>                     
                            </div>
                        </div>

                        <div class="row content-header-menu align-items-center mt-4">
                            <div class="col-auto">
                                <a class="btn" href="#" role="button">Về PawPect</a>
                            </div>
                            <div class="col-auto">
                                <div class="dropdown">
                                    <a class="btn dropdown-toggle" href="#" role="button">
                                        Sản phẩm cho Chó
                                    </a>
                                    <ul class="dropdown-menu">
                                        <li><a class="dropdown-item" href="#">Action</a></li>
                                        <li><a class="dropdown-item" href="#">Another action</a></li>
                                        <li><a class="dropdown-item" href="#">Something else here</a></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="col-auto">
                                <div class="dropdown">
                                    <a class="btn dropdown-toggle" href="#" role="button">
                                        Sản phẩm cho Mèo
                                    </a>
                                    <ul class="dropdown-menu">
                                        <li><a class="dropdown-item" href="#">Action</a></li>
                                        <li><a class="dropdown-item" href="#">Another action</a></li>
                                        <li><a class="dropdown-item" href="#">Something else here</a></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="col-auto">
                                <a class="btn" href="#" role="button">Khách sạn thú cưng</a>
                            </div>
                        </div>
                    </div>
                </div>       

            </div>
        </header>

        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    </body>
</html>
