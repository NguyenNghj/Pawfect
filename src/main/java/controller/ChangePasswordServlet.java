/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import static controller.ChangeAdminPasswordServlet.hashMD5;
import dao.CartDAO;
import dao.ChangePasswordDAO;
import dao.ProfileDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.CartItem;
import model.User;

/**
 *
 * @author LENOVO
 */
public class ChangePasswordServlet extends HttpServlet {

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
            out.println("<title>Servlet ChangePasswordServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangePasswordServlet at " + request.getContextPath() + "</h1>");
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
        String customerId = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("customerId".equals(cookie.getName())) {
                    customerId = cookie.getValue();
                    break;
                }
            }
        }

        int totalQuantity = 0;
        // Lay tong so san pham trong gio hang
        List<CartItem> cartItems = CartDAO.getCartByCustomerId(Integer.parseInt(customerId));
        if (!cartItems.isEmpty()) {
            for (CartItem cartItem : cartItems) {
                totalQuantity += cartItem.getQuantity();
            }
        }
        request.setAttribute("totalQuantity", totalQuantity);

        ProfileDAO profileDAO = new ProfileDAO();
        User user = profileDAO.getUser(customerId);
        request.setAttribute("customer", user);
        request.getRequestDispatcher("changepassword.jsp").forward(request, response);
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
        String customerId = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("customerId".equals(cookie.getName())) {
                    customerId = cookie.getValue();
                    break;
                }
            }
        }

        if (customerId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String password = request.getParameter("password");
        String newPassword = request.getParameter("newPassword");

        String hashedOldPassword = hashMD5(password);
        String hashedNewPassword = hashMD5(newPassword);

        ChangePasswordDAO fw = new ChangePasswordDAO();
        if (fw.checkPassword(hashedOldPassword, customerId)) {
            fw.changePassword(hashedNewPassword, customerId);
            request.getSession().setAttribute("message", "Mật khẩu đã được thay đổi thành công! Vui lòng đăng nhập lại.");
            request.getSession().setAttribute("messageType", "success");
            response.sendRedirect(request.getContextPath() + "/changepassword");
        } else {
            request.getSession().setAttribute("message", "Mật khẩu cũ không đúng. Vui lòng thử lại!");
            request.getSession().setAttribute("messageType", "error");
            response.sendRedirect(request.getContextPath() + "/changepassword");
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
