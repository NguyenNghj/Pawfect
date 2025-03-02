<%-- 
    Document   : petRoom
    Created on : Feb 11, 2025, 3:54:33 PM
    Author     : Nguyen Tien Thanh - CE181342
--%>

<%@page import="model.PetHotel"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@ page import="java.text.NumberFormat, java.util.Locale" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;600;800&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="../../css/dashboard.css">
        <title>Quản lí Pet Hotel</title>
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

                    <button class="btn btn-primary" onclick="window.location.href = 'addroom'">
                        <i class="fa fa-plus"></i> Thêm Phòng Mới
                    </button>



                    <%
                        List<PetHotel> petRooms = (List<PetHotel>) request.getAttribute("petRooms");
                    %>

                    <div class="row" style="margin-top: 20px; margin-bottom: 50px;">
                        <div class="main-dashboard-table">
                            <div class="d-flex justify-content-center align-items-center gap-3 main-dashboard-table-header"
                                 style="background-color: #8C6E63; color: white; border-top-left-radius: 6px; border-top-right-radius: 6px;">                                                 
                                <i class="fa-solid fa-hotel fa-lg"></i>
                                <h4 class="mb-0">Danh sách phòng thú cưng</h4>
                            </div>

                            <div style="padding: 15px 15px 25px 15px;">
                                <table class="table table-hover">
                                    <thead class="table-primary" style="text-align: center; vertical-align: middle; padding: 12px; font-weight: bold;">
                                        <tr>
                                            <th scope="col">Tên phòng</th>
                                            <th scope="col">Loại</th>
                                            <th scope="col">Cân nặng tối thiểu (kg)</th>
                                            <th scope="col">Cân nặng tối đa (kg)</th>
                                            <th scope="col">Giá (VNĐ)</th>
                                            <th scope="col">Mô tả</th>
                                            <th scope="col">Số lượng</th>
                                            <th scope="col">Trạng thái</th>
                                            <th scope="col">Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% if (petRooms != null && !petRooms.isEmpty()) {
                                                for (PetHotel room : petRooms) {%>
                                        <tr>
                                            <td style="width: 12%;"><%= room.getRoomName()%></td>
                                            <td style="width: 9%;"><%= room.getRoomType()%></td>
                                            <td style="text-align: center;"><%= room.getMinWeight()%></td>
                                            <td style="text-align: center;"><%= room.getMaxWeight()%></td>
                                            <%
                                                NumberFormat formatter = NumberFormat.getNumberInstance(new Locale("vi", "VN"));
                                            %>
                                            <td style="text-align: center;"><%= formatter.format(room.getPricePerNight())%></td>
                                            <td><%= room.getDescription()%></td>
                                            <td style="width: 8%; text-align: center;"><%= room.getQuantity()%></td>
                                            <td style="width: 10%;">
                                                <span style="font-weight: bold; color: white; padding: 5px; color: <%= room.getStatus().equals("Còn phòng") ? "green" : "red"%>;">
                                                    <%= room.getStatus()%>
                                                </span>
                                            </td>

                                            <td style="width: 12%;">
                                                <button type="button" class="btn btn-primary" onclick="editRoom(<%= room.getRoomId()%>)">Sửa</button>
                                                <script>
                                                    function editRoom(roomId) {
                                                        window.location.href = 'editroom?room_id=' + roomId;
                                                    }
                                                </script>

                                                <!-- Nút Xóa -->
                                                <button type="button" class="btn btn-danger btn-sm" 
                                                        onclick="confirmDelete('<%= room.getRoomId()%>')">
                                                    <i class="fa fa-trash"></i> Xóa
                                                </button>

                                                <script>
                                                    function confirmDelete(roomId) {
                                                        Swal.fire({
                                                            title: `Bạn có chắc chắn muốn xóa phòng có ID ${roomId} không?`,
                                                            text: "Hành động này không thể hoàn tác!",
                                                            icon: "warning",
                                                            showCancelButton: true,
                                                            confirmButtonColor: "#007BFF",
                                                            cancelButtonColor: "#DC3545",
                                                            confirmButtonText: "Có, xóa phòng",
                                                            cancelButtonText: "Hủy, quay lại"
                                                        }).then((result) => {
                                                            if (result.isConfirmed) {
                                                                let form = document.createElement("form");
                                                                form.method = "POST";
                                                                form.action = "/deleteroom";
                                                                let input = document.createElement("input");
                                                                input.type = "hidden";
                                                                input.name = "roomId";
                                                                input.value = roomId;
                                                                form.appendChild(input);
                                                                document.body.appendChild(form);
                                                                form.submit();
                                                            }
                                                        });
                                                    }

                                                </script>

                                            </td>
                                        </tr>
                                        <% }
                                        } else { %>
                                        <tr>
                                            <td colspan="5" class="text-center">
                                                <div class="alert alert-warning" role="alert">
                                                    Không có phòng nào được tìm thấy.
                                                </div>
                                            </td>
                                        </tr>
                                        <% }%>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>        
                </div>

            </div>
        </div>


        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    </body>
</html>
