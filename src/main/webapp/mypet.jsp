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
                            <a href="order?&action=view&status=tc" class="text-decoration-none">
                                <div class="card h-100">
                                    <div class="card-body d-flex align-items-center gap-3">
                                        <i class="bi bi-clipboard-check fs-4 text-primary"></i>
                                        <span class="text-decoration-none text-dark">Lịch sử đơn hàng</span>
                                    </div>
                                </div>
                            </a>

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
                            <a href="profile" class="text-decoration-none">
                                <div class="card h-100">
                                    <div class="card-body d-flex align-items-center gap-3">
                                        <i class="bi bi-person-circle fs-4"></i>
                                        <span>Xin chào, <span class="text-primary">${customer.fullName}</span></span>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>

                    <!-- Orders Section -->
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title mb-4">Thú cưng của bạn</h5>
                            <div>
                                <button class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#editPetModal" 
                                        style="padding: 8px 18px;"
                                        >
                                    <span style="font-size: 16px;">Thêm thú cưng</span>
                                </button>

                            </div>   
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
                                                                <img class="rounded" src="/img/pet/${pro.petImg != null ? pro.petImg : 'default.jpg'}" 
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

                            <!-- Modal sửa thông tin thú cưng -->
                            <form action="addpet" method="post" enctype="multipart/form-data" onsubmit="return validateEditPetForm()">
                                <div class="modal fade" id="editPetModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="editPetModalLabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h1 class="modal-title fs-5" id="editPetModalLabel">Thêm thông tin thú cưng</h1>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body edit-pet-detail">
                                                <input type="hidden" name="petId" >
                                                <input type="hidden" name="existingImage" >



                                                <!-- Input chọn ảnh -->
                                                <div class="mb-3">
                                                    <label for="editProductImage" class="form-label">Hình ảnh</label>
                                                    <div style="display: flex; gap: 10px;">
                                                        <img id="previewImage" class="img-thumbnail" style="width: 220px; height: 220px; display: ${not empty pet.petImg ? 'block' : 'none'};" src="/img/pet/${pet.petImg}" alt="Ảnh sản phẩm">
                                                        <input type="file" id="editPetImage" name="petImage" accept="image/*" style="display: none;" onchange="previewFile()">
                                                        <div class="image-box" onclick="document.getElementById('editPetImage').click()" style="cursor: pointer; border: 1px dashed #ccc; padding: 20px; text-align: center; width: 220px; height: 220px; display: flex; align-items: center; justify-content: center;">
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
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                <button type="submit" class="btn btn-success">Thêm</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
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
