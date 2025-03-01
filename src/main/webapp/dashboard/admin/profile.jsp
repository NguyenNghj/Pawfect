<%-- 
    Document   : profile
    Created on : Feb 11, 2025, 3:54:46 PM
    Author     : Vu Quang Duc - CE181221
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;600;800&display=swap" rel="stylesheet">
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
                            <div class="accordion w-100" id="accordionExample1">                               
                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed gap-3" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
                                        <i class="fa-solid fa-users fa-lg"></i>Account
                                    </button>
                                </h2>
                                <div id="collapseOne" class="accordion-collapse collapse" data-bs-parent="#accordionExample1">
                                    <div class="accordion-body">
                                        <nav class="navbar bg-body-tertiary" style="padding-bottom: 0;">
                                            <div class="container-fluid">
                                                <a class="navbar-brand" href="accountAdmin.jsp">Admin</a>
                                            </div>
                                        </nav>
                                        <nav class="navbar bg-body-tertiary" style="padding-bottom: 0;">
                                            <div class="container-fluid">
                                                <a class="navbar-brand" href="staff">Employee</a>
                                            </div>
                                        </nav>
                                        <nav class="navbar bg-body-tertiary" style="padding-bottom: 0;">
                                            <div class="container-fluid">
                                                <a class="navbar-brand" href="customers">Customer</a>
                                            </div>
                                        </nav>
                                    </div>
                                </div>                                              
                            </div>                    
                        </nav>
                        <nav class="navbar bg-body-tertiary">                                           
                            <a class="navbar-brand d-flex align-items-center gap-3" href="product.jsp">
                                <i class="fa-solid fa-box fa-lg"></i>
                                <span>Product</span>
                            </a>                          
                        </nav>
                        <nav class="navbar bg-body-tertiary">                   
                            <a class="navbar-brand d-flex align-items-center gap-3" href="productCategory.jsp">
                                <i class="fa-solid fa-boxes-stacked fa-lg"></i>
                                <span>Product Category</span>
                            </a>
                        </nav>
                        <nav class="navbar bg-body-tertiary">                                            
                            <a class="navbar-brand d-flex align-items-center gap-3" href="petroom">
                                <i class="fa-solid fa-hotel fa-lg"></i>  
                                <span>Pet Hotel</span>
                            </a>
                        </nav>
                        <!-- <nav class="navbar bg-body-tertiary">                        
                            <div class="accordion w-100" id="accordionExample2">                               
                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed gap-3" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                        <i class="fa-solid fa-comment fa-lg"></i>Feedback
                                    </button>
                                </h2>
                                <div id="collapseTwo" class="accordion-collapse collapse" data-bs-parent="#accordionExample2">
                                    <div class="accordion-body">
                                        <nav class="navbar bg-body-tertiary" style="padding-bottom: 0;">
                                            <div class="container-fluid">
                                                <a class="navbar-brand" href="#">Product</a>
                                            </div>
                                        </nav>
                                        <nav class="navbar bg-body-tertiary" style="padding-bottom: 0;">
                                        <div class="container-fluid">
                                                <a class="navbar-brand" href="#">Kennel</a>
                                            </div>
                                        </nav>
                                    </div>
                                </div>                                              
                            </div>                    
                        </nav>                   -->
                    </div>

                    <div class="row">
                        <hr style="margin: 10px 0;">
                    </div>

                    <div class="row">
                        <nav class="navbar bg-body-tertiary active">                                   
                            <a class="navbar-brand d-flex align-items-center gap-3" style="color: white; pointer-events: none;" href="adminprofile">
                                <i class="fa-solid fa-address-book fa-lg"></i>   
                                <span>Profile</span>
                            </a>                          
                        </nav>
                        <nav class="navbar bg-body-tertiary">                                              
                            <a class="navbar-brand d-flex align-items-center gap-3" href="logoutadmin">
                                <i class="fa-solid fa-right-from-bracket fa-lg"></i>
                                <span>Logout</span>
                            </a>
                        </nav>
                    </div>
                </div>


                <!-- MAIN -->
                <div class="col" id="main" style="padding: 0 40px;">
                    <div class="row pt-4">
                        <div class="d-flex align-items-center justify-content-between" style="padding: 0;">
                            <div>
                                <h1>Profile Settings</h1>
                            </div>
                            <div class="dropdown d-flex align-items-center gap-2">
                                <span>${staff.name}</span>
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
                                <li class="breadcrumb-item active" aria-current="page">Profile</li>
                            </ol>
                        </nav>
                    </div>            

                    <div class="row mt-3 align-items-center" style="background-color: white; padding: 20px; border-radius: 7px;">
                        <div class="col-4">
                            <div class="d-grid justify-content-center gap-3">
                                <img src="${staff.image}" alt=""
                                     style="width: 220px; height: 220px; border-radius: 50%; object-fit: cover;">
                                <div class="d-grid gap-1" style="text-align: center;">
                                    <%
                                        String message = (String) session.getAttribute("message");
                                        String messageType = (String) session.getAttribute("messageType");
                                        if (message != null) {
                                    %>
                                    <div class="alert <%= "success".equals(messageType) ? "alert-success" : "alert-danger"%>">
                                        <%= message%>
                                    </div>
                                    <%
                                            session.removeAttribute("message");
                                            session.removeAttribute("messageType");
                                        }
                                    %>
                                    <button type="button" class="btn btn-link text-decoration-none" data-bs-toggle="modal" data-bs-target="#changePassModal">
                                        Đổi mật khẩu
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Modal Change Password -->
                        <div class="modal fade" id="changePassModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="changePassModalLabel" aria-hidden="true">
                            <form action="changeadminpassword" method="POST" onsubmit="return validatePassword()">
                                <div class="modal-dialog modal-dialog-centered">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 class="modal-title fs-5" id="changePassModalLabel">Đổi mật khẩu</h1>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="mb-2">
                                                <label for="oldPassword" class="form-label">Mật khẩu cũ <span class="text-danger">*</span></label>
                                                <input type="password" name="password" class="form-control" id="oldPassword" required>
                                                <div class="text-danger" id="oldPasswordError"></div>
                                            </div>
                                            <div class="mb-2">
                                                <label for="newPassword" class="form-label">Mật khẩu mới <span class="text-danger">*</span></label>
                                                <input type="password" name="newPassword" class="form-control" id="newPassword" required>
                                                <div class="text-danger" id="newPasswordError"></div>
                                            </div>
                                            <div class="mb-2">
                                                <label for="confirmPassword" class="form-label">Xác nhận lại mật khẩu <span class="text-danger">*</span></label>
                                                <input type="password" name="newPassword2" class="form-control" id="confirmPassword" required>
                                                <div class="text-danger" id="confirmPasswordError"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                            <button type="submit" class="btn btn-primary">Đổi mật khẩu</button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <input type="hidden" name="password" value="${staff.password}">
                        <div class="col d-grid gap-3">
                            <div class="d-grid gap-3 profile-info">
                                <h3 style="margin: 0;">Thông tin người dùng</h3>
                                <span><b>Họ tên:</b> ${staff.name}</span>
                                <span><b>Email:</b> ${staff.email}</span>
                                <span><b>Điện thoại:</b> ${staff.phone}</span>
                                <span><b>Địa chỉ:</b> ${staff.address}</span>
                                <span><b>Giới tính:</b> ${staff.gender}</span>
                                <span><b>Sinh nhật:</b> ${staff.birthdate}</span>
                            </div>
                            <div>
                                <button type="button" class="btn btn-success d-flex align-items-center gap-2"
                                        data-bs-toggle="modal" data-bs-target="#exampleModal"
                                        >
                                    <i class="fa-solid fa-pen"></i>
                                    <span>Update</span>
                                </button>

                                <!-- Modal of Update -->
                                <div class="modal fade" id="exampleModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                    <form action="adminprofile" method="POST">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h1 class="modal-title fs-5" id="exampleModalLabel">Chỉnh sửa thông tin</h1>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">

                                                    <div class="form-floating mb-3">
                                                        <input type="text" class="form-control" id="recipient-name" value="${staff.name}"name="name"placeholder="name@example.com">
                                                        <label for="recipient-name">Full name</label>                        
                                                    </div>  
                                                    <div class="form-floating mb-3">
                                                        <input type="tel" class="form-control" id="recipient-name" value="${staff.phone}" name="phone" placeholder="name@example.com">
                                                        <label for="recipient-name">Phone</label>                        
                                                    </div>
                                                    <div class="form-floating mb-3">
                                                        <input type="text" class="form-control" id="recipient-name"  value="${staff.address}" name="address" placeholder="name@example.com">
                                                        <label for="recipient-name">Address</label>                        
                                                    </div>
                                                    <div class="form-floating mb-3">
                                                        <select class="form-select" id="floatingSelect" name="gender" aria-label="Floating label select example">
                                                            <option value="Nam" ${staff.gender == 'Nam' ? "selected" : ""}>Nam</option>
                                                            <option value="Nữ" ${staff.gender == 'Nữ' ? "selected" : ""}>Nữ</option>
                                                        </select>
                                                        <label for="floatingSelect">Gender</label>                      
                                                    </div>
                                                    <div class="form-floating mb-3">
                                                        <input type="date" class="form-control" id="recipient-name" value="${staff.birthdate}" name="birthdate" placeholder="name@example.com">
                                                        <label for="recipient-name">Birthday</label>                        
                                                    </div>
                                                    </form>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                    <input type="submit" value="Lưu"class="btn btn-primary">
                                                </div>
                                            </div>
                                        </div>

                                    </form>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <script>
            function validatePassword() {
                let isValid = true;
                let oldPassword = document.getElementById("oldPassword").value.trim();
                let newPassword = document.getElementById("newPassword").value.trim();
                let confirmPassword = document.getElementById("confirmPassword").value.trim();


                document.getElementById("oldPasswordError").innerHTML = "";
                document.getElementById("newPasswordError").innerHTML = "";
                document.getElementById("confirmPasswordError").innerHTML = "";


                if (oldPassword === "") {
                    document.getElementById("oldPasswordError").innerHTML = "Vui lòng nhập mật khẩu cũ!";
                    isValid = false;
                }


                if (newPassword.length < 6) {
                    document.getElementById("newPasswordError").innerHTML = "Mật khẩu mới phải có ít nhất 6 ký tự!";
                    isValid = false;
                }


                if (newPassword !== confirmPassword) {
                    document.getElementById("confirmPasswordError").innerHTML = "Mật khẩu xác nhận không khớp!";
                    isValid = false;
                }

                return isValid;
            }
        </script>
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
