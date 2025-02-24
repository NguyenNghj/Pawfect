<%-- 
    Document   : Login
    Created on : Feb 17, 2025, 10:27:58 PM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="./css/login.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <script>
        function validateForm() {
            let isValid = true;
            let email = document.getElementById("email").value;
            let password = document.getElementById("password").value;
            let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

            document.getElementById("emailError").innerHTML = "";
            document.getElementById("passwordError").innerHTML = "";

            if (!emailPattern.test(email)) {
                document.getElementById("emailError").innerHTML = "Email không hợp lệ!";
                isValid = false;
            }

            if (password.length < 6) {
                document.getElementById("passwordError").innerHTML = "Mật khẩu phải có ít nhất 6 ký tự!";
                isValid = false;
            }

            return isValid;
        }
    </script>
   
</head>
<body>
    <div class="wrapper">
        <form action="LoginServlet" method="POST" onsubmit="return validateForm()">
            <h1>Login</h1>
            
            <% if (request.getParameter("error") != null) { %>
                <p style=" text-align: center;">Sai email hoặc mật khẩu. Vui lòng thử lại.</p>
            <% } %>
            
            <div class="input-box">
                <input type="text" id="email" name="email" placeholder="Email" >
                <i class='bx bxs-user icon'></i>
                <span id="emailError" class="error"></span>
            </div>
            
            <div class="input-box">
                <input type="password" id="password" name="password" placeholder="Password" >
                <i class='bx bx-lock-alt icon'></i>
                <span id="passwordError" class="error"></span>
            </div>
            
            <div class="forget-password">
                <a href="forgot-password.jsp">Forget password?</a>
            </div>
            
            <button type="submit" class="btn">Login</button>

            <div class="register-link">
                <p>Don't have an account? <a href="regiser.jsp">Register</a></p>
            </div>
        </form>
               <a href="https://accounts.google.com/o/oauth2/auth?
scope=email%20profile%20openid
&redirect_uri=http://localhost:8080/GoogleLoginServlet
&response_type=code
&client_id=
21377970205-gucvst02847uk8qbv7ia3qvmhgscfi6c.apps.googleusercontent.com
&prompt=consent" 
class="btn bsb-btn-2xl btn-outline-dark rounded-0 d-flex align-items-center">

                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-google text-danger" viewBox="0 0 16 16">
                 a                       <path d="M15.545 6.558a9.42 9.42 0 0 1 .139 1.626c0 2.434-.87 4.492-2.384 5.885h.002C11.978 15.292 10.158 16 8 16A8 8 0 1 1 8 0a7.689 7.689 0 0 1 5.352 2.082l-2.284 2.284A4.347 4.347 0 0 0 8 3.166c-2.087 0-3.86 1.408-4.492 3.304a4.792 4.792 0 0 0 0 3.063h.003c.635 1.893 2.405 3.301 4.492 3.301 1.078 0 2.004-.276 2.722-.764h-.003a3.702 3.702 0 0 0 1.599-2.431H8v-3.08h7.545z" />
                                        </svg>
                                        <span class="ms-2 fs-6 flex-grow-1">Continue with Google</span>
                                    </a>    </div>
</body>
</html>
