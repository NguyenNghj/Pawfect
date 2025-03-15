<%--
    Document   : checkoutsuccess
    Created on : Feb 20, 2025, 8:49:54 PM
    Author     : Vu Quang Duc - CE181221
--%>

<%@page import="dao.ProductDAO"%>
<%@page import="model.Product"%>
<%@page import="model.OrderItem"%>
<%@page import="model.Customers"%>
<%@page import="dao.CustomersDAO"%>
<%@page import="model.Order"%>
<%@page import="dao.OrderDAO"%>
<%@page import="java.util.List"%>
<%@page import="util.Email"%>
<%@page import="java.util.concurrent.Executors"%>
<%@page import="java.util.concurrent.ExecutorService"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="jakarta.servlet.http.HttpServletRequest"%>
<%@page import="jakarta.servlet.http.HttpServletResponse"%>
<%@page import="jakarta.servlet.http.Cookie"%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<%-- Lay du lieu tra ve sau khi thanh toan --%>
<%
    Map<String, String> vnp_Params = new HashMap<>();
    Map<String, String[]> parameterMap = request.getParameterMap();
    for (Map.Entry<String, String[]> entry : parameterMap.entrySet()) {
        vnp_Params.put(entry.getKey(), entry.getValue()[0]);
    }

    String vnp_ResponseCode = vnp_Params.get("vnp_ResponseCode");
    String vnp_TransactionNo = vnp_Params.get("vnp_TransactionNo");
    String vnp_Amount = vnp_Params.get("vnp_Amount");
    String vnp_OrderInfo = vnp_Params.get("vnp_OrderInfo");
    String vnp_PayDate = vnp_Params.get("vnp_PayDate");
    String vnp_BankCode = vnp_Params.get("vnp_BankCode");
    String vnp_TransactionStatus = vnp_Params.get("vnp_TransactionStatus");
    boolean paymentSuccess = "00".equals(vnp_ResponseCode);

    int orderId = Integer.parseInt(vnp_OrderInfo);

    // Chuyển đổi định dạng
    String formattedDate = LocalDateTime
            .parse(vnp_PayDate, DateTimeFormatter.ofPattern("yyyyMMddHHmmss"))
            .format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));

    if (vnp_Amount != null) {
        try {
            int amount = Integer.parseInt(vnp_Amount) / 100;
            vnp_Amount = String.format("%,d", amount) + " VNĐ";
        } catch (NumberFormatException e) {
            vnp_Amount = "Không xác định";
        }
    }

%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="./css/vnpay-return.css"/>
        <title>Kết quả thanh toán</title>
    </head>
    <body>
        <div class="container">
            <div class="container-order-success">
                <div class="text-center">
                    <div class="success-icon <%= !paymentSuccess ? "failure-icon" : ""%>">
                        <i class="fas <%= paymentSuccess ? "fa-check" : "fa-times"%>"></i>
                    </div>
                    <h1><%= paymentSuccess ? "Thanh toán thành công!" : "Thanh toán thất bại!"%></h1>
                    <p class="text-muted">
                        <%= paymentSuccess ? "Chúng tôi đã nhận được đơn đặt hàng của bạn và sẽ xử lý trong vòng 2-3 ngày làm việc. Cảm ơn bạn đã tin tưởng và sử dụng dịch vụ của chúng tôi!" : "Vui lòng thử lại hoặc liên hệ hỗ trợ."%>
                    </p>

                    <table class="table">
                        <tr><th>Mã giao dịch:</th><td><%= vnp_TransactionNo != null ? vnp_TransactionNo : "Không có"%></td></tr>
                        <tr><th>Số tiền:</th><td><%= vnp_Amount != null ? vnp_Amount : "Không có"%></td></tr>
                        <tr><th>Thông tin đơn hàng:</th><td><%= vnp_OrderInfo != null ? vnp_OrderInfo : "Không có"%></td></tr>
                        <tr><th>Thời gian thanh toán:</th><td><%= vnp_PayDate != null ? formattedDate : "Không có"%></td></tr>
                        <tr><th>Ngân hàng:</th><td><%= vnp_BankCode != null ? vnp_BankCode : "Không có"%></td></tr>
                        <tr><th>Trạng thái giao dịch:</th><td><%= vnp_TransactionStatus != null ? vnp_TransactionStatus : "Không có"%></td></tr>
                    </table>

                    <div class="d-flex justify-content-center gap-3">
                        <a href="pawfect" class="btn btn-secondary-custom btn-custom">Trở về trang chủ</a>
                        <% if (paymentSuccess) {%>
                        <a href="order?&action=viewdetail&orderId=<%= orderId - 2500000%>" class="btn btn-primary-custom btn-custom">Chi tiết đơn hàng</a>
                        <% }%>
                    </div>
                </div>
            </div>
        </div>


        <% if (!paymentSuccess) {%>
        <script>
            fetch('order?action=delete&orderId=<%= orderId - 2500000%>', {
                method: 'POST'
            }).then(response => console.log("Đơn hàng đã được xóa nếu tồn tại"));
        </script>
        <% } else {%>
        <script>
                fetch('order?action=sendEmail&orderId=<%= orderId - 2500000%>', {
                    method: 'POST'
                }).then(response => console.log("Email đã được gửi"));
        </script>
        <% }%>

    </body>
</html>
