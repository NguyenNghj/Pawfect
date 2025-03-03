<%-- 
    Document   : footer
    Created on : Feb 11, 2025, 5:24:43 PM
    Author     : Vu Quang Duc - CE181221
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="<%= request.getContextPath()%>/css/footer.css">
        <title>JSP Page</title>
    </head>
    <body>
        <footer>
            <div class="container-fluid footer-top">
                <div class="row justify-content-center" style="gap: 60px;">
                    <div class="col-auto">
                        <h4 class="footer-title">Về chúng tôi</h4>
                        <ul class="links">
                            <li><a href="">Giới thiệu</a></li>
                            <li><a href="">Hướng dẫn mua hàng</a></li>
                            <li><a href="">Đăng ký thành viên</a></li>
                            <li><a href="">Liên hệ</a></li>
                        </ul>
                    </div>
                    <div class="col-auto">
                        <h4 class="footer-title">Về chúng tôi</h4>
                        <ul class="links">
                            <li><a href="">Chính sách thanh toán</a></li>
                            <li><a href="">Chính sách giao hàng</a></li>
                            <li><a href="">Chính sách đổi trả</a></li>
                            <li><a href="">Chính sách bảo mật</a></li>
                            <li><a href="">Điều khoản dịch vụ</a></li>
                        </ul>
                    </div>
                    <div class="col-auto">
                        <div>
                            <h4 class="footer-title">PawPect</h4>
                            <ul class="links">
                                <li class="d-flex align-items-center gap-3">
                                    <i class="fa-solid fa-map-location-dot fa-lg"></i>
                                    <span>8888 Nguyễn Văn Cừ nối dài, Ninh Kiều, Cần Thơ</span>
                                </li>
                                <li class="d-flex align-items-center gap-3">
                                    <i class="fa-solid fa-paper-plane fa-lg"></i>
                                    <span>pawfect@gmail.com</span>
                                </li>
                                <li class="d-flex align-items-center gap-3">
                                    <i class="fa-solid fa-phone fa-lg"></i>
                                    <span>0123456789</span>
                                </li>           
                            </ul>
                        </div>
                        <div>
                            <h4 class="footer-title">Kết nối với chúng tôi</h4>
                            <div class="social-icon p-0 d-flex align-items-center gap-3">
                                <a class="btn">
                                    <img src="../images/icons/facebook.png" alt="">
                                </a>
                                <a class="btn">
                                    <img src="../images/icons/Icon_of_Zalo.svg.png" alt="">
                                </a>
                                <a class="btn">
                                    <img src="../images/icons/tiktok.png" alt="">
                                </a>
                                <a class="btn">
                                    <img src="../images/icons/youtube.png" alt="">
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-auto">
                        <div class="d-flex flex-column align-items-center gap-4 footer-logo"> 
                            <img src="../images/logos/Logo_Truong_Đai_hoc_FPT.svg" alt="">
                            <div class="d-flex align-items-center gap-3 footer-logo-1">
                                <img src="../images/logos/logo-da-thong-bao-bo-cong-thuong.webp" alt="" >                    
                                <img src="../images/logos/handle_cert.png" alt="">
                            </div>
                            <div class="d-flex align-items-center gap-3 footer-logo-2">
                                <img src="//images.dmca.com/Badges/dmca_protected_sml_120l.png?ID=//www.dmca.com/Protection/Status.aspx?id=a99f8ae5-2c7c-4b4b-85c2-3051ff1fa219" alt="">                    
                                <img src="../images/logos/InstantSSL Trust Seal/instantssl_trust_seal_md.png" alt="">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row footer-end">
                    <span class="text-center">Copyright 2025 © Bản quyền thuộc về PawPect | Cung cấp bởi Group 3</span>       
                </div>

            </div>
        </footer>

        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    </body>
</html>
