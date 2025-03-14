<%-- 
    Document   : mypetdetail
    Created on : Feb 17, 2025, 10:15:58 AM
    Author     : Vu Quang Duc - CE181221
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@include file="./components/header.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="./css/account.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>
    <body>
        <div class="container py-4"> 
            <!-- Breadcrumb -->
            <div class="row mt-2 bg-white p-3 mb-4 d-flex align-items-center justify-content-center" 
                 style="border-radius: 20px; height: 60px;">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0" style ="font-weight: bold;">
                        <li class="breadcrumb-item"><a href="pawfect" class="text-decoration-none">Trang chủ</a></li>
                        <li class="breadcrumb-item"><a href="viewpet" class="text-decoration-none">Thú cưng của tôi</a></li>
                        <li class="breadcrumb-item active" aria-current="page">${pet.petname}</li>
                    </ol>
                </nav>
            </div>

            <div class="row g-4">
                <!-- Main Content -->
                <div class="col-md-8">   
                    <!-- Đơn hàng có trạng thái "Chờ xác nhận" thì mới được huỷ đơn -->

                    <div class="d-flex justify-content-between align-items-center">

                        <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
                        <% if (errorMessage != null) {%>
                        <script>
                            Swal.fire({
                                icon: 'error',
                                title: 'Lỗi!',
                                text: "<%= errorMessage%>",
                                confirmButtonText: 'OK'
                            });
                        </script>
                        <% }%>

                    </div>                              


                   


                    <!-- Modal xác nhận xoá thú cưng -->
                    <div class="modal fade" id="removePetModal" tabindex="-1" aria-labelledby="removePetModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="removePetModalLabel">Xác nhận xoá thú cưng</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>

                                <div class="modal-body">
                                    <p style="text-align: left;">Bạn muốn chắc chắn xoá [${pet.petname}]</p>   
                                </div>
                                <div class="modal-footer">

                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                    <a href="deletepet?petId=${pet.petId}&petStatus=${pet.petStatus}" class="btn btn-danger">Xoá</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Package Tracking -->
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title mb-4 justify-content-center text-center">Thông tin thú cưng</h5>    
                            <div class="row">
                                <div class="col-lg-4">
                                    <div class="card mb-4">
                                        <div class="card-body text-center">
                                            <img src="/img/pet/${pet.petImg}" alt="avatar" class="rounded-circle img-fluid" style="width: 150px; height: 150px; object-fit: cover;">
                                            <h5 class="my-3">${empty pet.petname ? 'Chưa có thông tin' : pet.petname}</h5>
                                           <button type="button" class="btn btn-success" onclick="window.location.href='editpet?petId=${pet.petId}'">
    Chỉnh sửa thông tin
</button>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-8">
                                    <div class="card mb-4">
                                        <div class="card-body">                                           
                                            <div class="row">
                                                <div class="col-sm-3 account-info-title"><p class="mb-0">Loài</p></div>
                                                <div class="col-sm-9"><p class="mb-0">${empty pet.petType ? 'Chưa có thông tin' : pet.petType}</p></div>
                                            </div>
                                            <hr>
                                            <div class="row">
                                                <div class="col-sm-3 account-info-title"><p class="mb-0">Giống</p></div>
                                                <div class="col-sm-9"><p class="mb-0">${empty pet.petBreed ? 'Chưa có thông tin' : pet.petBreed}</p></div>
                                            </div>
                                            <hr>
                                            <div class="row">
                                                <div class="col-sm-3 account-info-title"><p class="mb-0">Giới tính</p></div>
                                                <div class="col-sm-9"><p class="mb-0">${empty pet.petSex ? 'Chưa có thông tin' : pet.petSex}</p></div>
                                            </div>
                                            <hr>
                                            <div class="row">
                                                <div class="col-sm-3 account-info-title"><p class="mb-0">Cân nặng (kg)</p></div>
                                                <div class="col-sm-9"><p class="mb-0">${empty pet.petWeight ? 'Chưa có thông tin' : pet.petWeight}</p></div>
                                            </div>
                                            <hr>
                                            <div class="row">
                                                <div class="col-sm-3 account-info-title"><p class="mb-0">Sinh nhật</p></div>
                                                <div class="col-sm-9"><p class="mb-0">${empty pet.petDob ? 'Chưa có thông tin' : pet.petDob}</p></div>
                                            </div>
                                            <hr>
                                            <div class="row">
                                                <div class="col-sm-3 account-info-title"><p class="mb-0">Trạng thái</p></div>
                                                <div class="col-sm-9">
                                                    <c:choose>
                                                        <c:when test="${pet.petStatus == 'booking'}">
                                                            <span style="color: #229954;">Đã đặt lịch</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span style="color: red;">Chưa từng đặt lịch</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="text-end">
                                        <button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#removePetModal" 
                                                style="padding: 8px 18px;">
                                            <span style="font-size: 16px;">Xoá thú cưng</span>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>                                      

                </div>

                <!-- Sidebar -->
                <div class="col-md-4">
                    <div class="list-group account-action">
                        <!-- Thông tin cá nhân -->
                        <a href="profile" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="fa-regular fa-user fa-lg" style="color: #0062ad;"></i>
                            <span>Thông tin cá nhân</span>
                        </a>
                        <!-- Thú cưng của tôi -->
                        <a href="viewpet" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="fa-solid fa-paw fa-lg" style="color: #8C6E63;"></i>
                            <span style="color: #D3A376;"><b>Thú cưng của tôi</b></span>
                        </a>
                        <!-- Đổi mật khẩu -->
                        <c:if test="${customer.email != null and fn:contains(customer.email, '@')}">
                            <a href="changepassword" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                                <i class="fa-solid fa-key fa-lg" style="color: #eabd1a;"></i>
                                <span>Đổi mật khẩu</span>
                            </a>
                        </c:if>
                        <a href="order?&action=view&status=tc" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="bi bi-clipboard-check fs-4" style="color: #008080;"></i>
                            <span>Lịch sử đơn hàng</span>
                        </a>
                        <a href="bookinghistory" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="bi bi-calendar-date fs-4" style="color: #808000;"></i>
                            <span>Lịch sử đặt lịch</span>
                        </a>
                        <!-- Đăng xuất -->
                        <a href="logout" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
                            <i class="fa-solid fa-arrow-right-from-bracket fa-lg" style="color: #d01616;"></i>
                            <span>Đăng xuất</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <script>
            document.getElementById('petImageUpload').addEventListener('change', function (event) {
                const file = event.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        document.getElementById('petImagePreview').src = e.target.result;
                    };
                    reader.readAsDataURL(file);
                }
            });


        </script>
        <script>
            function previewFile() {
                const fileInput = document.getElementById('editPetImage');
                const previewImage = document.getElementById('previewImage');
                const uploadText = document.getElementById('uploadText');

                const file = fileInput.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        previewImage.src = e.target.result;
                        previewImage.style.display = "block";
                        uploadText.innerText = "Đổi ảnh";
                    };
                    reader.readAsDataURL(file);
                }
            }
        </script>
        <script>
            function validateEditPetForm() {
                let isValid = true;

// Lấy giá trị từ form
                let petName = document.getElementsByName("petName")[0].value.trim();
                let petBreed = document.getElementsByName("petBreed")[0].value.trim();
                let petWeight = document.getElementsByName("petWeight")[0].value.trim();
                let petDob = document.getElementsByName("petDob")[0].value;

// Xóa thông báo lỗi trước đó
                document.getElementById("petNameError").innerText = "";
                document.getElementById("petBreedError").innerText = "";
                document.getElementById("petWeightError").innerText = "";
                document.getElementById("petDobError").innerText = "";

// Kiểm tra tên thú cưng
                if (petName === "") {
                    document.getElementById("petNameError").innerText = "Tên thú cưng không được để trống!";
                    isValid = false;
                } else if (petName.length > 50) {
                    document.getElementById("petNameError").innerText = "Tên thú cưng tối đa 50 ký tự!";
                    isValid = false;
                }

// Kiểm tra giống thú cưng
                if (petBreed === "") {
                    document.getElementById("petBreedError").innerText = "Giống thú cưng không được để trống!";
                    isValid = false;
                } else if (petBreed.length > 50) {
                    document.getElementById("petBreedError").innerText = "Giống thú cưng tối đa 50 ký tự!";
                    isValid = false;
                }

// Kiểm tra cân nặng
                if (petWeight === "") {
                    document.getElementById("petWeightError").innerText = "Cân nặng không được để trống!";
                    isValid = false;
                } else if (isNaN(petWeight) || petWeight <= 0 || petWeight > 50) {
                    document.getElementById("petWeightError").innerText = "Cân nặng phải từ 0.1 đến 50 kg!";
                    isValid = false;
                }

// Kiểm tra ngày sinh
                let today = new Date().toISOString().split("T")[0]; // Ngày hôm nay
                if (petDob === "") {
                    document.getElementById("petDobError").innerText = "Ngày sinh không được để trống!";
                    isValid = false;
                } else if (petDob > today) {
                    document.getElementById("petDobError").innerText = "Ngày sinh không hợp lệ!";
                    isValid = false;
                }

                return isValid;
            }

// Gán sự kiện submit cho form
            document.querySelector("form[action='editpet']").addEventListener("submit", function (event) {
                if (!validateEditPetForm()) {
                    event.preventDefault(); // Chặn form nếu có lỗi
                }
            });
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
    </body>
</html>
