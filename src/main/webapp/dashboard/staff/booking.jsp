<%-- 
    Document   : booking
    Created on : Feb 11, 2025, 4:53:48 PM
    Author     : Vu Quang Duc - CE181221
--%>
<%@ page import="java.net.URLDecoder, java.nio.charset.StandardCharsets" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.PetHotelBookingDAO, model.PetHotelBooking, java.util.List" %>
<%@ page import="java.text.NumberFormat, java.util.Locale" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;600;800&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="../../css/dashboard.css">
        <title>Quản lí đặt phòng</title>
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
                                <h1>Quản lí các yêu cầu đặt phòng</h1>
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
                                <li class="breadcrumb-item active" aria-current="page">Quản lí yêu cầu đặt phòng</li>
                            </ol>
                        </nav>
                    </div> 

                    <div class="row d-flex align-items-center" style="margin-top: 30px;">
                        <div class="col-md-6 text-start">
                            <form action="pethotelbooking" method="get" class="d-flex mb-3 align-items-center"
                                  style="max-width: 400px; border-radius: 25px; background: #f8f9fa; padding: 5px;">
                                <input type="search" name="search" class="form-control" id="searchInput" placeholder="Nhập từ khóa..."
                                       style="flex: 1; border: none; outline: none; padding: 8px 12px; border-radius: 20px; font-size: 14px;">
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
                                <i class="fa-solid fa-hotel fa-lg"></i>
                                <h4 class="mb-0">Danh sách lịch khách đặt</h4>
                            </div>
                            <div style="padding: 15px 15px 25px 15px;">
                                <ul class="nav nav-tabs">
                                    <li class="nav-item">
                                        <a class="nav-link filter-btn" data-status="all" href="#" style="font-weight: bold; border-width: 2px;">
                                            Tất cả
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link filter-btn" data-status="Đã duyệt" href="#" style="font-weight: bold; border-width: 2px;">
                                            Đã duyệt
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link filter-btn" data-status="Chờ xác nhận" href="#" style="font-weight: bold; border-width: 2px;">
                                            Chờ xác nhận
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link filter-btn" data-status="Đã hủy" href="#" style="font-weight: bold; border-width: 2px">
                                            Đã hủy
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link filter-btn" data-status="Đã nhận phòng" href="#" style="font-weight: bold; border-width: 2px">
                                            Đã nhận phòng
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link filter-btn" data-status="Đã trả phòng" href="#" style="font-weight: bold; border-width: 2px">
                                            Đã trả phòng
                                        </a>
                                    </li>
                                </ul>
                                <div style="padding: 15px 15px 25px 15px;">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th scope="col" style="text-align: center; vertical-align: middle;">Mã đặt lịch</th>
                                                <th scope="col" style="text-align: center; vertical-align: middle;">Khách hàng</th>
                                                <th scope="col" style="text-align: center; vertical-align: middle;">Thú cưng</th>
                                                <th scope="col" style="text-align: center; vertical-align: middle;">Tên phòng</th>
                                                <th scope="col" style="text-align: center; vertical-align: middle;">Check in</th>
                                                <th scope="col" style="text-align: center; vertical-align: middle;">Check out</th>
                                                <th scope="col" style="text-align: center; vertical-align: middle;">Tổng tiền (VND)</th>
                                                <th scope="col" style="text-align: center; vertical-align: middle;">Ngày đặt</th>
                                                <th scope="col" style="text-align: center; vertical-align: middle;">Trạng thái</th>
                                                <th scope="col" style="text-align: center; vertical-align: middle;">Hành động</th>
                                            </tr>

                                        </thead>
                                        <tbody id="bookingTable">
                                            <c:forEach var="booking" items="${bookings}">
                                                <tr class="booking-row" data-status="${booking.status}">
                                                    <td style="cursor: pointer; color: black; text-decoration: none; font-weight: bold; color: #D3A376;"
                                                        onclick="showPopup(${booking.bookingId})">
                                                        ${booking.bookingId}
                                                    </td>
                                                    <td style="font-size: 15px; width: 120px; text-align: center; vertical-align: middle;">
                                                        ${booking.customerName}
                                                    </td>
                                                    <td style="font-size: 15px; width: 100px; text-align: center; vertical-align: middle;">
                                                        ${booking.petName}
                                                    </td>
                                                    <td style="font-size: 15px; width: 110px; text-align: center; vertical-align: middle;">
                                                        ${booking.roomName}
                                                    </td>
                                                    <td style="font-size: 15px; width: 110px; text-align: center; vertical-align: middle;">
                                                        <fmt:formatDate value="${booking.checkIn}" pattern="HH:mm dd/MM/yy"/>
                                                    </td>
                                                    <td style="font-size: 15px; width: 110px; text-align: center; vertical-align: middle;">
                                                        <fmt:formatDate value="${booking.checkOut}" pattern="HH:mm dd/MM/yy"/>
                                                    </td>
                                                    <td style="font-size: 15px; width: 110px; text-align: center; vertical-align: middle;">
                                                        <fmt:formatNumber value="${booking.totalPrice}" type="number" maxFractionDigits="0"/>đ
                                                    </td>
                                                    <td style="font-size: 15px; width: 110px; text-align: center; vertical-align: middle;">
                                                        <fmt:formatDate value="${booking.bookingDate}" pattern="HH:mm dd/MM/yy"/>
                                                    </td>
                                                    <td style="font-size: 15px; width: 110px; text-align: center; vertical-align: middle;">
                                                        <span style="font-weight: bold; padding: 2px; font-size: 13px; color:
                                                              <c:choose>
                                                                  <c:when test="${booking.status eq 'Đã duyệt'}">green</c:when>
                                                                  <c:when test="${booking.status eq 'Đã hủy'}">red</c:when>
                                                                  <c:when test="${booking.status eq 'Đã nhận phòng'}">blue</c:when>
                                                                  <c:when test="${booking.status eq 'Đã trả phòng'}">gray</c:when>
                                                                  <c:otherwise>orange</c:otherwise>
                                                              </c:choose>;">
                                                            ${booking.status}
                                                        </span>
                                                    </td>
                                                    <td style="font-size: 15px; width: 103px; text-align: center; vertical-align: middle;">
                                                        <c:choose>
                                                            <c:when test="${booking.status eq 'Chờ xác nhận'}">
                                                                <form action="pethotelbooking" method="post" style="display:inline;" class="confirm-form">
                                                                    <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                                                    <input type="hidden" name="action" value="approve">
                                                                    <button type="button" class="btn btn-sm btn-primary" data-action="approve" onclick="confirmAction(this)" style="font-size: 12px; padding: 3px 5px;">
                                                                        Duyệt
                                                                    </button>
                                                                </form>
                                                                <form action="pethotelbooking" method="post" style="display:inline;" class="confirm-form">
                                                                    <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                                                    <input type="hidden" name="action" value="cancel">
                                                                    <button type="button" class="btn btn-sm btn-danger" data-action="cancel" onclick="confirmAction(this)" style="font-size: 12px; padding: 3px 5px;">
                                                                        Từ chối
                                                                    </button>
                                                                </form>
                                                            </c:when>
                                                            <c:when test="${booking.status eq 'Đã duyệt'}">
                                                                <form action="pethotelbooking" method="post" style="display:inline;" class="confirm-form">
                                                                    <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                                                    <input type="hidden" name="action" value="checkin">
                                                                    <button type="button" class="btn btn-sm btn-info" data-action="checkin" onclick="confirmAction(this)" style="font-size: 12px; padding: 3px 5px;">
                                                                        Check-in
                                                                    </button>
                                                                </form>

                                                                <!-- Form hủy đặt phòng -->
                                                                <form action="pethotelbooking" method="post" style="display:inline;" class="confirm-form">
                                                                    <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                                                    <input type="hidden" name="action" value="cancel">
                                                                    <button type="button" class="btn btn-sm btn-danger" data-action="cancel" onclick="confirmAction(this)" style="font-size: 12px; padding: 3px 5px;">
                                                                        Hủy
                                                                    </button>
                                                                </form>
                                                            </c:when>

                                                            <c:when test="${booking.status eq 'Đã nhận phòng'}">
                                                                <form action="pethotelbooking" method="post" style="display:inline;" class="confirm-form">
                                                                    <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                                                    <input type="hidden" name="action" value="checkout">
                                                                    <button type="button" class="btn btn-sm btn-secondary" data-action="checkout" onclick="confirmAction(this)" style="font-size: 12px; padding: 3px 5px;">
                                                                        Check-out
                                                                    </button>
                                                                </form>
                                                            </c:when>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                    <div class="pagination" style="display: flex; gap: 5px; align-items: center; justify-content: center; margin-top: 10px;">
                                        <button class="prev-page" disabled style="padding: 5px 10px; border: 1px solid #ccc; background-color: #f0f0f0; border-radius: 5px;">
                                            Previous
                                        </button>

                                        <div id="pageNumbers" style="display: flex; gap: 5px;"></div>

                                        <button class="next-page" style="padding: 5px 10px; border: 1px solid #ccc; background-color: #fff; cursor: pointer; border-radius: 5px;">
                                            Next
                                        </button>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>          
                </div>
            </div>
        </div>
        <!-- Popup hiển thị chi tiết Booking -->
        <div id="bookingPopup" style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); max-width: 1000px; margin: auto; background: #f8f9fa; border-radius: 10px; box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1); padding: 20px;">
            <h5 style="text-align: center; font-size: 24px; font-weight: bold; color: #D3A376; margin-bottom: 20px;">Chi tiết đặt phòng</h5>
            <div style = "text-align: center; font-weight: bold; font-size:20px;" >Mã đơn #<span id="popupBookingId"></span></div>
            <div style="display: flex; flex-direction: row; justify-content: space-between; gap: 20px;">
                <!-- Cột thông tin khách hàng -->
                <div style="flex: 1; background: #eee; padding: 15px; border-radius: 8px; box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);">
                    <h5 style="font-size: 18px; font-weight: 600; margin-bottom: 10px; color: #D3A376;">Thông tin khách hàng</h5>
                    <p><strong>Họ tên:</strong> <span id="popupCustomerName"></span></p>
                    <p><strong>Số điện thoại:</strong> <span id="popupCustomerPhone"></span></p>
                    <p><strong>Email:</strong> <span id="popupCustomerEmail"></span></p>
                </div>

                <!-- Cột thông tin đặt phòng -->
                <div style="flex: 1; background: #eee; padding: 15px; border-radius: 8px; box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);">
                    <h5 style="font-size: 18px; font-weight: 600; margin-bottom: 10px; color: #D3A376;">Thông tin đặt phòng</h5>
                    <p><strong>Tên thú cưng:</strong> <span id="popupPetName"></span></p>
                    <p><strong>Loại:</strong> <span id="popupPetType"></span></p>
                    <p><strong>Giống loài:</strong> <span id="popupPetBreed"></span></p>
                    <p><strong>Cân nặng:</strong> <span id="popupPetWeight"></span></p>
                    <p><strong>Ngày check-in:</strong> <br><span id="popupCheckIn"></span></p>
                    <p><strong>Ngày check-out:</strong> <br><span id="popupCheckOut"></span></p>
                </div>

                <!-- Cột thông tin tổng tiền -->
                <div style="flex: 1; background: #eee; padding: 15px; border-radius: 8px; box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);">
                    <h5 style="font-size: 18px; font-weight: 600; margin-bottom: 10px; color: #D3A376;">Thông tin bổ sung</h5>
                    <p><strong>Ghi chú:</strong> <span id="popupNote"></span></p>
                    <h5 style="font-size: 18px; font-weight: 600; margin-bottom: 10px; color: #D3A376;">Tổng chi phí</h5>
                    <p style="font-size: 20px; font-weight: bold; color: black;"><span id="popupTotalPrice"></span></p>
                </div>
            </div>

            <!-- Nút đóng -->
            <div style="display: flex; justify-content: center; margin-top: 20px;">
                <button onclick="closePopup()" style="padding: 10px 15px; border-radius: 5px; font-size: 14px; font-weight: bold; background-color: #6c757d; color: white; border: none;">Đóng</button>
            </div>
        </div>



        <script>
            // Hàm định dạng số với dấu phẩy phân cách hàng nghìn
            function formatNumber(number) {
                return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            }

            function formatDateTime(dateString) {
                if (!dateString)
                    return "";
                const date = new Date(dateString);
                return new Intl.DateTimeFormat("vi-VN", {
                    hour: "2-digit",
                    minute: "2-digit",
                    day: "2-digit",
                    month: "2-digit",
                    year: "2-digit"
                }).format(date);
            }

            function showPopup(bookingId) {
                fetch("pethotelbooking?bookingId=" + bookingId)
                        .then(response => response.json())
                        .then(data => {
                            if (data) {
                                document.getElementById("popupBookingId").textContent = data.bookingId;
                                document.getElementById("popupCustomerName").textContent = data.customerName;
                                document.getElementById("popupCustomerPhone").textContent = data.customerPhone;
                                document.getElementById("popupCustomerEmail").textContent = data.customerEmail;
                                document.getElementById("popupPetName").textContent = data.petName;
                                document.getElementById("popupPetType").textContent = data.petType;
                                document.getElementById("popupPetBreed").textContent = data.petBreed;
                                document.getElementById("popupPetWeight").textContent = data.petWeight;

                                // Format ngày check-in & check-out
                                document.getElementById("popupCheckIn").textContent = formatDateTime(data.checkIn);
                                document.getElementById("popupCheckOut").textContent = formatDateTime(data.checkOut);

                                document.getElementById("popupNote").textContent = data.note;
                                document.getElementById("popupTotalPrice").textContent = formatNumber(data.totalPrice) + "₫";
                                document.getElementById("bookingPopup").style.display = "block";
                            }
                        })
                        .catch(error => console.error("Lỗi khi lấy booking:", error));
            }


            function closePopup() {
                document.getElementById("bookingPopup").style.display = "none";
            }
        </script>


        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Lấy trạng thái filter từ URL (nếu có)
                const urlParams = new URLSearchParams(window.location.search);
                const currentFilter = urlParams.get("filter") || "all"; // Mặc định "all"

                // Gọi hàm lọc dữ liệu khi trang load
                filterBookings(currentFilter);

                // Đánh dấu nút đang chọn
                document.querySelectorAll(".filter-btn").forEach(button => {
                    if (button.getAttribute("data-status") === currentFilter) {
                        button.classList.add("active");
                    }
                });

                // Gán sự kiện lọc khi nhấn nút
                document.querySelectorAll(".filter-btn").forEach(button => {
                    button.addEventListener("click", function () {
                        const filter = this.getAttribute("data-status");

                        // Cập nhật URL mà không reload trang
                        urlParams.set("filter", filter);
                        window.history.replaceState({}, "", "?" + urlParams.toString());

                        // Lọc danh sách theo trạng thái
                        filterBookings(filter);

                        // Xóa class "active" khỏi các nút và đặt lại
                        document.querySelectorAll(".filter-btn").forEach(btn => btn.classList.remove("active"));
                        this.classList.add("active");
                    });
                });
            });

            // Hàm lọc danh sách theo trạng thái
            function filterBookings(filter) {
                let rows = document.querySelectorAll(".booking-row");
                let hasVisibleRow = false;

                rows.forEach(row => {
                    let status = row.getAttribute("data-status");
                    if (filter === "all" || status === filter) {
                        row.style.display = "";
                        hasVisibleRow = true;
                    } else {
                        row.style.display = "none";
                    }
                });

                // Kiểm tra nếu không có hàng nào hiển thị thì thêm thông báo
                let tableBody = document.getElementById("bookingTable");
                let noDataRow = document.getElementById("noDataRow");

                if (!hasVisibleRow) {
                    if (!noDataRow) {
                        noDataRow = document.createElement("tr");
                        noDataRow.id = "noDataRow";
                        noDataRow.innerHTML = `<td colspan="9" style="color: #856404; text-align: center; background-color: #fff3cd; padding: 12px; border-radius: 5px; margin-top: 10px;">Không có đặt lịch nào!</td>`;
                        tableBody.appendChild(noDataRow);
                    }
                } else {
                    if (noDataRow) {
                        noDataRow.remove();
                    }
                }
            }

        </script>
        <script>
            function setFilterBeforeSubmit(button) {
                const urlParams = new URLSearchParams(window.location.search);
                button.closest("form").querySelector("#currentFilter").value = urlParams.get("filter") || "all";
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            function confirmAction(button) {
                let action = button.getAttribute("data-action");
                let messages = {
                    "approve": {title: "Xác nhận duyệt", text: "Bạn có chắc chắn muốn duyệt đặt phòng này?", color: "#3085d6"},
                    "cancel": {title: "Xác nhận hủy", text: "Bạn có chắc chắn muốn hủy đặt phòng này?", color: "#d33"},
                    "checkin": {title: "Xác nhận Check-in", text: "Khách đã đến nhận phòng?", color: "#28a745"},
                    "checkout": {title: "Xác nhận Check-out", text: "Khách đã trả phòng?", color: "#ffc107"}
                };

                let msg = messages[action];

                Swal.fire({
                    title: msg.title,
                    text: msg.text,
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonColor: msg.color,
                    cancelButtonColor: "#6c757d",
                    confirmButtonText: "Xác nhận",
                    cancelButtonText: "Hủy"
                }).then((result) => {
                    if (result.isConfirmed) {
                        const form = button.closest("form");

                        // Lấy filter từ URL hiện tại
                        const urlParams = new URLSearchParams(window.location.search);
                        const filter = urlParams.get("filter");

                        // Thêm filter vào form nếu có
                        if (filter) {
                            let input = document.createElement("input");
                            input.type = "hidden";
                            input.name = "filter";
                            input.value = filter;
                            form.appendChild(input);
                        }

                        form.submit();
                    }
                });
            }
        </script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                var errorMessage = "<c:out value='${errorMessage}' />";
                if (errorMessage && errorMessage.trim() !== "") {
                    Swal.fire({
                        icon: "error",
                        title: "Hết phòng!",
                        text: errorMessage,
                        confirmButtonText: "OK"
                    });
                }
            });
        </script>
        <%
            session.removeAttribute("errorMessage");
        %>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const rowsPerPage = 10; // Số dòng hiển thị trên mỗi trang
                let currentPage = 1;
                let filteredRows = [];

                const table = document.getElementById("bookingTable");
                const allRows = Array.from(table.getElementsByClassName("booking-row"));
                const prevButton = document.querySelector(".prev-page");
                const nextButton = document.querySelector(".next-page");
                const pageNumbers = document.getElementById("pageNumbers");
                const filterButtons = document.querySelectorAll(".filter-btn");

                function filterRows(status) {
                    if (status === "all") {
                        filteredRows = [...allRows];
                    } else {
                        filteredRows = allRows.filter(row => row.dataset.status === status);
                    }
                    currentPage = 1; // Reset về trang đầu tiên khi thay đổi bộ lọc
                    showPage(currentPage);
                }

                function showPage(page) {
                    currentPage = page;
                    const start = (page - 1) * rowsPerPage;
                    const end = start + rowsPerPage;

                    allRows.forEach(row => row.style.display = "none"); // Ẩn tất cả
                    filteredRows.slice(start, end).forEach(row => row.style.display = ""); // Hiển thị theo trang

                    updatePagination();
                }

                function updatePagination() {
                    const totalPages = Math.max(1, Math.ceil(filteredRows.length / rowsPerPage));
                    const pageNumbersContainer = document.getElementById("pageNumbers");

                    pageNumbersContainer.innerHTML = ""; // Xóa số trang cũ

                    for (let i = 1; i <= totalPages; i++) {
                        const pageButton = document.createElement("button");
                        pageButton.textContent = i;
                        pageButton.style.cssText = `
                                                    padding: 5px 10px;
                                                    border: 1px solid #ccc;
                                                    background-color: #fff;
                                                    cursor: pointer;
                                                    border-radius: 5px;
                                                    transition: 0.3s;
        `;

                        if (i === currentPage) {
                            pageButton.style.backgroundColor = "#ffcc80"; // Màu cam nhạt cho trang hiện tại
                        }

                        pageButton.addEventListener("click", function () {
                            showPage(i);
                        });

                        pageNumbersContainer.appendChild(pageButton);
                    }

                    document.querySelector(".prev-page").disabled = currentPage === 1;
                    document.querySelector(".next-page").disabled = currentPage === totalPages;
                }





                prevButton.addEventListener("click", function () {
                    if (currentPage > 1)
                        showPage(currentPage - 1);
                });

                nextButton.addEventListener("click", function () {
                    if (currentPage < Math.ceil(filteredRows.length / rowsPerPage))
                        showPage(currentPage + 1);
                });

                filterButtons.forEach(button => {
                    button.addEventListener("click", function () {
                        const status = this.dataset.status;
                        filterRows(status);

                        // Xóa class 'active' trên tất cả nút lọc, thêm vào nút đang chọn
                        filterButtons.forEach(btn => btn.classList.remove("active"));
                        this.classList.add("active");
                    });
                });

                // Khởi động với bộ lọc "Tất cả"
                filterRows("all");
            });

        </script>

        <script src="https://kit.fontawesome.com/b3e08bd329.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    </body>
</html>
