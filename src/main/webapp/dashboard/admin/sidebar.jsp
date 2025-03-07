<%-- 
    Document   : slidebar
    Created on : Mar 1, 2025, 4:23:53 PM
    Author     : Nguyen Tri Nghi - CE180897
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="col-2" id="sidebar">
    <div class="row pt-4 sidebar-brandName">
        <div class="col d-flex justify-content-center align-items-center gap-3">
            <i class="fa-solid fa-paw fa-beat" style="font-size: 36px;"></i>
            <span>
                <h3 style="margin: 0;">PetCare</h3>
            </span>
        </div>
    </div>

    <div class="row">                  
        <nav class="navbar bg-body-tertiary" id="dashboard">                                    
            <a class="navbar-brand d-flex align-items-center gap-3" href="dashboard">
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
                        <nav class="navbar bg-body-tertiary" style="padding-bottom: 0;">
                            <div class="container-fluid">
                                <a class="navbar-brand" href="admin">Admin</a>
                            </div>
                        </nav>
                        <nav class="navbar bg-body-tertiary" style="padding-bottom: 0;">
                            <div class="container-fluid">
                                <a class="navbar-brand" href="staff">Employee</a>
                            </div>
                        </nav>
                        <nav class="navbar bg-body-tertiary" style="padding-bottom: 0;">
                            <div class="container-fluid">
                                <a class="navbar-brand" href="customers">Customer</a>
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
        <nav class="navbar bg-body-tertiary" id="category">                   
            <a class="navbar-brand d-flex align-items-center gap-3" href="category">
                <i class="fa-solid fa-boxes-stacked fa-lg"></i>
                <span>Thể loại sản phẩm</span>
            </a>
        </nav>
        <nav class="navbar bg-body-tertiary" id="petroom">                                            
            <a class="navbar-brand d-flex align-items-center gap-3" href="petroom">
                <i class="fa-solid fa-hotel fa-lg"></i>  
                <span>Pet Hotel</span>
            </a>
        </nav>
    </div>

    <div class="row">
        <hr style="margin: 10px 0;">
    </div>

    <div class="row">
        <nav class="navbar bg-body-tertiary" id="profile">                                   
            <a class="navbar-brand d-flex align-items-center gap-3" href="adminprofile">
                <i class="fa-solid fa-address-book fa-lg"></i>   
                <span>Thông tin cá nhân</span>
            </a>                          
        </nav>
        <nav class="navbar bg-body-tertiary" id="logout">                                              
            <a class="navbar-brand d-flex align-items-center gap-3" href="logoutadmin">
                <i class="fa-solid fa-right-from-bracket fa-lg"></i>
                <span>Logout</span>
            </a>
        </nav>
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
                "category": "category",
                "petroom": "petroom",
                "profile": "profile",
                "logout": "logout"
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
                        activeIcon.style.color = "white";
                    if (activeSpan)
                        activeSpan.style.color = "white";
                }
            }
        });
    </script>
</div>