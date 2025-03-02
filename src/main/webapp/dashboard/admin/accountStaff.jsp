<%-- 
    Document   : accountStaff
    Created on : Feb 11, 2025, 3:47:15 PM
    Author     : Vu Quang Duc - CE181221
--%>

<%@page import="dao.StaffDAO"%>
<%@page import="model.Staff"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="../../css/dashboard.css">
        <title>JSP Page</title>
        <style>
            /* Thiết kế cơ bản cho nút */
            .delete-btn {
                color: white;
                background-color: red; /* Màu đỏ để cảnh báo */
                padding: 8px 12px;
                text-decoration: none;
                border-radius: 5px;
                font-weight: bold;
                border: none;
                cursor: pointer;
                transition: background-color 0.3s ease-in-out;
            }

            /* Hiệu ứng khi di chuột vào */
            .delete-btn:hover {
                background-color: darkred; /* Đỏ đậm hơn khi hover */
            }

            /* Tạo khoảng cách giữa các nút nếu cần */
            .delete-btn + .delete-btn {
                margin-left: 10px;
            }

        </style>
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
                                <h1>Employee Account Management</h1>
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
                                            <a class="dropdown-item" style="padding: 0;" href="#">Switch to employee</a>
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
                                <li class="breadcrumb-item active" aria-current="page">Employee</li>
                            </ol>
                        </nav>
                    </div>   

                    <div class="row">
                        <div class="col-3 p-0" style="margin-top: 60px;">
                            <button type="button" class="btn btn-primary"
                                    data-bs-toggle="modal" data-bs-target="#exampleModal"
                                    >
                                <i class="fa-solid fa-plus"></i>
                                New Employee
                            </button>

                            <!-- Modal of Add Staff -->
                            <div class="modal fade" id="exampleModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 class="modal-title fs-5" id="exampleModalLabel">Thêm Nhân Viên</h1>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <form action="staffadd" method="post">
                                                <div class="form-floating mb-3">
                                                    <input type="email" class="form-control" id="email" name="email" placeholder="name@example.com" required>
                                                    <label for="email">Email</label>                        
                                                </div>
                                                <div class="form-floating mb-3">
                                                    <input type="password" class="form-control" id="password" name="password" placeholder="Mật khẩu" required>
                                                    <label for="password">Password</label>                        
                                                </div>
                                                <div class="form-floating mb-3">
                                                    <input type="text" class="form-control" id="full_name" name="full_name" placeholder="Họ và tên" required>
                                                    <label for="full_name">Full Name</label>                        
                                                </div>
                                                <div class="form-floating mb-3">
                                                    <input type="text" class="form-control" id="phone" name="phone" placeholder="Số điện thoại">
                                                    <label for="phone">Phone</label>                        
                                                </div>
                                                <div class="form-floating mb-3">
                                                    <input type="text" class="form-control" id="address" name="address" placeholder="Địa chỉ">
                                                    <label for="address">Address</label>                        
                                                </div>
                                                <div class="form-floating mb-3">
                                                    <select class="form-select" id="gender" name="gender">
                                                        <option selected value="Khác">Others</option>
                                                        <option value="Nam">Male</option>
                                                        <option value="Nữ">Female</option>
                                                    </select>
                                                    <label for="gender">Gender</label>                      
                                                </div>
                                                <div class="form-floating mb-3">
                                                    <input type="date" class="form-control" id="birth_date" name="birth_date" required>
                                                    <label for="birth_date">Birth Date</label>
                                                </div>
                                                <div class="form-check mb-3">
                                                    <input class="form-check-input" type="checkbox" id="is_active" name="is_active" checked>
                                                    <label class="form-check-label" for="is_active">
                                                        Active
                                                    </label>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                    <button type="submit" class="btn btn-primary">Add</button> <!-- Đổi sang submit -->
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>        
                    </div>
                    <!-- Hiển THị List -->

                    <div class="row" style="margin-top: 20px; margin-bottom: 50px;">
                        <div class="main-dashboard-table">
                            <div class="d-flex justify-content-center align-items-center gap-3 main-dashboard-table-header"
                                 style="background-color: #007BFF; color: white; border-top-left-radius: 6px; border-top-right-radius: 6px;">                                                 
                                <i class="fa-solid fa-address-card" style="font-size: 22px;"></i>
                                <h4 class="mb-0">Danh Sách Nhân Viên</h4>
                            </div>
                            <div style="padding: 15px 15px 25px 15px;">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Vai trò</th>
                                            <th>Mật khẩu</th>
                                            <th>Họ và Tên</th>
                                            <th>Email</th>
                                            <th>SDT</th>
                                            <th>Địa chỉ</th>
                                            <th>Giới tính</th>
                                            <th>Ngày sinh</th>
                                            <th>Trạng thái</th>
                                            <th>Hành động</th> <!-- Thêm cột này -->
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            List<Staff> staffList = (List<Staff>) request.getAttribute("staffList");
                                            if (staffList != null && !staffList.isEmpty()) {
                                                for (Staff staff : staffList) {
                                        %>
                                        <tr>
                                            <td><%= staff.getStaffId()%></td>
                                            <td><%= staff.getRoleName()%></td>
                                            <td><%= staff.getPassword()%></td>
                                            <td><%= staff.getFullName()%></td>
                                            <td><%= staff.getEmail()%></td>
                                            <td><%= staff.getPhone()%></td>
                                            <td><%= staff.getAddress()%></td>
                                            <td><%= staff.getGender()%></td>
                                            <td><%= staff.getBirthDate()%></td>
                                            <td><%= staff.isActive() ? "Hoạt động" : "Đã nghỉ"%></td>
                                            <td>
                                                <a href="staffdelete?id=<%= staff.getStaffId()%>&action=delete" 
                                                   class="delete-btn"
                                                   onclick="return confirm('Bạn có chắc muốn cấm khách hàng này?');">
                                                    xóa
                                                </a>

                                            </td>
                                        </tr>
                                        <%
                                            }
                                        } else {
                                        %>
                                        <tr>
                                            <td colspan="11">Không có nhân viên nào.</td>
                                        </tr>
                                        <%
                                            }
                                        %>
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
        <script>
                                                       const exampleModal = document.getElementById('exampleModal')
                                                       if (exampleModal) {
                                                           exampleModal.addEventListener('show.bs.modal', event => {
                                                               // Button that triggered the modal
                                                               const button = event.relatedTarget
                                                               // Extract info from data-bs-* attributes
                                                               const recipient = button.getAttribute('data-bs-whatever')
                                                               // If necessary, you could initiate an Ajax request here
                                                               // and then do the updating in a callback.

                                                               // Update the modal's content.
                                                               const modalTitle = exampleModal.querySelector('.modal-title')
                                                               const modalBodyInput = exampleModal.querySelector('.modal-body input')

                                                               modalTitle.textContent = `New message to ${recipient}`
                                                               modalBodyInput.value = recipient
                                                           })
                                                       }
        </script>
    </body>
</html>
