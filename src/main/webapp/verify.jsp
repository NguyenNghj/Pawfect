<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác nhận tài khoản</title>
    <link rel="stylesheet" href="./css/login.css">
       <link rel="stylesheet" href="./css/verify.css">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    
</head>
<body>
    <div class="wrapper">
        <form action="verify" method="post">
            <h1>Xác nhận tài khoản</h1>

            <% if (request.getAttribute("error") != null) { %>
                <p style="color:red; text-align: center;"><%= request.getAttribute("error") %></p>
            <% } %>

            <% if (request.getAttribute("message") != null) { %>
                <p style="color:green; text-align: center;"><%= request.getAttribute("message") %></p>
            <% } %>

            <div class="input-box">
                <input type="text" name="verificationCode" placeholder="Nhập mã xác nhận" required>
                <i class='bx bx-key icon'></i>
            </div>

            <button type="submit" class="btn">Xác nhận</button>
        </form>
    </div>
</body>
</html>
