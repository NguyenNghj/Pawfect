<%-- 
    Document   : order
    Created on : Feb 11, 2025, 4:53:57 PM
    Author     : Vu Quang Duc - CE181221
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;600;800&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="../../css/dashboard.css">
        <title>Quản lý đơn hàng</title>
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
                    request.setAttribute("staffRole", staffRole);
                    request.setAttribute("staffName", staffName);
                %> 
                <!-- MAIN -->
                <div class="col" id="main" style="padding: 0 40px;">
                    <div class="row pt-4">
                        <div class="d-flex align-items-center justify-content-between" style="padding: 0;">
                            <div>
                                <h1>Quản lý đơn hàng</h1>
                            </div>
                            <c:choose>
                                <c:when test="${staffRole eq 'Admin'}">
                                    <div class="dropdown d-flex align-items-center gap-2">
                                        <span style="color: #D3A376; font-weight: bold;"><%= staffName%></span>
                                        <button class="btn dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                                            <img class="profile-img" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTf74k9hxcTCkLN2gyhCr9lzuzZax5iy0uDOA&s" alt="">
                                        </button>
                                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                            <li>
                                                <a class="dropdown-item d-flex align-items-center gap-2" href="/dashboard/admin/statistics">
                                                    <i class="fa-solid fa-repeat"></i> Chuyển qua giao diện quản lí
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="dropdown d-flex align-items-center gap-2">
                                        <span style = "color: #D3A376; font-weight: bold;"><%= staffName%></span>
                                        <a href="staffprofile">
                                            <button class="btn" type="button">
                                                <img class="profile-img" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTf74k9hxcTCkLN2gyhCr9lzuzZax5iy0uDOA&s" alt="">
                                            </button>
                                        </a>
                                    </div>
                                </c:otherwise>
                            </c:choose>  
                        </div>
                    </div>
                    <div class="row mt-2 bg-white p-3 d-flex align-items-center justify-content-center" 
                         style="border-radius: 20px; height: 60px;">
                        <nav style="--bs-breadcrumb-divider: '>'; padding: 0 5px;" aria-label="breadcrumb">
                            <ol class="breadcrumb mb-0" style ="font-weight: bold;">
                                <li class="breadcrumb-item">Bảng điều khiển</li>
                                <li class="breadcrumb-item">Nhân viên</li>                            
                                <li class="breadcrumb-item active" aria-current="page">Quản lý đơn hàng</li>
                            </ol>
                        </nav>
                    </div>        

                    <div class="row d-flex align-items-center" style="margin-top: 30px;">
                        <div class="col-md-6 text-start">
                            <form action="ordermanagement" method="get" class="d-flex mb-3 align-items-center" 
                                  style="max-width: 400px; border-radius: 25px; background: #f8f9fa; padding: 5px;">

                                <input type="search" name="search" class="form-control" id="inputName" placeholder="Nhập từ khóa..."

                                       style="flex: 1; border: none; outline: none; padding: 8px 12px; border-radius: 20px; font-size: 14px;">
                                <input type="hidden" name="action" value="search">
                                <input type="hidden" name="status" value="${param.status}">
                                <button type="submit" class="btn btn-primary" 
                                        style="border-radius: 20px; padding: 6px 15px; font-size: 14px; font-weight: bold; background-color: #007bff; border: none; transition: 0.3s;">
                                    Tìm Kiếm
                                </button>
                            </form>
                        </div>
                    </div>


                    <div class="row" style="margin-top: 20px; margin-bottom: 50px;">
                        <div class="main-dashboard-table">
                            <div class="d-flex justify-content-center align-items-center gap-3 main-dashboard-table-header"
                                 style="background-color: #8C6E63; color: white; border-top-left-radius: 6px; border-top-right-radius: 6px;">                                               
                                <i class="fa-solid fa-truck-ramp-box fa-lg"></i>
                                <h4 class="mb-0">Danh sách đơn hàng</h4>
                            </div>
                            <div style="padding: 15px 15px 25px 15px;">
                                <!-- Order Tabs -->
                                <ul class="nav nav-tabs">
                                    <li class="nav-item">
                                        <a class="nav-link <c:if test="${orderStatus == 'tc'}">active</c:if>" href="ordermanagement?&action=view&status=tc" style="font-weight: bold; border-width: 2px;">Tất cả</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link <c:if test="${orderStatus == 'cxn'}">active</c:if>" href="ordermanagement?&action=view&status=cxn" style="font-weight: bold; border-width: 2px;">Chờ xác nhận</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link <c:if test="${orderStatus == 'clh'}">active</c:if>" href="ordermanagement?&action=view&status=clh" style="font-weight: bold; border-width: 2px;">Chờ lấy hàng</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link <c:if test="${orderStatus == 'cgh'}">active</c:if>" href="ordermanagement?&action=view&status=cgh" style="font-weight: bold; border-width: 2px;">Chờ giao hàng</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link <c:if test="${orderStatus == 'ht'}">active</c:if>" href="ordermanagement?&action=view&status=ht" style="font-weight: bold; border-width: 2px;">Hoàn thành</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link <c:if test="${orderStatus == 'ych'}">active</c:if>" href="ordermanagement?&action=view&status=ych" style="font-weight: bold; border-width: 2px;">Yêu cầu huỷ</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link <c:if test="${orderStatus == 'dh'}">active</c:if>" href="ordermanagement?&action=view&status=dh" style="font-weight: bold; border-width: 2px;">Đã huỷ</a>
                                        </li>
                                    </ul>
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th scope="col" style="width: 9%;">Mã đơn</th>
                                                <th scope="col" style="width: 18%;">Họ tên</th>
                                                <th scope="col">Địa chỉ giao hàng</th>
                                                <th scope="col" style="width: 10%;">Tổng tiền</th>
                                                <th scope="col" style="width: 11%;">Trạng thái</th>
                                                <th scope="col" style="width: 19%;">Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:set var="itemsPerPage" value="10" />
                                        <c:set var="totalOrders" value="${fn:length(orders)}" />
                                        <c:set var="totalPages" value="${(totalOrders + itemsPerPage - 1) / itemsPerPage}"/>

                                        <!-- Ensure currentPage is set correctly -->
                                        <c:set var="currentPage">
                                            <c:choose>
                                                <c:when test="${not empty param.page}">
                                                    ${param.page}
                                                </c:when>
                                                <c:otherwise>1</c:otherwise>
                                            </c:choose>
                                        </c:set>

                                        <c:set var="start" value="${(currentPage - 1) * itemsPerPage}" />
                                        <c:set var="end" value="${start + itemsPerPage}" />

                                        <c:forEach var="o" items="${orders}" varStatus="loop">
                                            <c:if test="${loop.index >= start and loop.index < end}">
                                                <tr>
                                                    <!-- Mã đơn hàng -->
                                                    <th class="align-middle" scope="row">
                                                        <a style="text-decoration: none; color : #D3A376;" href="ordermanagement?&action=viewdetail&orderId=${o.orderId}">#${o.orderId + 2500000}</a>
                                                    </th>
                                                    <!-- Họ tên đặt -->
                                                    <td class="bodycolor-name-address-total align-middle">${o.customerName}</td>
                                                    <!-- Địa chỉ giao hàng -->
                                                    <td class="bodycolor-name-address-total align-middle">${o.address}</td>
                                                    <!-- Tổng tiền đơn hàng -->
                                                    <td class="bodycolor-name-address-total align-middle">
                                                        <c:choose>
                                                            <c:when test="${o.discountAmount != 0}">
                                                                <c:choose>
                                                                    <c:when test="${o.totalAmount - o.discountAmount < 0}">
                                                                        <f:formatNumber value="0" pattern="#,##0" />đ
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <f:formatNumber value="${o.totalAmount}" pattern="#,##0" />đ
                                                                    </c:otherwise>
                                                                </c:choose>

                                                            </c:when>
                                                            <c:otherwise>
                                                                <f:formatNumber value="${o.totalAmount}" pattern="#,##0" />đ
                                                            </c:otherwise>
                                                        </c:choose>

                                                    </td>                                              
                                                    <!-- Trạng thái đơn hàng -->
                                                    <td class="align-middle">
                                                        <c:choose>
                                                            <c:when test="${o.status == 'Chờ xác nhận'}"><span class="text-warning fw-bold">${o.status}</span></c:when>
                                                            <c:when test="${o.status == 'Chờ lấy hàng'}"><span class="text-secondary fw-bold">${o.status}</span></c:when>
                                                            <c:when test="${o.status == 'Chờ giao hàng'}"><span class="text-primary fw-bold">${o.status}</span></c:when>
                                                            <c:when test="${o.status == 'Hoàn thành'}"><span class="text-success fw-bold">${o.status}</span></c:when>
                                                            <c:when test="${o.status == 'Yêu cầu huỷ...'}"><span class="text-danger fw-bold">${o.status}</span></c:when>
                                                            <c:otherwise><span class="text-danger fw-bold">${o.status}</span></c:otherwise> 
                                                        </c:choose>
                                                    </td>
                                                    <td>       
                                                        <c:if test="${o.status == 'Yêu cầu huỷ...'}">
                                                            <button type="button" class="btn btn-primary btn-cancel"       
                                                                    data-bs-toggle="modal" data-bs-target="#cancel2Modal"
                                                                    data-order-id="${o.orderId}"
                                                                    data-update-status="Đã huỷ"
                                                                    data-reason-cancel="${o.reasonCancel}"
                                                                    onclick="approve(event)"
                                                                    >
                                                                Chấp nhận
                                                            </button>
                                                            <button type="button" class="btn btn-secondary btn-cancel"       
                                                                    data-bs-toggle="modal" data-bs-target="#refuseModal"
                                                                    data-order-id="${o.orderId}"
                                                                    data-update-status="Chờ lấy hàng"
                                                                    data-reason-cancel="${o.reasonCancel}"
                                                                    onclick="approve(event)"
                                                                    >
                                                                Từ chối
                                                            </button>                                                       
                                                        </c:if>                                
                                                        <c:if test="${o.status == 'Chờ xác nhận'}">
                                                            <button type="button" class="btn btn-primary btn-cancel"       
                                                                    data-bs-toggle="modal" data-bs-target="#acceptModal"
                                                                    data-order-id="${o.orderId}"
                                                                    data-update-status="Chờ lấy hàng"
                                                                    onclick="approve(event)"
                                                                    >
                                                                Xác nhận
                                                            </button>
                                                        </c:if>
                                                        <c:if test="${o.status == 'Chờ lấy hàng'}">
                                                            <button type="button" class="btn btn-primary btn-cancel"       
                                                                    data-bs-toggle="modal" data-bs-target="#deliveryModal"
                                                                    data-order-id="${o.orderId}"
                                                                    data-update-status="Chờ giao hàng"
                                                                    onclick="approve(event)"
                                                                    >
                                                                Giao hàng
                                                            </button>
                                                        </c:if>
                                                        <c:if test="${o.status == 'Chờ giao hàng'}">
                                                            <button type="button" class="btn btn-success btn-cancel"       
                                                                    data-bs-toggle="modal" data-bs-target="#completeModal"
                                                                    data-order-id="${o.orderId}"
                                                                    data-update-status="Hoàn thành"
                                                                    onclick="approve(event)"
                                                                    >
                                                                Hoàn thành
                                                            </button>
                                                        </c:if>
                                                        <!-- Được huỷ đơn nếu đơn hàng ở trạng thái "Chờ xác nhận" hoặc "Chờ lấy hàng" -->
                                                        <c:if test="${o.status == 'Chờ xác nhận' || o.status == 'Chờ lấy hàng' || o.status == 'Chờ giao hàng'}">                                                      
                                                            <button type="button" class="btn btn-danger btn-cancel"       
                                                                    data-bs-toggle="modal" data-bs-target="#cancelModal"
                                                                    data-order-id="${o.orderId}"
                                                                    data-update-status="Đã huỷ"
                                                                    onclick="approve(event)"
                                                                    >
                                                                Huỷ đơn
                                                            </button>
                                                        </c:if>
                                                    </td>
                                                </tr>
                                            </c:if>
                                        </c:forEach>
                                    </tbody>
                                </table>

                                <!-- Modal Cancel 2 -->
                                <div class="modal fade" id="cancel2Modal" tabindex="-1" aria-labelledby="cancel2ModalLabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h1 class="modal-title fs-5" id="cancel2ModalLabel">Chấp nhận huỷ đơn hàng theo yêu cầu</h1>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <form id="cancelForm" action="ordermanagement?action=cancel" method="post">
                                                <div class="modal-body">                           
                                                    <div class="mb-3">
                                                        <div class="mb-2" style="text-align: justify;">
                                                            <span id="cancelMessage"><span style="font-weight: bold;">Lưu ý: </span>Nếu bạn xác nhận hủy, toàn bộ đơn hàng sẽ bị hủy. Trường hợp khách hàng đã thanh toán, tiền sẽ được hoàn về tài khoản trong vòng 24 giờ và lâu hơn đối với các phương thức thanh toán khác.</span>
                                                        </div>
                                                        <label for="message-text" class="col-form-label"><span style="color: red; font-weight: bold;">Lý Do Huỷ</span></label>
                                                        <textarea id="reason" name="reasonCancel" style="height: 80px;" class="form-control modalReasonCancel" id="message-text" readonly ></textarea>
                                                    </div>

                                                    <input type="hidden" name="orderId" class="modalOrderId">
                                                    <input type="hidden" name="updateStatus" class="modalUpdateStatus">
                                                    <input type="hidden" name="actionBack" value="view">
                                                    <input type="hidden" name="statusType" value="${param.status}">
                                                    <input type="hidden" name="reasonCancel"> 

                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                    <button type="submit" class="btn btn-primary" id="confirmCancelBtn">Huỷ đơn</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>

                                <!-- Modal Refuse Order -->
                                <div class="modal fade" id="refuseModal" tabindex="-1" aria-labelledby="refuseModalLabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h1 class="modal-title fs-5" id="refuseModalLabel">Từ chối đơn hàng?</h1>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <form id="refuseForm" action="ordermanagement?action=approval" method="post">
                                                <div class="modal-body">                           
                                                    <div class="mb-3">
                                                        <div class="mb-2" style="text-align: justify;">
                                                            <span id="cancelMessage"><span style="font-weight: bold;">Lưu ý: </span>Khi bạn đồng ý từ chối, đơn hàng sẽ được quay về trạng thái chờ lấy hàng. Vui lòng kiểm tra thông tin đơn hàng và xem xét lý do hợp lý trước khi thực hiện.</span>
                                                            <div class="mt-2">
                                                                <label for="message-text" class="col-form-label"><span style="color: red; font-weight: bold;">Lý Do Huỷ</span></label>
                                                                <textarea id="reason" style="height: 80px;" class="form-control modalReasonCancel" id="message-text" readonly></textarea>
                                                            </div>
                                                        </div>                                                                   
                                                    </div>

                                                    <input type="hidden" name="orderId" class="modalOrderId">
                                                    <input type="hidden" name="updateStatus" class="modalUpdateStatus">
                                                    <input type="hidden" name="actionBack" value="view">
                                                    <input type="hidden" name="statusType" value="${param.status}">
                                                    <input type="hidden" name="reasonCancel" value="refuse"> 

                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                    <button type="submit" class="btn btn-primary" id="confirmCancelBtn">Từ chối</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>

                                <!-- Modal Complete Order -->
                                <div class="modal fade" id="completeModal" tabindex="-1" aria-labelledby="completeModalLabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h1 class="modal-title fs-5" id="completeModalLabel">Hoàn thành đơn hàng?</h1>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <form id="completeForm" action="ordermanagement?action=approval" method="post">
                                                <div class="modal-body">                           
                                                    <div class="mb-3">
                                                        <div class="mb-2" style="text-align: justify;">
                                                            <span id="cancelMessage"><span style="font-weight: bold;">Lưu ý: </span>Khi bạn xác nhận, đơn hàng sẽ được đánh dấu là hoàn thành. Vui lòng đảm bảo rằng hàng hóa đã được giao đầy đủ và đúng thông tin trước khi xác nhận.</span>
                                                        </div>                                                                   
                                                    </div>

                                                    <input type="hidden" name="orderId" class="modalOrderId">
                                                    <input type="hidden" name="updateStatus" class="modalUpdateStatus">
                                                    <input type="hidden" name="actionBack" value="view">
                                                    <input type="hidden" name="statusType" value="${param.status}">
                                                    <input type="hidden" name="reasonCancel"> 

                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                    <button type="submit" class="btn btn-success" id="confirmCancelBtn">Hoàn thành</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>

                                <!-- Modal Delivery Order -->
                                <div class="modal fade" id="deliveryModal" tabindex="-1" aria-labelledby="deliveryModalLabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h1 class="modal-title fs-5" id="deliveryModalLabel">Xác nhận giao hàng</h1>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <form id="deliveryForm" action="ordermanagement?action=approval" method="post">
                                                <div class="modal-body">                           
                                                    <div class="mb-3">
                                                        <div class="mb-2" style="text-align: justify;">
                                                            <span id="cancelMessage"><span style="font-weight: bold;">Lưu ý: </span>Khi bạn xác nhận, đơn hàng của khách sẽ được giao lại cho bên vận chuyển. Vui lòng kiểm tra thông tin đơn hàng trước khi thực hiện.</span>
                                                        </div>                                                                   
                                                    </div>

                                                    <input type="hidden" name="orderId" class="modalOrderId">
                                                    <input type="hidden" name="updateStatus" class="modalUpdateStatus">
                                                    <input type="hidden" name="actionBack" value="view">
                                                    <input type="hidden" name="statusType" value="${param.status}">
                                                    <input type="hidden" name="reasonCancel"> 

                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                    <button type="submit" class="btn btn-primary" id="confirmCancelBtn">Giao hàng</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>

                                <!-- Modal Accept Order -->
                                <div class="modal fade" id="acceptModal" tabindex="-1" aria-labelledby="acceptModalLabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h1 class="modal-title fs-5" id="acceptModalLabel">Xác nhận đơn hàng</h1>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <form id="acceptForm" action="ordermanagement?&action=approval" method="post">
                                                <div class="modal-body">                           
                                                    <div class="mb-3">
                                                        <div class="mb-2" style="text-align: justify;">
                                                            <span id="cancelMessage"><span style="font-weight: bold;">Lưu ý: </span>Khi bạn xác nhận, đơn hàng của khách sẽ được phê duyệt và chuyển sang trạng thái đang lấy hàng. Vui lòng kiểm tra thông tin đơn hàng trước khi xác nhận.</span>
                                                        </div>                                                                   
                                                    </div>

                                                    <input type="hidden" name="orderId" class="modalOrderId">
                                                    <input type="hidden" name="updateStatus" class="modalUpdateStatus">
                                                    <input type="hidden" name="actionBack" value="view">
                                                    <input type="hidden" name="statusType" value="${param.status}">
                                                    <input type="hidden" name="reasonCancel"> 

                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                    <button type="submit" class="btn btn-primary" id="confirmCancelBtn">Xác nhận</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>                              

                                <!-- Modal Cancel -->
                                <div class="modal fade" id="cancelModal" tabindex="-1" aria-labelledby="cancelModalLabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h1 class="modal-title fs-5" id="cancelModalLabel">Xác Nhận Huỷ Đơn Hàng</h1>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <form id="cancelForm" action="ordermanagement?action=cancel" method="post">
                                                <div class="modal-body">                           
                                                    <div class="mb-3">
                                                        <div class="mb-2" style="text-align: justify;">
                                                            <span id="cancelMessage"><span style="font-weight: bold;">Lưu ý: </span>Nếu bạn xác nhận hủy, toàn bộ đơn hàng sẽ bị hủy. Trường hợp khách hàng đã thanh toán, tiền sẽ được hoàn về tài khoản trong vòng 24 giờ và lâu hơn đối với các phương thức thanh toán khác.</span>
                                                        </div>
                                                        <label for="message-text" class="col-form-label"><span style="color: red; font-weight: bold;">Lý Do Huỷ</span></label>
                                                        <textarea id="reason" name="reasonCancel" style="height: 80px;" class="form-control" id="message-text" maxlength="255" required oninvalid="this.setCustomValidity('Vui lòng nhập lý do huỷ!')" oninput="this.setCustomValidity('')"></textarea>
                                                    </div>

                                                    <input type="hidden" name="orderId" class="modalOrderId">
                                                    <input type="hidden" name="updateStatus" class="modalUpdateStatus">
                                                    <input type="hidden" name="actionBack" value="view">
                                                    <input type="hidden" name="statusType" value="${param.status}">
                                                    <input type="hidden" name="reasonCancel"> 

                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                    <button type="submit" class="btn btn-primary" id="confirmCancelBtn">Huỷ đơn</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>

                                <!-- Nếu 'không' có đơn hàng nào! -->
                                <c:if test="${empty orders}">                     
                                    <div>
                                        <h5 style="color: #856404; text-align: center; background-color: #fff3cd; padding: 12px; border-radius: 5px; margin-top: 10px;">
                                            Không tìm thấy!
                                        </h5>
                                    </div>
                                </c:if>

                            </div>
                        </div>
                        <c:if test="${totalPages >= 1}">
                            <nav aria-label="Page navigation">
                                <ul class="pagination">
                                    <!-- Nút Previous -->
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="javascript:updatePage(${currentPage - 1})">Previous</a>
                                    </li>

                                    <!-- Hiển thị số trang -->
                                    <c:forEach var="i" begin="1" end="${totalPages}">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="javascript:updatePage(${i})">${i}</a>
                                        </li>
                                    </c:forEach>

                                    <!-- Nút Next -->
                                    <li class="page-item ${currentPage >= Math.floor(totalPages) ? 'disabled' : ''}">
                                        <a class="page-link" href="javascript:updatePage(${currentPage + 1})">Next</a>
                                    </li>
                                </ul>
                            </nav>
                        </c:if>
                        <script>
                            function updatePage(page) {
                                let urlParams = new URLSearchParams(window.location.search);
                                urlParams.set('page', page); // Cập nhật số trang
                                window.location.search = urlParams.toString();
                            }
                        </script>
                    </div>          
                </div>
            </div>
        </div>
    </div>

    <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>

                            function approve(event) {
                                let button = event.currentTarget; // Lấy nút được nhấn
                                let orderId = button.getAttribute("data-order-id");
                                let updateStatus = button.getAttribute("data-update-status");
                                let openModal = button.getAttribute("data-bs-target");
                                let reasonCancel = button.getAttribute("data-reason-cancel");

                                console.log("Gia tri order: ", orderId);
                                console.log("Gia tri updateStatus: ", updateStatus);
                                console.log("Gia tri reasonCancel: ", reasonCancel);

                                // Tìm modal gần nhất với nút được nhấn
                                let modal = document.querySelector(openModal);

                                if (modal) {
                                    modal.querySelector(".modalOrderId").value = orderId;
                                    modal.querySelector(".modalUpdateStatus").value = updateStatus;
                                    modal.querySelector(".modalReasonCancel").textContent = reasonCancel;
                                }

                                let orderIdServlet = modal.querySelector(".modalOrderId").value;

                                console.log("Gia tri orderId: ", orderIdServlet);

                            }

                            document.getElementById("refuseForm").addEventListener("submit", function (event) {
                                event.preventDefault(); // Ngăn form gửi đi ngay lập tức

                                Swal.fire({
                                    icon: "info",
                                    title: "Đang xử lý...",
                                    text: "Vui lòng chờ trong giây lát.",
                                    timer: 1400,
                                    timerProgressBar: true,
                                    allowOutsideClick: false,
                                    showConfirmButton: false // Ẩn nút OK
                                }).then(() => {

                                    Swal.fire({
                                        icon: "success",
                                        title: "Từ chối yêu cầu huỷ đơn hàng thành công!",
                                        text: "Bạn đã từ chối yêu cầu hủy đơn hàng. Vui lòng tiếp tục xử lý đơn hàng theo quy trình. Nếu cần, hãy liên hệ khách hàng để giải thích lý do."
                                    }).then(() => {
                                        document.getElementById("refuseForm").submit(); // Gửi form sau khi hiển thị thông báo thành công
                                    });

                                });

                            });


                            document.getElementById("cancelForm").addEventListener("submit", function (event) {
                                event.preventDefault(); // Ngăn form gửi đi ngay lập tức

                                var reason = document.getElementById("reason").value;

                                if (reason === "") {
                                    Swal.fire({
                                        icon: "warning",
                                        title: "Lỗi!",
                                        text: "Vui lòng chọn lý do huỷ đơn hàng.",
                                    });
                                } else {
                                    Swal.fire({
                                        icon: "info",
                                        title: "Đang xử lý...",
                                        text: "Vui lòng chờ trong giây lát.",
                                        timer: 1400,
                                        timerProgressBar: true,
                                        allowOutsideClick: false,
                                        showConfirmButton: false // Ẩn nút OK
                                    }).then(() => {

                                        Swal.fire({
                                            icon: "success",
                                            title: "Huỷ đơn thành công!",
                                            text: "Chúng tôi sẽ xử lý đơn huỷ và hoàn tiền nếu bạn đã thanh toán."
                                        }).then(() => {
                                            document.getElementById("cancelForm").submit(); // Gửi form sau khi hiển thị thông báo thành công
                                        });

                                    });
                                }
                            });


                            document.getElementById("completeForm").addEventListener("submit", function (event) {
                                event.preventDefault(); // Ngăn form gửi đi ngay lập tức

                                Swal.fire({
                                    icon: "info",
                                    title: "Đang xử lý...",
                                    text: "Vui lòng chờ trong giây lát.",
                                    timer: 1300,
                                    timerProgressBar: true,
                                    allowOutsideClick: false,
                                    showConfirmButton: false // Ẩn nút OK
                                }).then(() => {
                                    Swal.fire({
                                        icon: "success",
                                        title: "Xác nhận hoàn tất đơn hàng thành công!",
                                        text: "Đơn hàng của khách sẽ được đánh dấu là hoàn thành.",
                                    }).then(() => {
                                        document.getElementById("completeForm").submit(); // Gửi form sau khi hiển thị thông báo thành công
                                    });

                                });

                            });


                            document.getElementById("deliveryForm").addEventListener("submit", function (event) {
                                event.preventDefault(); // Ngăn form gửi đi ngay lập tức

                                Swal.fire({
                                    icon: "info",
                                    title: "Đang xử lý...",
                                    text: "Vui lòng chờ trong giây lát.",
                                    timer: 1300,
                                    timerProgressBar: true,
                                    allowOutsideClick: false,
                                    showConfirmButton: false // Ẩn nút OK
                                }).then(() => {
                                    Swal.fire({
                                        icon: "success",
                                        title: "Xác nhận giao hàng thành công!",
                                        text: "Đơn hàng của khách sẽ được phê duyệt và chuyển sang trạng thái chờ giao hàng.",
                                    }).then(() => {
                                        document.getElementById("deliveryForm").submit(); // Gửi form sau khi hiển thị thông báo thành công
                                    });

                                });

                            });


                            document.getElementById("acceptForm").addEventListener("submit", function (event) {
                                event.preventDefault(); // Ngăn form gửi đi ngay lập tức

                                Swal.fire({
                                    icon: "info",
                                    title: "Đang xử lý...",
                                    text: "Vui lòng chờ trong giây lát.",
                                    timer: 1300,
                                    timerProgressBar: true,
                                    allowOutsideClick: false,
                                    showConfirmButton: false // Ẩn nút OK
                                }).then(() => {
                                    Swal.fire({
                                        icon: "success",
                                        title: "Xác nhận đơn hàng thành công!",
                                        text: "Đơn hàng của khách sẽ được phê duyệt và chuyển sang trạng thái chờ lấy hàng.",
                                    }).then(() => {
                                        document.getElementById("acceptForm").submit(); // Gửi form sau khi hiển thị thông báo thành công
                                    });

                                });

                            });

    </script>
</body>
</html>
