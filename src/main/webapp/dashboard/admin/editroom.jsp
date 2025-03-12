<%-- 
    Document   : petRoom
    Created on : Feb 11, 2025, 3:54:33 PM
    Author     : Nguyen Tien Thanh - CE181342
--%>

<%@page import="dao.PetHotelDAO"%>
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
        <title>Chỉnh sửa Pet Hotel</title>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">

                <!-- SIDEBAR -->
                <jsp:include page="sidebar.jsp"/>

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
                <!-- MAIN -->
                <div class="col" id="main" style="padding: 0 40px;">
                    <div class="row pt-4">
                        <div class="d-flex align-items-center justify-content-between" style="padding: 0;">
                            <div>
                                <h1>Quản lí Pet Hotel</h1>
                            </div>
                            <div class="dropdown d-flex align-items-center gap-2">
                                <span><%= staffName%></span>
                                <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <img class="profile-img" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTf74k9hxcTCkLN2gyhCr9lzuzZax5iy0uDOA&s" alt="">
                                </button>
                                <ul class="dropdown-menu ps-2 pe-2 pt-2 pb-2">
                                    <div class="d-grid gap-2">
                                        <li class="profile-img-switch-employee d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-repeat"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="/dashboard/staff/dashboard.jsp">Switch to employee</a>
                                        </li>
                                        <li class="profile-img-switch-store d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-store"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="#">Go to store</a>
                                        </li>
                                        <hr style="margin: 0;">
                                        <li class="profile-img-info1 d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-user-pen"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="adminprofile">Profile</a>
                                        </li>
                                        <li class="profile-img-info2 d-flex align-items-center ps-2 pe-2 pt-1 pb-1 gap-3">
                                            <i class="fa-solid fa-right-from-bracket" style="font-size: 20px;"></i>
                                            <a class="dropdown-item" style="padding: 0;" href="logoutadmin">Logout</a>
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
                        <h4 class="mb-0">Chỉnh sửa thông tin</h4>
                    </div>
                    <%
                        int roomId = Integer.parseInt(request.getParameter("room_id"));
                        PetHotel room = PetHotelDAO.getPetRoomById(roomId);
                    %>
                    <div class="editroom" style="background-color: white;" method="post">
                        <br>
                        <form id="editRoomForm" action="editpethotel" method="post" style="max-width: 400px; margin:  auto;" >
                            <input type="hidden" name="room_id" value="<%= room.getRoomId()%>">

                            <label>Tên phòng:</label>
                            <input type="text" name="room_name" class="form-control" value="<%= room.getRoomName()%>" required style="margin-bottom: 10px;">

                            <label>Hình ảnh:</label>
                            <input type="text" name="room_image" class="form-control" value="<%= room.getRoomImage()%>" required style="margin-bottom: 10px;">

                            <label>Loại phòng:</label><br>
                            <input type="radio" name="room_type" value="Chó" <%= room.getRoomType().equals("Chó") ? "checked" : ""%> /> Chó <br>
                            <input type="radio" name="room_type" value="Mèo" <%= room.getRoomType().equals("Mèo") ? "checked" : ""%> /> Mèo <br>
                            <label>Cân nặng tối thiểu (kg):</label>
                            <input type="number" name="min_weight" step="0.1" class="form-control" value="<%= room.getMinWeight()%>" required style="margin-bottom: 10px;">

                            <label>Cân nặng tối đa (kg):</label>
                            <input type="number" name="max_weight" step="0.1" class="form-control" value="<%= room.getMaxWeight()%>" required style="margin-bottom: 10px;">

                            <label>Số lượng:</label>
                            <input type="number" name="quantity" class="form-control" value="<%= room.getQuantity()%>" required min="1" style="margin-bottom: 10px;">

                            <label>Giá mỗi đêm (VNĐ):</label>
                            <input type="number" name="price_per_night" step="0.01" class="form-control" value="<%= room.getPricePerNight()%>" required min="1" style="margin-bottom: 10px;">

                            <label>Mô tả:</label>
                            <input type="text" name="description" class="form-control" value="<%= room.getDescription()%>" required style="margin-bottom: 10px;">

                            <label>Trạng thái:</label>
                            <select id="status" name="status" class="form-control">
                                <option value="Còn phòng" <%= room.getStatus().equals("Còn phòng") ? "selected" : ""%>>Còn phòng</option>
                                <option value="Hết phòng" <%= room.getStatus().equals("Hết phòng") ? "selected" : ""%>>Hết phòng</option>
                            </select>
                            <button type="submit" class="btn btn-primary mt-3">Lưu thay đổi</button>
                            <button type="button" class="btn btn-secondary mt-3"  onclick="location.href = 'petroom'">Quay lại</button>
                        </form>
                        <br><br>
                    </div>
                </div>
            </div>
        </div>


        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    </body>
</html>
