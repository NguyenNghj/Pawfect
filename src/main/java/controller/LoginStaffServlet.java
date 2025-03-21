/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import model.Account;
import model.AccountStaff;

/**
 *
 * @author LENOVO
 */
public class LoginStaffServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginStaffServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginStaffServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy danh sách cookie
        Cookie[] cookies = request.getCookies();
        String role = null;
        String staffName = null;
        String staffId = null;
        String customerId = null;

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("staffRole".equals(cookie.getName())) {
                    role = cookie.getValue();
                } else if ("staffName".equals(cookie.getName())) {
                    staffName = cookie.getValue();
                } else if ("staffId".equals(cookie.getName())) {
                    staffId = cookie.getValue();
                } else if ("customerId".equals(cookie.getName())) {
                    customerId = cookie.getValue();
                }
            }
        }

        if (customerId != null) {
            response.sendRedirect("/pawfect");
            return;
        }

        if (role != null && staffName != null && staffId != null) {
            if ("Staff".equals(role)) {
                response.sendRedirect("dashboard/staff/viewcustomersforStaff");
                return;
            } else if ("Admin".equals(role)) {
                response.sendRedirect("/dashboard/admin/statistics");
                return;
            }
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("loginadmin.jsp");
        dispatcher.forward(request, response);

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] hashBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashBytes) {
                sb.append(String.format("%02x", b));
            }
            String hashedPassword = sb.toString();
            UserDAO userDAO = new UserDAO();
            AccountStaff account = new AccountStaff();
            account = userDAO.loginStaff(email, hashedPassword);
            if (!AccountStaff.IsEmpty(account)) {
                Cookie staffId = new Cookie("staffId", account.getStaffId());
                staffId.setMaxAge(60 * 60 * 24 * 1);
                response.addCookie(staffId);
                Cookie staffRole = new Cookie("staffRole", account.getRole());
                staffRole.setMaxAge(60 * 60 * 24 * 1);
                response.addCookie(staffRole);
                Cookie staffName = new Cookie("staffName", account.getUsername());
                staffName.setMaxAge(60 * 60 * 24 * 1);
                response.addCookie(staffName);
                if (account.getRole().equals("Admin")) {
                    response.sendRedirect("dashboard/admin/statistics");
                } else {
                    response.sendRedirect("dashboard/staff/viewcustomersforStaff");
                }
            } else {
                response.sendRedirect("loginadmin.jsp?error=Invalid Credentials");
            }
        } catch (NoSuchAlgorithmException e) {
            throw new ServletException("Lỗi mã hóa mật khẩu MD5", e);
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
