<%-- 
    Document   : petRoom
    Created on : Feb 11, 2025, 3:54:33 PM
    Author     : Nguyen Tien Thanh - CE181342
--%>

<%@page import="model.PetHotel"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="../../css/dashboard.css">
        <title>Thêm mới Pet Hotel</title>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">

                <!-- SIDEBAR -->
                <jsp:include page="sidebar.jsp"/>


                <!-- MAIN -->
                <div class="col" id="main" style="padding: 0 40px;">
                    <div class="row pt-4">
                        <div class="d-flex align-items-center justify-content-between" style="padding: 0;">
                            <div>
                                <h1>Quản lí Pet Hotel</h1>
                            </div>
                            <div class="dropdown d-flex align-items-center gap-2">
                                <span>Username2025 (Admin)</span>
                                <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <img class="profile-img" src="https://img.freepik.com/foto-gratis/hombre-tiro-medio-peinado-afro_23-2150677136.jpg" alt="">
                                </button>
                                <ul class="dropdown-menu ps-2 pe-2 pt-2 pb-2">
                                    <div class="d-grid gap-2">
                                        <li class="profile-img-switch-employee d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-repeat"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="#">Switch to employee</a>
                                        </li>
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
                                <li class="breadcrumb-item"><a href="#">Home</a></li>
                                <li class="breadcrumb-item active" aria-current="page">PetHotels</li>
                            </ol>
                        </nav>
                    </div>   
                    <div class="d-flex justify-content-center align-items-center gap-3 main-dashboard-table-header"
                         style="background-color: #8C6E63; color: white; border-top-left-radius: 6px; border-top-right-radius: 6px;">                                                 
                        <i class="fa-solid fa-hotel fa-lg"></i>
                        <h4 class="mb-0">Thêm phòng mới</h4>
                    </div>

                    <div class="addroom" style="background-color: white;" method="post">
                        <br>
                        <form id="addRoomForm" action="addroom" method="post" style="max-width: 400px; margin:  auto;" >
                            <label>Tên phòng:</label>
                            <input type="text" name="roomName" class="form-control" required style="margin-bottom: 10px;">
                            <label>Hình ảnh:</label>
                            <input type="text" name="roomImage" class="form-control" required style="margin-bottom: 10px;">
                            <label>Loại phòng:</label><br>
                            <input type="radio" name="roomType" value="Chó" /> Chó <br>
                            <input type="radio" name="roomType" value="Mèo" /> Mèo <br>
                            <label>Cân nặng tối thiểu (kg):</label>
                            <input type="number" name="minWeight" step="0.1" class="form-control" required style="margin-bottom: 10px;">

                            <label>Cân nặng tối đa (kg):</label>
                            <input type="number" name="maxWeight" step="0.1" class="form-control" required style="margin-bottom: 10px;">

                            <label>Số lượng:</label>
                            <input type="number" name="quantity" class="form-control" required style="margin-bottom: 10px;">

                            <label>Giá mỗi đêm (VNĐ):</label>
                            <input type="number" name="pricePerNight" step="0.01" class="form-control" required style="margin-bottom: 10px;">
                            <label>Mô tả:</label>
                            <input type="text" name="description" class="form-control" required style="margin-bottom: 10px;">


                            <button type="submit" class="btn btn-success mt-3">Thêm phòng</button>
                            <button type="button" class="btn btn-secondary mt-3" onclick="location.href = 'petroom'">Quay lại</button>
                        </form>
                        <br>

                    </div>
                </div>
            </div>
        </div>


        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    </body>
</html>
