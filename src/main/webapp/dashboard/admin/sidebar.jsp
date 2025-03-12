<%-- 
    Document   : slidebar
    Created on : Mar 1, 2025, 4:23:53 PM
    Author     : Nguyen Tri Nghi - CE180897
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="col-2 sidebar" id="sidebar">
    <div class="row pt-4 sidebar-brandName">
        <div class="col d-flex justify-content-center align-items-center gap-3">
            <i class="fa-solid fa-paw fa-beat" style="font-size: 36px; color: #FFF2DF"></i>
            <span>
                <h3 style="margin: 0; color: #FFF2DF">PAWFECT</h3>
            </span>
        </div>
    </div>

    <div class="row">
        <hr style="margin: 10px 0; border-top: 4px solid white;">
    </div>

    <div class="row">                  
        <nav class="navbar bg-body-tertiary" id="dashboard">                                    
            <a class="navbar-brand d-flex align-items-center gap-3" href="statistics">
                <i class="fa-solid fa-chart-line fa-lg"></i> 
                <span>Thống kê</span>
            </a>
        </nav>
        <nav class="navbar bg-body-tertiary">                        
            <div class="accordion w-100" id="accordionExample1">                               
                <h2 class="accordion-header">
                    <button class="accordion-button collapsed gap-3" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
                        <i class="fa-solid fa-users fa-lg"></i>Tài khoản
                    </button>
                </h2>
                <div id="collapseOne" class="accordion-collapse collapse" data-bs-parent="#accordionExample1">
                    <div class="accordion-body">
                        <nav class="navbar bg-body-tertiary" style="padding-bottom: 0;" id="staff">
                            <div class="container-fluid">
                                <a class="navbar-brand" href="staff">Nhân viên</a>
                            </div>
                        </nav>
                        <nav class="navbar bg-body-tertiary" style="padding-bottom: 0;" id="customers">
                            <div class="container-fluid">
                                <a class="navbar-brand" href="customers">Khách hàng</a>
                            </div>
                        </nav>
                    </div>
                </div>                                              
            </div>                    
        </nav>
        <nav class="navbar bg-body-tertiary" id="product">                                            
            <a class="navbar-brand d-flex align-items-center gap-3" href="product">
                <i class="fa-solid fa-box fa-lg"></i>
                <span>Sản phẩm</span>
            </a>                          
        </nav>
        <nav class="navbar bg-body-tertiary" id="voucher">                   
            <a class="navbar-brand d-flex align-items-center gap-3" href="voucher">
                <i class="fa-solid fa-ticket"></i>
                <span>Mã giảm giá</span>
            </a>
        </nav>
        <nav class="navbar bg-body-tertiary" id="category">                   
            <a class="navbar-brand d-flex align-items-center gap-3" href="category">
                <i class="fa-solid fa-boxes-stacked fa-lg"></i>
                <span>Thể loại sản phẩm</span>
            </a>
        </nav>
        <nav class="navbar bg-body-tertiary" id="pethotel">                                            
            <a class="navbar-brand d-flex align-items-center gap-3" href="pethotel">
                <i class="fa-solid fa-hotel fa-lg"></i>  
                <span>Pet Hotel</span>
            </a>
        </nav>
    </div>

    <div class="row">
        <hr style="margin: 10px 0; border-top: 4px solid white;">
    </div>

    <div class="row" style="display: flex; justify-content: center">

        <div class="row logout-container">
            <button type="button" class="btn btn-danger dangxuat" onclick="window.location.href = 'logoutstaff'">Đăng xuất</button>
        </div>

    </div>
</div>
<%
    Cookie[] cookies = request.getCookies();
    String staffRole = "";
    String staffName = "";

    if (cookies != null) {
        for (Cookie cookie : cookies) {
            String name = cookie.getName();
            String value = cookie.getValue();

            if ("staffRole".equals(name)) {
                staffRole = value;
            } else if ("staffName".equals(name)) {
                staffName = value;
            }

            // Nếu đã lấy được cả hai giá trị thì thoát vòng lặp
            if (!staffRole.isEmpty() && !staffName.isEmpty()) {
                break;
            }
        }
    }
%>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        // Lấy đường dẫn hiện tại
        const currentPath = window.location.pathname.split("/").pop();

        // Danh sách các trang và ID tương ứng
        const navItems = {
            "dashboard": "dashboard",
            "product": "product",
            "voucher": "voucher",
            "category": "category",
            "pethotel": "pethotel",
            "profile": "profile",
            "logout": "logout",
            "staff": "staff",
            "customers": "customers"
        };

        // Xóa lớp 'active' khỏi tất cả các navbar
        document.querySelectorAll(".navbar").forEach(nav => {
            nav.classList.remove("active");
            let icon = nav.querySelector("i");
            let span = nav.querySelector("span");
            if (icon)
                icon.style.color = "";
            if (span)
                span.style.color = "";
        });

        // Kiểm tra nếu trang hiện tại khớp với ID trong danh sách
        if (navItems[currentPath]) {
            let activeNav = document.getElementById(navItems[currentPath]);
            if (activeNav) {
                activeNav.classList.add("active");
                let activeIcon = activeNav.querySelector("i");
                let activeSpan = activeNav.querySelector("span");
                if (activeIcon)
                    activeIcon.style.color = "#fcdb51";
                if (activeSpan)
                    activeSpan.style.color = "#fcdb51";
            }
        }

        // Kiểm tra nếu trang hiện tại là "staff" hoặc "customers" thì mở rộng accordion
        if (currentPath === "staff" || currentPath === "customers") {
            let accordion = document.getElementById("collapseOne");
            if (accordion) {
                accordion.classList.add("show"); // Mở rộng accordion

                // Highlight mục con tương ứng
                let activeSubNav = document.getElementById(navItems[currentPath]);
                if (activeSubNav) {
                    activeSubNav.classList.add("active");
                    activeSubNav.style.fontWeight = "bold"; // Làm đậm chữ để dễ nhận diện hơn
                }
            }
        }
    });
</script>

