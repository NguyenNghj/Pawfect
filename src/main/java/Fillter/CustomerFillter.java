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
    if (path.startsWith(req.getContextPath() + "/css/") ||
        path.startsWith(req.getContextPath() + "/img/") ||
        path.startsWith(req.getContextPath() + "/js/") ||
        path.equals(req.getContextPath() + "/") ||  
        path.startsWith(req.getContextPath() + "/login")||    path.startsWith(req.getContextPath() + "/GoogleLoginServlet")|| path.startsWith(req.getContextPath() + "/compoments/")|| path.startsWith(req.getContextPath() + "/dashboard")|| path.startsWith(req.getContextPath() + "/register")|| path.startsWith(req.getContextPath() + "/forgetpassword")||path.startsWith(req.getContextPath() + "/verify")) {
        chain.doFilter(request, response);
        return;
    }
    boolean hasCustomerId = false;
    Cookie[] cookies = req.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("customerId".equals(cookie.getName())) {
                hasCustomerId = true;
                break;
            }
        }
    }
    if (!hasCustomerId) {
        res.sendRedirect(req.getContextPath() + "/login");
        return;
    }

    chain.doFilter(request, response);
}
}
