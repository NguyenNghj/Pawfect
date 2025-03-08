/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.PetHotelBookingDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Nguyen Tien Thanh
 */
public class CancelBookingServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CancelBookingServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CancelBookingServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // Lấy bookingId từ request
        String bookingIdStr = request.getParameter("bookingId");

        // Kiểm tra bookingId hợp lệ
        if (bookingIdStr != null && !bookingIdStr.isEmpty()) {
            try {
                int bookingId = Integer.parseInt(bookingIdStr);
                
                // Gọi DAO để cập nhật trạng thái booking thành "Đã hủy"
                PetHotelBookingDAO bookingDAO = new PetHotelBookingDAO();
                boolean success = bookingDAO.cancelBooking(bookingId);
                
                HttpSession session = request.getSession();
                if (success) {
                    session.setAttribute("message", "Hủy đặt phòng thành công!");
                    session.setAttribute("messageType", "success");
                } else {
                    session.setAttribute("message", "Hủy đặt phòng thất bại!");
                    session.setAttribute("messageType", "danger");
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
                request.getSession().setAttribute("message", "Lỗi: ID đặt phòng không hợp lệ!");
                request.getSession().setAttribute("messageType", "danger");
            }
        } else {
            request.getSession().setAttribute("message", "Lỗi: Không tìm thấy ID đặt phòng!");
            request.getSession().setAttribute("messageType", "danger");
        }

        // Quay lại trang lịch sử đặt phòng
        response.sendRedirect("bookinghistory");    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
