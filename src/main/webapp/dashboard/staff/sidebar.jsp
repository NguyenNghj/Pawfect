<%-- 
    Document   : sidebar
    Created on : Mar 12, 2025, 1:44:02 PM
    Author     : Nguyen Tri Nghi - CE180897
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="col-2 sidebar" id="sidebar">
    <div class="row pt-4 sidebar-brandName">
        <div class="col d-flex justify-content-center align-items-center gap-3">
            <i class="fa-solid fa-paw fa-beat" style="font-size: 36px; color: white"></i>
            <span>
                <h3 style="margin: 0; color: white">PAWFECT</h3>
            </span>
        </div>
    </div>

    <div class="row">
        <hr style="margin: 10px 0; border-top: 4px solid white;">
    </div>

    <div class="row">                  
        <nav class="navbar bg-body-tertiary" id="customer">                                            
            <a class="navbar-brand d-flex align-items-center gap-3" href="viewcustomersforStaff">
                <i class="fa-solid fa-box fa-lg"></i>
                <span>Khách hàng</span>
            </a>                          
        </nav>
        <nav class="navbar bg-body-tertiary" id="voucher">                   
            <a class="navbar-brand d-flex align-items-center gap-3" href="voucher">
                <i class="fa-solid fa-ticket"></i>
                <span>Mã giảm giá</span>
            </a>
        </nav>
        <nav class="navbar bg-body-tertiary" id="order">                                            
            <a class="navbar-brand d-flex align-items-center gap-3" href="ordermanagement?&action=view&status=tc">
                <i class="fa-solid fa-cart-shopping"></i>
                <span>Đơn hàng</span>
            </a>
        </nav>
        <nav class="navbar bg-body-tertiary" id="pethotel">                                            
            <a class="navbar-brand d-flex align-items-center gap-3" href="pethotelbooking">
                <i class="fa-solid fa-hotel fa-lg"></i>  
                <span>Khách sạn thú cưng</span>
            </a>
        </nav>
        <nav class="navbar bg-body-tertiary" id="feedback">                                            
            <a class="navbar-brand d-flex align-items-center gap-3" href="feedbackmanagement?&action=view&status=0">
                <i class="fa-solid fa-comments"></i>
                <span>Phản hồi sản phẩm</span>
            </a>
        </nav>
    </div>

    <div class="row">
        <hr style="margin: 10px 0; border-top: 4px solid white;">
    </div>

    <div class="row" style="display: flex; justify-content: center">
        <nav class="navbar bg-body-tertiary" id="profile">                                            
            <a class="navbar-brand d-flex align-items-center gap-3" href="staffprofile">
                <i class="fa-solid fa-user"></i>
                <span>Hồ sơ</span>
            </a>
        </nav>

        <div class="row logout-container">
            <button type="button" class="btn btn btn-dark dangxuat" onclick="window.location.href = 'logoutstaff'">Đăng xuất</button>
        </div>


    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        // Lấy đường dẫn hiện tại chính xác hơn (bỏ query string, hash)
        const url = new URL(window.location.href);
        let currentPath = url.pathname.split("/").pop(); // Lấy phần cuối cùng của URL

        // Nếu có tham số query hoặc dấu "/", loại bỏ chúng
        currentPath = currentPath.split("?")[0].split("#")[0];

        // Danh sách các trang và ID tương ứng
        const navItems = {
            "voucher": "voucher",
            "ordermanagement": "order",
            "pethotelbooking": "pethotel",
            "feedbackmanagement": "feedback",
            "staffprofile": "profile",
            "customer": "customer"
        };

        // Xóa lớp 'active' khỏi tất cả các navbar
        document.querySelectorAll(".navbar").forEach(nav => {
            nav.classList.remove("active");

        });

        // Kiểm tra và áp dụng lớp 'active' nếu có trang khớp
        for (let key in navItems) {
            if (currentPath.includes(key)) {
                let activeNav = document.getElementById(navItems[key]);
                if (activeNav) {
                    activeNav.classList.add("active");
                }
                break; // Dừng vòng lặp khi tìm thấy trang phù hợp
            }
        }
    });

</script>
