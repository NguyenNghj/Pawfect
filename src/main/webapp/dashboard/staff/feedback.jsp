<%-- 
    Document   : feedback
    Created on : Feb 11, 2025, 4:53:18 PM
    Author     : Vu Quang Duc - CE181221
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="../../css/dashboard.css">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">

                <!-- SIDEBAR -->
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
                        <nav class="navbar bg-body-tertiary">                                    
                            <a class="navbar-brand d-flex align-items-center gap-3" href="dashboard.jsp">
                                <i class="fa-solid fa-chart-line fa-lg"></i> 
                                Dashboard
                            </a>
                        </nav>
                        <nav class="navbar bg-body-tertiary">
                            <a class="navbar-brand d-flex align-items-center gap-3" href="ordermanagement?&action=view&status=tc">
                                <i class="fa-solid fa-truck-ramp-box fa-lg"></i>
                                <span>Đơn hàng</span>
                            </a>
                        </nav>  
                        <nav class="navbar bg-body-tertiary">
                            <a class="navbar-brand d-flex align-items-center gap-3" href="pethotelbooking">
                                <i class="fa-solid fa-building-circle-check fa-lg"></i>
                                <span>Khách sạn thú cưng</span>
                            </a>
                        </nav>                  
                        <nav class="navbar bg-body-tertiary active">
                            <a class="navbar-brand d-flex align-items-center gap-3" href="feedbackmanagement?&action=view&status=0" style="color: white; pointer-events: none;">
                                <i class="fa-solid fa-comment fa-lg"></i>
                                <span>Phản hồi sản phẩm</span>
                            </a>
                        </nav>                  
                    </div>

                    <div class="row">
                        <hr style="margin: 10px 0;">
                    </div>

                    <div class="row">
                        <nav class="navbar bg-body-tertiary">                                   
                            <a class="navbar-brand d-flex align-items-center gap-3" href="profile.jsp">
                                <i class="fa-solid fa-address-book fa-lg"></i>   
                                <span>Hồ sơ</span>
                            </a>                          
                        </nav>
                        <nav class="navbar bg-body-tertiary">                                              
                            <a class="navbar-brand d-flex align-items-center gap-3" href="#">
                                <i class="fa-solid fa-right-from-bracket fa-lg"></i>
                                <span>Đăng xuất</span>
                            </a>
                        </nav>
                    </div>

                </div>


                <!-- MAIN -->
                <div class="col" id="main" style="padding: 0 40px;">
                    <div class="row pt-4">
                        <div class="d-flex align-items-center justify-content-between" style="padding: 0;">
                            <div>
                                <h1>Quản lý phản hồi sản phẩm</h1>
                            </div>
                            <div class="dropdown d-flex align-items-center gap-2">
                                <span>Username2025 (Employee)</span>
                                <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <img class="profile-img" src="https://img.freepik.com/foto-gratis/hombre-tiro-medio-peinado-afro_23-2150677136.jpg" alt="">
                                </button>
                                <ul class="dropdown-menu ps-2 pe-2 pt-2 pb-2">
                                    <div class="d-grid gap-2">
                                        <li class="profile-img-switch-store d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-store"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="#">Go to store</a>
                                        </li>
                                        <hr style="margin: 0;">
                                        <li class="profile-img-info1 d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-user-pen"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="profile.jsp">Profile</a>
                                        </li>
                                        <li class="profile-img-info2 d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-right-from-bracket" style="font-size: 20px;"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="#">Logout</a>
                                        </li>
                                    </div>
                                </ul>
                            </div>                                                             
                        </div>
                    </div>

                    <div class="row mt-2">
                        <nav style="--bs-breadcrumb-divider: '>'; padding: 0 5px;" aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item" style="color: #6c757d;">Dashboard</li>
                                <li class="breadcrumb-item"><a href="#">Trang chủ</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Phản hồi sản phẩm</li>
                            </ol>
                        </nav>
                    </div>   

                    <div class="row" style="margin-top: 60px; margin-bottom: 50px;">
                        <div class="main-dashboard-table">
                            <div class="d-flex justify-content-center align-items-center gap-3 main-dashboard-table-header"
                                 style="background-color: #007BFF; color: white; border-top-left-radius: 6px; border-top-right-radius: 6px;">                                                 
                                <i class="fa-solid fa-comments fa-lg"></i>
                                <h4 class="mb-0">Danh sách phản hồi</h4>
                            </div>
                            <div style="padding: 15px 15px 25px 15px;">
                                <!-- Order Tabs -->
                                <ul class="nav nav-tabs mb-4">
                                    <li class="nav-item">
                                        <a class="nav-link <c:if test="${feedbackStatus == '0'}">active</c:if>" href="feedbackmanagement?&action=view&status=0"">Tất cả</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link <c:if test="${feedbackStatus == '5'}">active</c:if>" href="feedbackmanagement?&action=view&status=5">5 <i class="fa-solid fa-star" style="color: #FFD43B;"></i></a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link <c:if test="${feedbackStatus == '4'}">active</c:if>" href="feedbackmanagement?&action=view&status=4">4 <i class="fa-solid fa-star" style="color: #FFD43B;"></i></a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link <c:if test="${feedbackStatus == '3'}">active</c:if>" href="feedbackmanagement?&action=view&status=3">3 <i class="fa-solid fa-star" style="color: #FFD43B;"></i></a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link <c:if test="${feedbackStatus == '2'}">active</c:if>" href="feedbackmanagement?&action=view&status=2">2 <i class="fa-solid fa-star" style="color: #FFD43B;"></i></a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link <c:if test="${feedbackStatus == '1'}">active</c:if>" href="feedbackmanagement?&action=view&status=1">1 <i class="fa-solid fa-star" style="color: #FFD43B;"></i></a>
                                        </li>
                                    </ul>
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th scope="col" style="width: 5%;">Id</th>
                                                <th scope="col" style="width: 17%;">Sản phẩm</th>
                                                <th scope="col" style="width: 15%;">Khách hàng</th>
                                                <th scope="col" style="width: 11%;">Đánh giá</th>
                                                <th scope="col">Nhận xét</th>        
                                                <th scope="col" style="width: 9%;">Trạng thái</th>
                                                <th scope="col" style="width: 14%;">Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody>

                                        <c:forEach items="${feedbacks}" var="f">
                                            <tr>
                                                <th scope="row">#${f.feedbackId}</th>
                                                <td>${f.productName}</td>
                                                <td>${f.customerName}</td>
                                                <td>
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
                                                </td>
                                                <td>${f.comment}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${f.isVisible == true}">
                                                            <span class="text-success fw-bold">Hiện</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-danger fw-bold">Ẩn</span>
                                                        </c:otherwise>
                                                    </c:choose>                                                   
                                                </td>
                                                <td>
                                                    <button type="button" class="btn btn-primary open-modal"
                                                            data-bs-toggle="modal" data-bs-target="#feedbackModal"
                                                            data-feedback-id="${f.feedbackId}"
                                                            data-product-name="${f.productName}"
                                                            data-customer-name="${f.customerName}"
                                                            data-rating="${f.rating}"
                                                            data-comment="${f.comment}"
                                                            data-reply="${f.reply}"
                                                            data-status="${param.status}"
                                                            >
                                                        Chi tiết
                                                    </button>
                                                    <c:choose>
                                                        <c:when test="${f.isVisible == true}">
                                                            <button type="button" class="btn btn-danger hideButton1"
                                                                    data-feedback-id="${f.feedbackId}"
                                                                    data-customer-name="${f.customerName}"
                                                                    data-status="${param.status}"
                                                                    >
                                                                Ẩn
                                                            </button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button type="button" class="btn btn-success hideButton2"
                                                                    data-feedback-id="${f.feedbackId}"
                                                                    data-customer-name="${f.customerName}"
                                                                    data-status="${param.status}"
                                                                    >
                                                                Hiện
                                                            </button>
                                                        </c:otherwise>
                                                    </c:choose>                                                   
                                                </td>
                                            </tr>
                                        </c:forEach>

                                    </tbody>
                                </table>

                                <!-- Modal -->
                                <div class="modal fade" id="feedbackModal" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" aria-labelledby="feedbackModalLabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">

                                            <div class="modal-header">
                                                <h1 class="modal-title fs-5" id="feedbackModalLabel">  </h1>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <form id="feedbackForm" action="feedbackmanagement?&action=reply" method="post">
                                                <div class="modal-body">

                                                    <div class="mb-3">
                                                        <label for="product-name" class="col-form-label"><b>Sản phẩm:</b></label>
                                                        <input type="text" class="form-control" id="product-name" readonly>
                                                    </div>
                                                    <div class="row mb-3">
                                                        <div class="col">
                                                            <label for="customer-name" class="col-form-label"><b>Khách hàng:</b></label>
                                                            <input type="text" class="form-control" id="customer-name" readonly>
                                                        </div>
                                                        <div class="col-3">
                                                            <label for="fb-rating" class="col-form-label"><b>Đánh giá:</b></label>
                                                            <div class="input-group"> 
                                                                <input type="text" class="form-control" id="fb-rating" value="5" readonly>
                                                                <span class="input-group-text">
                                                                    <i class="fa-solid fa-star" style="color: #FFD43B;"></i>
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="fb-comment" class="col-form-label"><b>Bình luận của khách:</b></label>
                                                        <textarea style="height: 80px;" class="form-control" id="fb-comment" readonly></textarea>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="fb-reply" class="col-form-label"><b>Phản hồi của nhân viên:</b></label>
                                                        <textarea style="height: 80px;" name="reply" class="form-control" id="fb-reply" required></textarea>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                    <button type="submit" class="btn btn-primary" id="confirm-btn">Lưu</button>
                                                </div>

                                                <input type="hidden" name="feedbackId" id="feedback-id">
                                                <input type="hidden" name="status" id="status">
                                            </form>                                       
                                        </div>
                                    </div>
                                </div>

                                <!-- Nếu 'không' có đánh giá nào! -->
                                <c:if test="${empty feedbacks}">                     
                                    <div>
                                        <h5 style="color: #856404; text-align: center; background-color: #fff3cd; padding: 12px; border-radius: 5px; margin-top: 10px;">
                                            Không có đánh giá nào!
                                        </h5>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>          

                </div>

            </div>
        </div>


        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {


                // Bắt sự kiện khi nhấn nút Lưu
                document.getElementById("confirm-btn").addEventListener("click", function (event) {
                    event.preventDefault(); // Ngăn form gửi ngay lập tức

                    // Lấy nội dung phản hồi của nhân viên
                    let replyContent = document.getElementById("fb-reply").value.trim();

                    // Kiểm tra nếu ô phản hồi trống
                    if (replyContent === "") {
                        Swal.fire({
                            title: "Phản hồi không được để trống!",
                            text: "Vui lòng nhập phản hồi trước khi lưu.",
                            icon: "error"
                        });
                        return; // Dừng thực thi nếu ô phản hồi trống
                    }

                    // Nếu hợp lệ, hiển thị xác nhận
                    Swal.fire({
                        title: "Xác nhận lưu?",
                        text: "Bạn có chắc chắn muốn lưu phản hồi này?",
                        icon: "warning",
                        showCancelButton: true,
                        confirmButtonColor: "#3085d6",
                        cancelButtonColor: "#d33",
                        confirmButtonText: "Đồng ý!",
                        cancelButtonText: "Hủy!"
                    }).then((result) => {
                        if (result.isConfirmed) {
                            // Hiển thị alert thành công
                            Swal.fire({
                                title: "Thành công!",
                                text: "Phản hồi đã được lưu.",
                                icon: "success",
                                timer: 1500,
                                showConfirmButton: false
                            }).then(() => {
                                // Gửi form sau khi hiện alert xong
                                document.getElementById("feedbackForm").submit();
                            });
                        }
                    });
                });



                // Lắng nghe sự kiện click trên các nút mở modal
                document.querySelectorAll(".open-modal").forEach(button => {
                    button.addEventListener("click", function () {
                        // Lấy dữ liệu từ thuộc tính data-*
                        let feedbackId = this.getAttribute("data-feedback-id");
                        let productName = this.getAttribute("data-product-name");
                        let customerName = this.getAttribute("data-customer-name");
                        let rating = this.getAttribute("data-rating");
                        let comment = this.getAttribute("data-comment");
                        let reply = this.getAttribute("data-reply");
                        let status = this.getAttribute("data-status");

                        console.log(feedbackId);
                        console.log(productName);
                        console.log(customerName);
                        console.log(rating);
                        console.log(comment);
                        console.log(reply);

                        // Gán dữ liệu vào modal
                        document.getElementById("product-name").value = productName;
                        document.getElementById("customer-name").value = customerName;
                        document.getElementById("fb-rating").value = rating;
                        document.getElementById("fb-comment").value = comment;
                        document.getElementById("fb-reply").value = reply || ""; // Nếu null thì hiển thị chuỗi rỗng
                        // Cập nhật tiêu đề modal
                        document.getElementById("feedbackModalLabel").textContent = "Phản hồi #" + feedbackId;
                        document.getElementById("feedback-id").value = feedbackId;
                        document.getElementById("status").value = status;

                    });
                });


                // Xóa dữ liệu khi modal đóng
                let feedbackModal = document.getElementById("feedbackModal");
                feedbackModal.addEventListener("hidden.bs.modal", function () {
                    document.getElementById("product-name").value = "";
                    document.getElementById("customer-name").value = "";
                    document.getElementById("fb-rating").value = "";
                    document.getElementById("fb-comment").value = "";
                    document.getElementById("fb-reply").value = "";
                });


                document.querySelectorAll(".hideButton1").forEach(button => {
                    button.addEventListener("click", function () {
                        let feedbackId = this.getAttribute("data-feedback-id");
                        let customerName = this.getAttribute("data-customer-name");
                        let status = this.getAttribute("data-status");

                        // Kiểm tra xem có lấy đúng feedbackId không
                        console.log("Feedback ID:", feedbackId);
                        console.log("Customer Name:", customerName);
                        console.log("Status:", status);

                        Swal.fire({
                            title: "Xác nhận ẩn đánh giá?",
                            text: "Bạn có chắc muốn ẩn đánh giá của khách hàng " + customerName + "?",
                            icon: "warning",
                            showCancelButton: true,
                            confirmButtonColor: "#3085d6",
                            cancelButtonColor: "#d33",
                            confirmButtonText: "Đồng ý!",
                            cancelButtonText: "Huỷ!"
                        }).then((result) => {
                            if (result.isConfirmed) {
                                Swal.fire({
                                    title: "Đã ẩn!",
                                    text: "Đánh giá của khách hàng đã bị ẩn.",
                                    icon: "success"
                                }).then(() => {
                                    // Chuyển trang sau khi thông báo hoàn tất
                                    window.location.href = "feedbackmanagement?action=isVisible&feedbackId=" + feedbackId + "&status=" + status;
                                });
                            }
                        });
                    });
                });


                document.querySelectorAll(".hideButton2").forEach(button => {
                    button.addEventListener("click", function () {
                        let feedbackId = this.getAttribute("data-feedback-id");
                        let customerName = this.getAttribute("data-customer-name");
                        let status = this.getAttribute("data-status");

                        // Kiểm tra xem có lấy đúng feedbackId không
                        console.log("Feedback ID:", feedbackId);
                        console.log("Customer Name:", customerName);
                        console.log("Status:", status);

                        Swal.fire({
                            title: "Xác nhận hiện đánh giá?",
                            text: "Bạn có chắc muốn hiện đánh giá của khách hàng " + customerName + "?",
                            icon: "warning",
                            showCancelButton: true,
                            confirmButtonColor: "#3085d6",
                            cancelButtonColor: "#d33",
                            confirmButtonText: "Đồng ý!",
                            cancelButtonText: "Huỷ!"
                        }).then((result) => {
                            if (result.isConfirmed) {
                                Swal.fire({
                                    title: "Đã hiện!",
                                    text: "Đánh giá của khách hàng đã hiện.",
                                    icon: "success"
                                }).then(() => {
                                    // Chuyển trang sau khi thông báo hoàn tất
                                    window.location.href = "feedbackmanagement?action=isVisible&feedbackId=" + feedbackId + "&status=" + status;
                                });
                            }
                        });
                    });
                });
            });
        </script>
    </body>
</html>
