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
                            <li><a href="aboutus.jsp">Giới thiệu</a></li>
                            <li><a href="register">Đăng ký thành viên</a></li>
                            <li><a href="https://mail.google.com/mail/u/0/?view=cm&to=pawfectg3@gmail.com" target="_blank">Liên hệ</a></li>
                        </ul>
                    </div>
                    <div class="col-auto">
                        <div>
                            <h4 class="footer-title">PawPect</h4>
                            <ul class="links">
                                <li class="d-flex align-items-center gap-3">
                                    <i class="fa-solid fa-map-location-dot fa-lg"></i>
                                    <span>600 Nguyễn Văn Cừ Nối Dài, An Bình, Bình Thủy, Cần Thơ</span>
                                </li>
                                <li class="d-flex align-items-center gap-3">
                                    <i class="fa-solid fa-paper-plane fa-lg"></i>
                                    <span>pawfectg3@gmail.com</span>
                                </li>
                                <li class="d-flex align-items-center gap-3">
                                    <i class="fa-solid fa-phone fa-lg"></i>
                                    <span>0967017222</span>
                                </li>           
                            </ul>
                        </div>
                        <div>
                            <h4 class="footer-title mb-2 mt-4">Kết nối với chúng tôi</h4>
                            <div class="social-icon p-0 d-flex align-items-center gap-2">
                                <a class="btn" href="https://www.facebook.com/GemNghj?locale=vi_VN">
                                    <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Facebook_Logo_%282019%29.png/900px-Facebook_Logo_%282019%29.png" alt="">
                                </a>
                                <a class="btn">
                                    <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/Icon_of_Zalo.svg/120px-Icon_of_Zalo.svg.png" alt="">
                                </a>
                                <a class="btn">
                                    <i class='bx bxl-tiktok' style="font-size: 31px"></i>
                                </a>
                                <a class="btn">
                                    <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/fd/YouTube_full-color_icon_%282024%29.svg/1486px-YouTube_full-color_icon_%282024%29.svg.png" alt="">
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-auto">
                        <div class="d-flex flex-column align-items-center gap-4 footer-logo"> 
                            <iframe style="border-radius: 20px" src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3929.0533542569997!2d105.72985667479374!3d10.012451790093571!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31a0882139720a77%3A0x3916a227d0b95a64!2sFPT%20University!5e0!3m2!1svi!2s!4v1741661901831!5m2!1svi!2s" width="500" height="350" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                        </div>
                    </div>
                </div>
                <div class="row footer-end">
                    <span class="text-center text-light">Copyright 2025 © Bản quyền thuộc về PawPect | Cung cấp bởi Group 3</span>       
                </div>

            </div>
        </footer>

        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    </body>
</html>
