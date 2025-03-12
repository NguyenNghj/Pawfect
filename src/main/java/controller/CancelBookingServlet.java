/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.PetHotelBookingDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.PetHotelBooking;

/**
 *
 * @author Nguyen Tien Thanh
 */
public class CancelBookingServlet extends HttpServlet {

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
            out.println("<title>Servlet CancelBookingServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CancelBookingServlet at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        // Lấy bookingId từ request
        String bookingIdStr = request.getParameter("bookingId");
        String staffIdStr = getStaffIdFromCookies(request); // Lấy ID nhân viên từ cookie

        // Kiểm tra bookingId hợp lệ
        if (bookingIdStr != null && !bookingIdStr.isEmpty()) {
            try {
                int bookingId = Integer.parseInt(bookingIdStr);

                // Lấy thông tin booking
                PetHotelBookingDAO bookingDAO = new PetHotelBookingDAO();
                PetHotelBooking booking = bookingDAO.getBookingById(bookingId);

                HttpSession session = request.getSession();
                if (booking != null) {
                    int petId = booking.getPetId(); // Lấy ID thú cưng
                    Integer staffID = (staffIdStr != null && !staffIdStr.isEmpty()) ? Integer.parseInt(staffIdStr) : null;

                    // Gọi DAO để cập nhật trạng thái booking thành "Đã hủy"
                    boolean success;
                    if (staffID != null) {
                        success = bookingDAO.updateBookingStatusWithoutStaff(bookingId, "Đã hủy", petId);
                    } else {
                        success = bookingDAO.updateBookingStatusWithoutStaff(bookingId, "Đã hủy", petId);
                    }

                    if (success) {
                        session.setAttribute("message", "Hủy đặt phòng thành công!");
                        session.setAttribute("messageType", "success");
                    } else {
                        session.setAttribute("message", "Hủy đặt phòng thất bại!");
                        session.setAttribute("messageType", "danger");
                    }
                } else {
                    session.setAttribute("message", "Lỗi: Không tìm thấy thông tin đặt phòng!");
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
        response.sendRedirect("bookinghistory");
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
    // Lấy Cookie nhân viên

    private String getStaffIdFromCookies(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("staffId")) { // Giả sử cookie lưu staffId
                    return cookie.getValue();
                }
            }
        }
        return null;
    }
}
