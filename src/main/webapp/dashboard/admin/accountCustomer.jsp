<%-- 
    Document   : accountCustomer
    Created on : Feb 11, 2025, 3:47:25 PM
    Author     : Vu Quang Duc - CE181221
--%>

<%@page import="model.Customers"%>
<%@page import="model.Customers"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="../../css/dashboard.css">
        <title>Quản Lí Khách Hàng</title>
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
                                <h1>Quản lí khách hàng</h1>
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

                    <div class="row mt-2 bg-white p-3 d-flex align-items-center justify-content-center" 
                         style="border-radius: 20px; height: 60px;">
                        <nav style="--bs-breadcrumb-divider: '>'; padding: 0 5px;" aria-label="breadcrumb">
                            <ol class="breadcrumb mb-0" style ="font-weight: bold;">
                                <li class="breadcrumb-item">Dashboard</li>
                                <li class="breadcrumb-item active" aria-current="page">Quản lí khách hàng</li>
                            </ol>
                        </nav>
                    </div>   

                    <div class="row d-flex align-items-center" style="margin-top: 30px;">
                        <!-- Form Tìm Kiếm -->
                        <div class="col-md-6">
                            <form action="product" method="get" class="d-flex">
                                <label for="inputName" class="col-sm-2 col-form-label">Tìm kiếm:</label>
                                <input name="search" type="search" class="form-control" id="inputName" placeholder="Tên khách hàng...">
                            </form>
                        </div>
                    </div>

                    <div class="row" style="margin-top: 20px; margin-bottom: 50px;">
                        <div class="main-dashboard-table">
                            <div class="d-flex justify-content-center align-items-center gap-3 main-dashboard-table-header"
                                 style="background-color: #8C6E63; color: white; border-top-left-radius: 6px; border-top-right-radius: 6px;">                                               
                                <i class="fa-solid fa-user-tie" style="font-size: 20px;"></i>
                                <h4 class="mb-0">Danh Sách Khách Hàng</h4>
                            </div>
                            <div style="padding: 15px;">

                                <table class="table">

                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Họ và Tên</th>
                                            <th>Email</th>
                                            <th>Số điện thoại</th>
                                            <th>Địa chỉ</th>
                                            <th>Giới tính</th>
                                            <th>Ngày sinh</th>
                                            <th>Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            List<Customers> customerList = (List<Customers>) request.getAttribute("customerList");
                                            if (customerList != null) {
                                                for (Customers customer : customerList) {
                                        %>
                                        <tr>
                                            <td><%= customer.getCustomerId()%></td>
                                            <td><%= customer.getFullName()%></td>
                                            <td><%= customer.getEmail()%></td>
                                            <td><%= customer.getPhone()%></td>
                                            <td><%= customer.getAddress()%></td>
                                            <td><%= customer.getGender()%></td>
                                            <td><%= customer.getBirthDate()%></td>
                                            <td>
                                                <% if ("admin".equalsIgnoreCase(staffRole)) { %> 
                                                <% if (customer.isActive()) {%>
                                                <form action="customersban" method="get" onsubmit="return confirm('Bạn có chắc muốn cấm khách hàng này?');">
                                                    <input type="hidden" name="id" value="<%= customer.getCustomerId()%>">
                                                    <input type="hidden" name="action" value="ban">
                                                    <button type="submit" class="btn btn-danger">Cấm</button>
                                                </form>
                                                <% } else {%>
                                                <form action="customersban" method="get" onsubmit="return confirm('Bạn có chắc muốn gỡ cấm khách hàng này?');">
                                                    <input type="hidden" name="id" value="<%= customer.getCustomerId()%>">
                                                    <input type="hidden" name="action" value="unban">
                                                    <button type="submit" class="btn btn-success">Mở</button>
                                                </form>
                                                <% } %>
                                                <% } else { %>
                                                <span class="text-muted">Không có quyền</span>
                                                <% } %>
                                            </td>
                                        </tr>
                                        <%
                                            }
                                        } else {%>
                                        <!-- Hiển thị thông báo nếu không tìm thấy khách hàng -->
                                    <div class="alert alert-warning text-center" role="alert">
                                        No customers found. Please try again with a different name.
                                    </div>
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
