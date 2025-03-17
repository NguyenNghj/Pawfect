<%-- 
    Document   : orderDetail
    Created on : Feb 15, 2025, 9:28:21 PM
    Author     : Vu Quang Duc - CE181221
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;600;800&display=swap" rel="stylesheet">
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
                                <h1>Chi tiết đơn hàng</h1>
                            </div>
                            <div class="dropdown d-flex align-items-center gap-2">
                                <span style = "color: #D3A376; font-weight: bold;"><%= staffName%></span>
                                <a href="staffprofile">
                                    <button class="btn" type="button">
                                        <img class="profile-img" src="${staff.image}" alt="">
                                    </button>
                                </a>
                            </div>                                                            
                        </div>
                    </div>

                    <div class="row mt-2 bg-white p-3 d-flex align-items-center justify-content-center" 
                         style="border-radius: 20px; height: 60px;">
                        <nav style="--bs-breadcrumb-divider: '>'; padding: 0 5px;" aria-label="breadcrumb">
                            <ol class="breadcrumb mb-0" style ="font-weight: bold;">
                                <li class="breadcrumb-item">Dashboard</li>
                                <li class="breadcrumb-item"><a href="ordermanagement?&action=view&status=tc">Quản lí đơn hàng</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Chi tiết đơn hàng</li>
                            </ol>
                        </nav>
                    </div>  

                    <div class="row" style="margin-top: 30px; margin-bottom: 50px;">
                        <div class="main-dashboard-table">

                            <!-- Chi tiết đơn hàng -->
                            <div class="card">
                                <c:forEach items="${orders}" var="o">
                                    <div class="card-body">
                                        <header class="d-flex align-items-center mb-2">
                                            <a href="ordermanagement?&action=view&status=tc" class="text-secondary me-3">
                                                <i class="bi bi-arrow-left"></i>
                                            </a>
                                            <h1 class="h4 mb-0">Đơn hàng của ${o.customerName}</h1>
                                        </header>

                                        <!-- Đơn hàng có trạng thái "Chờ xác nhận" thì mới được huỷ đơn -->
                                        <div class="text-secondary">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <span style="margin-left: 33px" >Đơn hàng: #${o.orderId + 2500000}</span>
                                                <div class="d-flex gap-2">
                                                    <c:if test="${o.status == 'Yêu cầu huỷ...'}">
                                                        <button type="button" class="btn btn-primary btn-cancel"       
                                                                data-bs-toggle="modal" data-bs-target="#cancel2Modal"
                                                                >
                                                            Chấp nhận
                                                        </button>
                                                        <button type="button" class="btn btn-secondary btn-cancel"       
                                                                data-bs-toggle="modal" data-bs-target="#refuseModal"
                                                                >
                                                            Từ chối
                                                        </button>                                                       
                                                    </c:if>  
                                                    <c:if test="${o.status == 'Chờ xác nhận'}">                                                      
                                                        <button class="btn btn-primary btn-sm btn-cancel"
                                                                data-bs-toggle="modal" data-bs-target="#acceptModal"       
                                                                style="padding: 8px 18px;"
                                                                >
                                                            <span style="font-size: 16px;">Xác nhận</span>
                                                        </button>
                                                    </c:if>
                                                    <c:if test="${o.status == 'Chờ lấy hàng'}">                                                      
                                                        <button class="btn btn-primary btn-sm btn-cancel"
                                                                data-bs-toggle="modal" data-bs-target="#deliveryModal"
                                                                style="padding: 8px 18px;"
                                                                >
                                                            <span style="font-size: 16px;">Giao hàng</span>
                                                        </button>
                                                    </c:if>
                                                    <c:if test="${o.status == 'Chờ giao hàng'}">                                                      
                                                        <button class="btn btn-success btn-sm btn-cancel"
                                                                data-bs-toggle="modal" data-bs-target="#completeModal"
                                                                style="padding: 8px 18px;"
                                                                >
                                                            <span style="font-size: 16px;">Hoàn thành</span>
                                                        </button>
                                                    </c:if>
                                                    <c:if test="${o.status == 'Chờ xác nhận' || o.status == 'Chờ lấy hàng'}">                                                      
                                                        <button class="btn btn-danger btn-sm btn-cancel"
                                                                data-bs-toggle="modal" data-bs-target="#cancelModal"
                                                                style="padding: 8px 18px;"
                                                                >
                                                            <span id="cancelType" style="font-size: 16px;">Huỷ đơn</span>
                                                        </button>
                                                    </c:if>
                                                </div> 
                                            </div>

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
                                                                    <textarea id="reason" name="reasonCancel" style="height: 80px;" class="form-control modalReasonCancel" id="message-text" readonly >${o.reasonCancel}</textarea>
                                                                </div>

                                                                <input type="hidden" name="orderId" value="${o.orderId}">
                                                                <input type="hidden" name="updateStatus" value="Đã huỷ">
                                                                <input type="hidden" name="actionBack" value="viewdetail">
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
                                                                            <textarea id="reason" style="height: 80px;" class="form-control modalReasonCancel" id="message-text" readonly>${o.reasonCancel}</textarea>
                                                                        </div>
                                                                    </div>                                                                   
                                                                </div>

                                                                <input type="hidden" name="orderId" value="${o.orderId}">
                                                                <input type="hidden" name="updateStatus" value="Chờ lấy hàng">
                                                                <input type="hidden" name="actionBack" value="viewdetail">
                                                                <input type="hidden" name="statusType" value="${param.status}">
                                                                <!-- <input type="hidden" name="reasonCancel" value="refuse"> -->

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

                                                                <input type="hidden" name="orderId" value="${o.orderId}">
                                                                <input type="hidden" name="updateStatus" value="Hoàn thành">
                                                                <input type="hidden" name="actionBack" value="viewdetail">
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

                                                                <input type="hidden" name="orderId" value="${o.orderId}">
                                                                <input type="hidden" name="updateStatus" value="Chờ giao hàng">
                                                                <input type="hidden" name="actionBack" value="viewdetail">
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
                                                        <form id="acceptForm" action="ordermanagement?action=approval" method="post">
                                                            <div class="modal-body">                           
                                                                <div class="mb-3">
                                                                    <div class="mb-2" style="text-align: justify;">
                                                                        <span id="cancelMessage"><span style="font-weight: bold;">Lưu ý: </span>Khi bạn xác nhận, đơn hàng của khách sẽ được phê duyệt và chuyển sang trạng thái đang lấy hàng. Vui lòng kiểm tra thông tin đơn hàng trước khi xác nhận.</span>
                                                                    </div>                                                                   
                                                                </div>

                                                                <input type="hidden" name="orderId" value="${o.orderId}">
                                                                <input type="hidden" name="updateStatus" value="Chờ lấy hàng">
                                                                <input type="hidden" name="actionBack" value="viewdetail">
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

                                                            <input type="hidden" name="orderId" value="${o.orderId}">
                                                            <input type="hidden" name="updateStatus" value="Đã huỷ">
                                                            <input type="hidden" name="actionBack" value="viewdetail">
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
                                    </div>

                                    <!-- Package Tracking -->
                                    <div class="card m-4">
                                        <div class="card-body">
                                            <div class="mb-4">
                                                <div class="text-secondary small">Ngày đặt hàng</div>
                                                <div class="h3">${o.orderDate}</div>
                                            </div>

                                            <div class="mb-4">
                                                <div class="text-success fw-bold">
                                                    <c:choose>
                                                        <c:when test="${o.status == 'Chờ xác nhận'}"><div class="text-warning fw-bold">${o.status}</div></c:when>
                                                        <c:when test="${o.status == 'Chờ lấy hàng'}"><div class="text-secondary fw-bold">${o.status}</div></c:when>
                                                        <c:when test="${o.status == 'Chờ giao hàng'}"><div class="text-primary fw-bold">${o.status}</div></c:when>
                                                        <c:when test="${o.status == 'Hoàn thành'}"><div class="text-success fw-bold">Giao hàng thành công</div></c:when>
                                                        <c:otherwise><div class="text-danger fw-bold">${o.status}</div></c:otherwise> 
                                                    </c:choose>
                                                </div>
                                                <c:if test="${o.status == 'Hoàn thành'}">
                                                    <div>${o.finishDate}</div>
                                                </c:if>
                                                <c:if test="${not empty o.reasonCancel && o.status == 'Đã huỷ'}">
                                                    <div><span class="text-danger" style="font-weight: 500;">Lý do huỷ:</span> ${o.reasonCancel}</div>
                                                </c:if>
                                            </div>

                                            <div class="row mb-4">
                                                <div class="col-md-6 mb-3 mb-md-0">
                                                    <h6>Thông tin nhận hàng</h6>
                                                    <div class="d-grid text-secondary">
                                                        <span>Họ tên người nhận: ${o.name}</span>
                                                        <span>Điện thoại: ${o.phone}</span>
                                                        <span>Địa chỉ: ${o.address}</span>
                                                    </div>
                                                    <!-- <address class="text-secondary">
                                                        Jane Doe<br>
                                                        1455 Market Street,<br>
                                                        San Francisco, CA 10977<br>
                                                        United States
                                                    </address> -->
                                                </div>
                                                <div class="col-md-6">
                                                    <h6 style="margin-bottom: 3px;">Phương thức giao hàng</h6>
                                                    <div class="text-secondary">
                                                        ${o.shippingMethodName}
                                                    </div>
                                                    <h6 style="margin: 10px 0 3px 0;">Phương thức thanh toán</h6>
                                                    <div class="text-secondary">
                                                        ${o.paymentMethodName}
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="mb-2">
                                                <div class="fw-bold">Ghi chú giao hàng</div>
                                                <textarea style="color: rgb(108 117 125);" class="form-control" id="exampleFormControlTextarea1" rows="3" readonly>${empty o.note ? 'Không có ghi chú.' : o.note}</textarea>
                                            </div>   

                                            <div class="mb-1">
                                                <p><span style="color: chocolate;"><b>Nhân viên phụ trách: </b></span>${empty o.staffName ? 'Chờ xác nhận...' : o.staffName}</p>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Order Summary -->
                                    <div class="card m-4">
                                        <div class="card-header">
                                            <h2 class="h5 mb-0">Giỏ hàng của ${o.customerName}</h2>
                                        </div>
                                        <div class="card-body" style="padding: 20px 35px;">
                                            <div class="order-item">
                                                <c:forEach items="${orderitems}" var="oi">
                                                    <div class="mb-4">
                                                        <!-- <div class="text-secondary small mb-2">PACKAGE 1 OF 2</div> -->
                                                        <div class="d-flex">
                                                            <div class="position-relative">
                                                                <img src="../../img/products/${oi.productImage}" alt="Product" class="rounded me-3" width="80" height="80">
                                                                <span class="position-absolute top-0 translate-middle badge rounded-pill bg-danger" style="left: 75%;">
                                                                    ${oi.quantity}
                                                                    <span class="visually-hidden">unread messages</span>
                                                                </span>
                                                            </div>
                                                            <div class="flex-grow-1">
                                                                <div class="fw-bold">${oi.productName}</div>
                                                                <div class="text-secondary">
                                                                    <f:formatNumber value="${oi.productPrice}" pattern="#,##0" />đ
                                                                </div>
                                                            </div>
                                                            <div class="fw-bold">
                                                                <f:formatNumber value="${oi.getSubtotal()}" pattern="#,##0" />đ
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>

                                            </div>

                                            <div class="border-top pt-3 mt-4">
                                                <div class="d-flex justify-content-between mb-2">
                                                    <div class="text-secondary">Tạm tính</div>
                                                    <div>
                                                        <f:formatNumber value="${basicPrice}" pattern="#,##0" />đ
                                                    </div>
                                                </div>
                                                <!-- Phí Ship -->
                                                <div class="d-flex justify-content-between mb-2">
                                                    <div class="text-secondary">Phí vận chuyển</div>
                                                    <div>                                                           
                                                        <f:formatNumber value="${o.shippingMethodFee}" pattern="#,##0" />đ 
                                                    </div>
                                                </div>
                                                <div class="d-flex justify-content-between mb-2">
                                                    <div class="text-success">Khuyến mãi</div>
                                                    <div class="text-success">
                                                        <c:choose>
                                                            <c:when test="${o.discountAmount != 0}">
                                                                - <f:formatNumber value="${o.totalAmount - o.discountAmount}" pattern="#,##0" />đ
                                                            </c:when>
                                                            <c:otherwise>
                                                                - <f:formatNumber value="0" pattern="#,##0" />đ
                                                            </c:otherwise>
                                                        </c:choose>

                                                    </div>
                                                </div>
                                                <div class="d-flex justify-content-between align-items-center border-top pt-3 mt-3">
                                                    <h5 class="text-primary m-0">TỔNG TIỀN</h5>

                                                    <c:choose>
                                                        <c:when test="${o.discountAmount != 0}">
                                                            <div class="d-flex align-items-center gap-3">
                                                                <div class="h5 m-0" style="text-decoration: line-through">
                                                                    <f:formatNumber value="${o.totalAmount}" pattern="#,##0" />đ
                                                                </div>
                                                                <div class="h3 m-0 text-danger">
                                                                    <f:formatNumber value="${o.discountAmount}" pattern="#,##0" />đ
                                                                </div>
                                                            </div>

                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="h3 m-0">
                                                                <f:formatNumber value="${o.totalAmount}" pattern="#,##0" />đ
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>                                                                                                       

                                                </div>
                                            </div>
                                        </div>
                                    </div>                                              
                                </div>
                            </c:forEach>

                        </div>
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
                        text: "Chúng tôi sẽ xử lý đơn huỷ và hoàn tiền nếu bạn đã thanh toán.",
                    }).then(() => {
                        document.getElementById("cancelForm").submit(); // Gửi form sau khi hiển thị thông báo thành công
                    });

                });
            }
        });


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
