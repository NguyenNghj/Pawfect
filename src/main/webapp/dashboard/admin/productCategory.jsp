<%-- 
    Document   : productCategory
    Created on : Feb 11, 2025, 3:54:22 PM
    Author     : Vu Quang Duc - CE181221
--%>

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
                                                <a class="navbar-brand" href="accountStaff.jsp">Employee</a>
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
                        <nav class="navbar bg-body-tertiary active">                   
                            <a class="navbar-brand d-flex align-items-center gap-3" style="color: white; pointer-events: none;" href="#">
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
                        <nav class="navbar bg-body-tertiary">                                   
                            <a class="navbar-brand d-flex align-items-center gap-3" href="profile.jsp">
                                <i class="fa-solid fa-address-book fa-lg"></i>   
                                <span>Profile</span>
                            </a>                          
                        </nav>
                        <nav class="navbar bg-body-tertiary">                                              
                            <a class="navbar-brand d-flex align-items-center gap-3" href="#">
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
                                <h1>Product Category Management</h1>
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
                                <li class="breadcrumb-item active" aria-current="page">Product Category</li>
                            </ol>
                        </nav>
                    </div>   

                    <div class="row">
                        <div class="col-3 p-0" style="margin-top: 60px;">
                            <button type="button" class="btn btn-primary">
                                <i class="fa-solid fa-plus"></i>
                                New Product Category
                            </button>
                        </div>        
                    </div>


                    <div class="row" style="margin-top: 20px; margin-bottom: 50px;">
                        <div class="main-dashboard-table">
                            <div class="d-flex justify-content-center align-items-center gap-3 main-dashboard-table-header"
                                 style="background-color: #007BFF; color: white; border-top-left-radius: 6px; border-top-right-radius: 6px;">                                                 
                                <i class="fa-solid fa-boxes-stacked fa-lg"></i>
                                <h4 class="mb-0">Product Category List</h4>
                            </div>
                            <div style="padding: 15px 15px 25px 15px;">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">#</th>
                                            <th scope="col">First</th>
                                            <th scope="col">Last</th>
                                            <th scope="col">Handle</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th scope="row">1</th>
                                            <td>Mark</td>
                                            <td>Otto</td>
                                            <td>@mdo</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">2</th>
                                            <td>Jacob</td>
                                            <td>Thornton</td>
                                            <td>@fat</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">3</th>
                                            <td colspan="2">Larry the Bird</td>
                                            <td>@twitter</td>
                                        </tr>                             
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
