<%-- 
    Document   : myPetHistory
    Created on : Feb 16, 2025, 7:39:55 PM
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
    </head>
    <body>
        <div class="container py-4">
            <!-- Breadcrumb -->
            <div class="row mt-2 bg-white p-3 mb-4 d-flex align-items-center justify-content-center" 
                 style="border-radius: 20px; height: 60px;">
                <nav padding: 0 5px;" aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0" style ="font-weight: bold;">
                        <li class="breadcrumb-item"><a href="pawfect" class="text-decoration-none">Trang chủ</a></li>
                        <li class="breadcrumb-item"><a href="viewpet" class="text-decoration-none">Thú cưng của tôi</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Thêm thú cưng</li>
                    </ol>
                </nav>
            </div>

            <div class="row g-4">
                <!-- Main Content -->
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-body">    
                            <form action="createpet" method="post" enctype="multipart/form-data" onsubmit="return validateEditPetForm()">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="card-title fs-5" id="editPetModalLabel">Thêm thông tin thú cưng</h5>

                                        </div>
                                        <div class="modal-body edit-pet-detail">
                                            <input type="hidden" name="petId" >
                                            <input type="hidden" name="existingImage" >

                                            <!-- Input chọn ảnh -->
                                            <div class="mb-3">
                                                <label for="editProductImage" class="form-label pt-4">Hình ảnh</label>
                                                <div style="display: flex; gap: 10px; align-items: center;">
                                                    <img id="previewImage" class="img-thumbnail" 
                                                         style="width: 150px; height: 150px; display: ${not empty pet.petImg ? 'block' : 'none'};" 
                                                         src="/img/pet/${pet.petImg}" 
                                                         alt="Ảnh sản phẩm">
                                                    <input type="file" id="editPetImage" name="petImage" accept="image/*" style="display: none;" onchange="previewFile()">
                                                    <div class="image-box" onclick="document.getElementById('editPetImage').click()" 
                                                         style="cursor: pointer; border: 1px dashed #ccc; padding: 15px; text-align: center; width: 150px; height: 150px; display: flex; align-items: center; justify-content: center;">
                                                        <span id="uploadText">Thêm ảnh</span>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row mb-3">
                                                <!-- Tên thú cưng -->
                                                <div class="col-md-9">
                                                    <label class="form-label">Tên thú cưng</label>
                                                    <input type="text" name="petName" class="form-control">
                                                    <span id="petNameError" class="text-danger"></span>
                                                </div>

                                                <!-- Loài -->
                                                <div class="col-md">
                                                    <label class="form-label">Loài</label>
                                                    <select class="form-select" name="petType">
                                                        <option value="Chó" >Chó</option>
                                                        <option value="Mèo" >Mèo</option>
                                                    </select>
                                                </div>
                                            </div>

                                            <!-- Giống thú cưng -->
                                            <div class="mb-3">
                                                <label class="form-label">Giống thú cưng</label>
                                                <input type="text" name="petBreed" class="form-control">
                                                <span id="petBreedError" class="text-danger"></span>
                                            </div>

                                            <!-- Giới tính -->
                                            <div class="mb-3">
                                                <label class="form-label">Giới tính</label>
                                                <select class="form-select" name="petSex">
                                                    <option value="Đực" >Đực</option>
                                                    <option value="Cái" >Cái</option>
                                                </select>
                                            </div>

                                            <!-- Cân nặng -->
                                            <div class="mb-3">
                                                <label class="form-label">Cân nặng (kg)</label>
                                                <input type="number" name="petWeight" value="" class="form-control" step="0.01">
                                                <span id="petWeightError" class="text-danger"></span>
                                            </div>

                                            <!-- Sinh nhật -->
                                            <div class="mb-3">
                                                <label class="form-label">Sinh nhật</label>
                                                <input type="date" name="petDob"  class="form-control">
                                                <span id="petDobError" class="text-danger"></span>
                                            </div>
                                        </div>

                                        <div class="modal-footer">
                                            <button type="submit" class="btn btn-success me-2">Thêm thú cưng</button>
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="window.location.href = 'viewpet'">Trở lại</button>
                                        </div>
                                    </div>
                                </div>

                            </form>


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
                        <a href="bookinghistory?status=tc" class="list-group-item list-group-item-action d-flex align-items-center gap-3">
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

            function validateEditPetForm() {
                let isValid = true;

                // Lấy dữ liệu từ form
                let petName = document.querySelector("[name='petName']").value.trim();
                let petBreed = document.querySelector("[name='petBreed']").value.trim();
                let petWeight = document.querySelector("[name='petWeight']").value.trim();
                let petDob = document.querySelector("[name='petDob']").value;
                let petImage = document.querySelector("[name='petImage']").files.length;

                // Lấy phần hiển thị lỗi
                let petNameError = document.getElementById("petNameError");
                let petBreedError = document.getElementById("petBreedError");
                let petWeightError = document.getElementById("petWeightError");
                let petDobError = document.getElementById("petDobError");

                // Reset lỗi
                petNameError.innerText = "";
                petBreedError.innerText = "";
                petWeightError.innerText = "";
                petDobError.innerText = "";

                // Kiểm tra tên thú cưng
                if (petName === "") {
                    petNameError.innerText = "Tên thú cưng không được để trống.";
                    isValid = false;
                }

                // Kiểm tra giống thú cưng
                if (petBreed === "") {
                    petBreedError.innerText = "Giống thú cưng không được để trống.";
                    isValid = false;
                }

                // Kiểm tra cân nặng (phải là số dương)
                if (petWeight === "" || isNaN(petWeight) || parseFloat(petWeight) <= 0) {
                    petWeightError.innerText = "Cân nặng phải là số dương.";
                    isValid = false;
                }

                // Kiểm tra ngày sinh (không được lớn hơn ngày hiện tại)
                let today = new Date().toISOString().split("T")[0]; // Lấy ngày hiện tại
                if (petDob === "") {
                    petDobError.innerText = "Vui lòng chọn ngày sinh.";
                    isValid = false;
                } else if (petDob > today) {
                    petDobError.innerText = "Ngày sinh không được lớn hơn ngày hiện tại.";
                    isValid = false;
                }

                // Kiểm tra nếu có chọn ảnh (khi thêm mới)
                if (petImage === 0) {
                    alert("Vui lòng chọn một ảnh cho thú cưng.");
                    isValid = false;
                }

                return isValid;
            }

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

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
    </body>
</html>
