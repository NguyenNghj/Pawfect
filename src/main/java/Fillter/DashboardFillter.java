/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */

package Fillter;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
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
public class DashboardFillter implements Filter {

     @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
          String path = req.getRequestURI();
           
    if (path.startsWith(req.getContextPath() + "/css/") ||
        path.startsWith(req.getContextPath() + "/img/") ||
        path.startsWith(req.getContextPath() + "/js/")) {
        chain.doFilter(request, response);
        return;
    }
        boolean hasStaffId = false;
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("staffId".equals(cookie.getName())) {
                    hasStaffId = true;
                    break;
                }
            }
        }
        
        if (!hasStaffId) {
            res.sendRedirect(req.getContextPath() + "/loginstaff"); 
            return;
        }
        
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}
