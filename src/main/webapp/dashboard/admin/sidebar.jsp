<%-- 
    Document   : slidebar
    Created on : Mar 1, 2025, 4:23:53 PM
    Author     : Nguyen Tri Nghi - CE180897
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            <a class="navbar-brand d-flex align-items-center gap-3" href="dashboard">
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
                                <a class="navbar-brand" href="accountAdmin">Admin</a>
                            </div>
                        </nav>
                        <nav class="navbar bg-body-tertiary" style="padding-bottom: 0;">
                            <div class="container-fluid">
                                <a class="navbar-brand" href="accountStaff">Employee</a>
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
        <nav class="navbar bg-body-tertiary active">                                           
            <a class="navbar-brand d-flex align-items-center gap-3" style="color: white; pointer-events: none;" href="#">
                <i class="fa-solid fa-box fa-lg"></i>
                <span>Product</span>
            </a>                          
        </nav>
        <nav class="navbar bg-body-tertiary">                   
            <a class="navbar-brand d-flex align-items-center gap-3" href="category">
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
    </div>

    <div class="row">
        <hr style="margin: 10px 0;">
    </div>

    <div class="row">
        <nav class="navbar bg-body-tertiary">                                   
            <a class="navbar-brand d-flex align-items-center gap-3" href="profile">
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
