/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package Fillter;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author LENOVO
 */
public class CustomerFillter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String path = req.getRequestURI();
        String contextPath = req.getContextPath();

        // Các đường dẫn không cần kiểm tra đăng nhập
        if (path.startsWith(contextPath + "/css/")
                || path.startsWith(contextPath + "/img/")
                || path.startsWith(contextPath + "/products")
                || path.startsWith(contextPath + "/product")
                || path.startsWith(contextPath + "/pethotel")
                || path.startsWith(contextPath + "/pethoteldetail")
                || path.startsWith(contextPath + "/js/")
                || path.equals(contextPath + "/")
                || path.startsWith(contextPath + "/login")
                || path.startsWith(contextPath + "/GoogleLoginServlet")
                || path.startsWith(contextPath + "/compoments/")
                || path.startsWith(contextPath + "/dashboard")
                || path.startsWith(contextPath + "/register")
                || path.startsWith(contextPath + "/pawfect")
                || path.startsWith(contextPath + "/forgetpassword")
                || path.startsWith(contextPath + "/verify")
                || path.startsWith(contextPath + "/aboutus")) {
            
            if (path.startsWith(contextPath + "/login")) {
                Cookie[] cookies = req.getCookies();
                if (cookies != null) {
                    for (Cookie cookie : cookies) {
                        if ("staffId".equals(cookie.getName())) {
                            res.sendRedirect(contextPath + "/pawfect");
                            return;
                        }
                    }
                }
            }

            chain.doFilter(request, response);
            return;
        }

        boolean hasCustomerId = false;
        boolean hasStaffId = false;
        Cookie[] cookies = req.getCookies();

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("customerId".equals(cookie.getName())) {
                    hasCustomerId = true;
                }
                if ("staffId".equals(cookie.getName())) {
                    hasStaffId = true;
                }
            }
        }
        // Nếu có cookie customerId mà truy cập /loginstaff, chuyển hướng về /pawfect
        if (hasCustomerId && path.startsWith(contextPath + "/loginstaff")) {
            res.sendRedirect(contextPath + "/pawfect");
            return;
        }

        // Nếu không có customerId thì buộc quay về trang login
        if (!hasCustomerId) {
            res.sendRedirect(contextPath + "/login");
            return;
        }

        chain.doFilter(request, response);
    }
}
