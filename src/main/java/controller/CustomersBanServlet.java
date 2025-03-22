/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CustomersDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ADMIN
 */
public class CustomersBanServlet extends HttpServlet {

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
            out.println("<title>Servlet CustomersBanServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CustomersBanServlet at " + request.getContextPath() + "</h1>");
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
        String customerIdStr = request.getParameter("id");
        String action = request.getParameter("action"); // Lấy hành động (ban hoặc unban)

        // Kiểm tra nếu không có ID hoặc action không hợp lệ
        if (customerIdStr == null || action == null || (!action.equals("ban") && !action.equals("unban"))) {
            request.getSession().setAttribute("errorMessage", "Yêu cầu không hợp lệ!");
            response.sendRedirect("customers");
            return;
        }

        try {
            int customerId = Integer.parseInt(customerIdStr.trim()); // Trim để tránh lỗi nhập chuỗi có khoảng trắng
            boolean success = false;

            // Xử lý cấm hoặc bỏ cấm khách hàng
            if ("ban".equals(action)) {
                success = CustomersDAO.deleteCustomer(customerId);
            } else if ("unban".equals(action)) {
                success = CustomersDAO.unbanCustomer(customerId);
            }

            // Kiểm tra kết quả và thêm thông báo
            request.getSession().setAttribute(
                    success ? "successMessage" : "errorMessage",
                    success ? "Thao tác thành công!" : "Thao tác thất bại!"
            );

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "ID khách hàng không hợp lệ!");
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Lỗi hệ thống! Vui lòng thử lại.");
            e.printStackTrace(); // Log lỗi ra console để debug dễ dàng hơn
        }

        // Luôn quay lại danh sách khách hàng sau khi xử lý
        response.sendRedirect("customers");
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
        processRequest(request, response);
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
