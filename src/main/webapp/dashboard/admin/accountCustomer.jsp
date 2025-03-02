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
        <title>JSP Page</title>
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
                                <h1>Customer Account Management</h1>
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
                                <li class="breadcrumb-item active" aria-current="page">Customer</li>
                            </ol>
                        </nav>
                    </div>   


                    <style>
                        /* Thiết lập chung cho bảng */
                        .table {
                            width: 100%;
                            border-collapse: collapse;
                            background-color: white;
                        }

                        /* Căn trái toàn bộ nội dung trong bảng */
                        .table th,
                        .table td {
                            text-align: left !important;
                            padding: 10px;
                            vertical-align: middle;
                        }
                        /* Định dạng tiêu đề bảng */
                        .main-dashboard-table-header {
                            background-color: #007BFF;
                            color: white;
                            border-top-left-radius: 6px;
                            border-top-right-radius: 6px;
                            text-align: left;
                            padding: 12px 15px;
                        }

                        /* Màu nền và kiểu chữ cho tiêu đề */
                        .main-dashboard-table-header {
                            background-color: #007BFF;
                            color: white;
                            font-weight: bold;
                            padding: 12px;
                            text-align: center;
                            border-top-left-radius: 6px;
                            border-top-right-radius: 6px;
                        }

                        /* Gạch ngang ngăn cách từng khách hàng */
                        .table tbody tr {
                            border-bottom: 1px solid #ddd;
                        }

                        /* Định dạng hàng tiêu đề */
                        .table thead {
                            background-color: #007BFF;
                            color: white;
                        }

                        /* Tạo hover cho hàng */
                        .table tbody tr:hover {
                            background-color: #f5f5f5;
                        }

                        /* CSS cho nút "Cấm" */
                        .ban-btn {
                            background-color: red;
                            color: white;
                            padding: 6px 12px;
                            border-radius: 4px;
                            text-decoration: none;
                            font-weight: bold;
                            transition: 0.3s;
                        }

                        /* Hiệu ứng hover cho nút "Cấm" */
                        .ban-btn:hover {
                            background-color: darkred;
                        }
                    </style>
                    <div class="row" style="margin-top: 20px; margin-bottom: 50px;">
                        <div class="main-dashboard-table">
                            <div class="d-flex justify-content-center align-items-center gap-3 main-dashboard-table-header">                                                 
                                <i class="fa-solid fa-user-tie" style="font-size: 20px;"></i>
                                <h4 class="mb-0">Danh Sách Khách Hàng</h4>
                            </div>
                            <div style="padding: 15px;">
                                <!-- Search Form -->
                                <div style="padding: 15px;">
                                    <form action="customers" method="get" class="d-flex mb-3 search-form align-items-center">
                                        <input type="text" name="keyword" class="form-control search-input" placeholder="Tìm Kiếm Theo Tên"
                                               value="<%= request.getAttribute("searchKeyword") != null ? request.getAttribute("searchKeyword") : ""%>">
                                        <button type="submit" class="btn btn-primary search-btn">Tìm Kiếm</button>
                                    </form>

                                    <style>
                                        .search-form {
                                            max-width: 300px; /* Giới hạn chiều rộng */
                                            display: flex;
                                            justify-content: start; /* Căn trái */
                                        }
                                        .search-input {
                                            flex: 1;
                                            padding: 6px;
                                            font-size: 14px;
                                            height: 35px;
                                        }
                                        .search-btn {
                                            padding: 6px 10px;
                                            font-size: 14px;
                                            height: 35px;
                                            white-space: nowrap;
                                        }
                                        .ban-btn, .unban-btn {
                                            display: inline-block;
                                            width: 80px; /* Đảm bảo cả hai nút có cùng chiều rộng */
                                            text-align: center;
                                            color: white;
                                            padding: 8px 0;
                                            font-size: 14px;
                                            font-weight: bold;
                                            text-decoration: none;
                                            border-radius: 5px;
                                            border: none;
                                            cursor: pointer;
                                        }

                                        .ban-btn {
                                            background-color: red;
                                        }

                                        .unban-btn {
                                            background-color: green;
                                        }

                                        .ban-btn:hover {
                                            background-color: darkred;
                                        }

                                        .unban-btn:hover {
                                            background-color: darkgreen;
                                        }

                                    </style>

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
                                                    <% if (customer.isActive()) {%>
                                                    <a href="customersban?id=<%= customer.getCustomerId()%>&action=ban" 
                                                       class="ban-btn"
                                                       onclick="return confirm('Bạn có chắc muốn cấm khách hàng này?');">
                                                        Cấm
                                                    </a>
                                                    <% } else {%>
                                                    <a href="customersban?id=<%= customer.getCustomerId()%>&action=unban" 
                                                       class="unban-btn"
                                                       onclick="return confirm('Bạn có chắc muốn mở lại khách hàng này?');">
                                                        Mở
                                                    </a>
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
