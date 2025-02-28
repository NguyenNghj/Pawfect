<%-- 
    Document   : myPetHistory
    Created on : Feb 16, 2025, 7:39:55 PM
    Author     : Vu Quang Duc - CE181221
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="./css/account.css">
    </head>
    <body>
        <div class="container py-4">
            <!-- Breadcrumb -->
            <nav aria-label="breadcrumb" class="mb-4">
                <ol class="breadcrumb p-3" style="background-color: white; border-radius: 5px;">
                    <li class="breadcrumb-item"><a href="pawfect" class="text-decoration-none">Trang chủ</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Tài khoản</li>
                </ol>
            </nav>

            <div class="row g-4">
                <!-- Main Content -->
                <div class="col-md-8">
                    <!-- Top Cards -->
                    <div class="row g-4 mb-4">
                        <div class="col-md-4">
                            <div class="card h-100">
                                <div class="card-body d-flex align-items-center gap-3">
                                    <i class="bi bi-clipboard-check fs-4 text-primary"></i>
                                    <a href="#" class="text-decoration-none text-dark">Lịch sử đơn hàng</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card h-100">
                                <div class="card-body d-flex align-items-center gap-3">
                                    <i class="bi bi-calendar-date fs-4 text-primary"></i>
                                    <a href="#" class="text-decoration-none text-dark">Lịch sử đặt lịch</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card h-100">
                                <div class="card-body d-flex align-items-center gap-3">
                                    <i class="bi bi-person-circle fs-4"></i>
                                    <span>Xin chào, <span class="text-primary">[${customer.fullName}]</span></span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Orders Section -->
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title mb-4">Thú cưng của bạn</h5>

                            <!-- Order Tabs -->
                            <ul class="nav nav-tabs mb-4">
    <li class="nav-item">
        <a class="nav-link active" href="#" data-filter="all">Tất cả</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="#" data-filter="Chó">Chó</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="#" data-filter="Mèo">Mèo</a>
    </li>
</ul>

                            <!-- TH1: Khách hàng 'không' có thú cưng -->
                            <!-- <div>
                                <h5 style="color: #ff7d0a; text-align: center;">
                                    Bạn không có thú cưng nào!
                                </h5>
                            </div> -->

                            <!-- TH2: Khách hàng 'có' thú cưng  -->
                            <!-- Order Item -->                           
                          <c:choose>
    <c:when test="${empty pets}">
        <div>
            <h5 style="color: #ff7d0a; text-align: center;">
                Bạn không có thú cưng nào!
            </h5>
        </div>
    </c:when>
    <c:otherwise>
        <c:forEach items="${pets}" var="pro">
    <div class="card mb-3 hover-card pet-item" data-type="${pro.petType}">
        <a href="petviewdetail?petId=${pro.petId}" style="text-decoration: none; color: inherit;">
            <div class="card-body">
                <div class="row align-items-center">
                    <div class="col">
                        <div class="d-flex align-items-center gap-4">
                            <img class="rounded" src="${pro.petImg != null ? pro.petImg : 'default.jpg'}" 
                                 alt="" width="90" height="90">
                            <div class="d-grid gap-1">
                                <h6 style="font-size: 18px;">${pro.petStatus}</h6>
                                <span class="text-secondary">Tên: ${pro.petname}</span>
                                <span class="text-secondary">Loại: ${pro.petType}</span>                                                       
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </a>                                                         
    </div>  
</c:forEach>

    </c:otherwise>
</c:choose>                    

                            <!-- Modal xoá thú cưng -->
                            <div class="modal fade" id="removePetModal" tabindex="-1" aria-labelledby="removePetModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 class="modal-title fs-5" id="removePetModalLabel">Xác nhận xoá thú cưng</h1>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <p style="text-align: left;">Bạn muốn chắc chắn xoá [Tên thú cưng]</p>   
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                            <a href="#" class="btn btn-danger">Xoá</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Sidebar -->
                <div class="col-md-4">
                    <div class="list-group account-action">
                        <a href="profile" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="fa-regular fa-user fa-lg" style="color: #0062ad;"></i>
                            <span>Thông tin cá nhân</span>
                        </a>
                        <a href="viewpet" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="fa-solid fa-paw fa-lg" style="color: #8C6E63;"></i>
                            <span style="color: #1c49c2;"><b>Thú cưng của tôi</b></span>
                        </a>
                        <c:if test="${customer.email != null and fn:contains(customer.email, '@')}">
    <a href="changepassword" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
        <i class="fa-solid fa-key fa-lg" style="color: #eabd1a;"></i>
        <span>Đổi mật khẩu</span>
    </a>
</c:if>
                        <a href="logout" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="fa-solid fa-arrow-right-from-bracket fa-lg" style="color: #d01616;"></i>
                            <span>Đăng xuất</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const tabs = document.querySelectorAll(".nav-link");
        const petItems = document.querySelectorAll(".pet-item");

        tabs.forEach(tab => {
            tab.addEventListener("click", function (event) {
                event.preventDefault(); // Ngăn chặn tải lại trang
                tabs.forEach(t => t.classList.remove("active"));
                this.classList.add("active");

                const filterType = this.textContent.trim(); // Lấy tên tab (Chó, Mèo, Tất cả)

                petItems.forEach(item => {
                    if (filterType === "Tất cả" || item.dataset.type === filterType) {
                        item.style.display = "block";
                    } else {
                        item.style.display = "none";
                    }
                });
            });
        });
    });
</script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
    </body>
</html>
