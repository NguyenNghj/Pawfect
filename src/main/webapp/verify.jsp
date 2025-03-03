<%-- 
    Document   : verify
    Created on : Mar 3, 2025, 10:38:51 AM
    Author     : LENOVO
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Xác nhận tài khoản</title>
</head>
<body>
    <h2>Nhập mã xác nhận</h2>
    <form action="verify" method="post">
        <input type="text" name="verificationCode" placeholder="Nhập mã xác nhận" required>
        <button type="submit">Xác nhận</button>
    </form>
</body>
</html>