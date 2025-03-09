<%-- 
    Document   : newjsp
    Created on : Mar 9, 2025, 9:54:07 AM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
 <html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <link rel="stylesheet" href="./css/register.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>

<body>
    <div class="wrapper">
        <form action="register" method="POST" onsubmit="return validateForm()">

            <h1>Đăng ký</h1>
<% if (request.getAttribute("error") != null) { %>
    <p style="color: black;"><%= request.getAttribute("error") %></p>
<% } %>

            <div class="input-box">  
                <p>Nhập họ và tên của bạn:</p>         
                <input type="text" placeholder="Enter name" name="fullName" id="fullName">
                <span id="fullNameError" class="error"></span>
            </div>

            <div class="input-box">
                <p>Email:</p>  
                <input type="email" placeholder="Enter email" name="email" id="email">
                <span id="emailError" class="error"></span>
            </div>

            <div class="input-box">
                <p>Số điện thoại:</p>
                <input type="tel" placeholder="Enter phone number" name="phoneNumber" id="phoneNumber">
                <span id="phoneError" class="error"></span>
            </div>

            <div class="input-box">
                <p>Nhập mật khẩu:</p>  
                <input type="password" placeholder="Enter password" name="password" id="password">
                <span id="passwordError" class="error"></span>
            </div>

            <div class="input-box">
                <p>Nhập lại mật khẩu:</p>  
                <input type="password" placeholder="Enter password" name="confirmPassword" id="confirmPassword">
                <span id="confirmPasswordError" class="error"></span>
            </div>

            <div class="input-box">
                <p>Nhập ngày tháng năm sinh:</p>  
                <input type="date" name="birthDate" id="birthDate">             
                <span id="birthDateError" class="error"></span>
            </div>

            <div class="input-box">
                <p>Địa chỉ:</p>  
                <input type="text" placeholder="Enter address" name="address" id="address">
                <span id="addressError" class="error"></span>
            </div>

            <div class="gender">
                <p>Giới tính:</p>
                <input type="radio" id="male" name="gender" value="Nam">
                <label for="male">Nam</label>
                <input type="radio" id="female" name="gender" value="Nữ">
                <label for="female">Nữ</label>
                <input type="radio" id="other" name="gender" value="Khác">
                <label for="other">Khác</label>
                <span id="genderError" class="error"></span>
            </div>

            <button type="submit" class="btn">Đăng ký</button>
        </form>
    </div>

    <script>
        function validateForm() {
            let isValid = true;
let name =document.getElementById("fullName").value;
            let email = document.getElementById("email").value;
            let password = document.getElementById("password").value;
            let confirmPassword = document.getElementById("confirmPassword").value;
            let phoneNumber = document.getElementById("phoneNumber").value;
            let birthDate = document.getElementById("birthDate").value;
            let gender = document.querySelector('input[name="gender"]:checked');

            let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            let phonePattern = /^[0-9]{10,11}$/;
 document.getElementById("fullNameError").innerHTML = "";
            document.getElementById("emailError").innerHTML = "";
            document.getElementById("passwordError").innerHTML = "";
            document.getElementById("confirmPasswordError").innerHTML = "";
            document.getElementById("phoneError").innerHTML = "";
            document.getElementById("birthDateError").innerHTML = "";
            document.getElementById("genderError").innerHTML = "";
if (!name) {
                document.getElementById("fullNameError").innerHTML = "Vui lòng điền họ và tên";
                isValid = false;
            }
            if (!emailPattern.test(email)) {
                document.getElementById("emailError").innerHTML = "Email không hợp lệ!";
                isValid = false;
            }

            if (password.length < 6) {
                document.getElementById("passwordError").innerHTML = "Mật khẩu phải có ít nhất 6 ký tự!";
                isValid = false;
            }

            if (password !== confirmPassword) {
                document.getElementById("confirmPasswordError").innerHTML = "Mật khẩu nhập lại không khớp!";
                isValid = false;
            }

            if (!phonePattern.test(phoneNumber)) {
                document.getElementById("phoneError").innerHTML = "Số điện thoại không hợp lệ!";
                isValid = false;
            }

            if (!birthDate) {
                document.getElementById("birthDateError").innerHTML = "Vui lòng chọn ngày sinh!";
                isValid = false;
            }

            if (!gender) {
                document.getElementById("genderError").innerHTML = "Vui lòng chọn giới tính!";
                isValid = false;
            }

            return isValid;
        }
    </script>

</body>
</html>