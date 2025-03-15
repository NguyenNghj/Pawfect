/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CartDAO;
import dao.CustomersDAO;
import dao.PetHotelBookingDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.CartItem;
import model.Customers;
import model.PetHotelBooking;

/**
 *
 * @author Nguyen Tien Thanh
 */
public class BookingHistoryServlet extends HttpServlet {

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
            out.println("<title>Servlet BookingHistoryServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BookingHistoryServlet at " + request.getContextPath() + "</h1>");
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

        int id = Integer.parseInt(customerId);
        String status = request.getParameter("status");
        PetHotelBookingDAO bookingDAO = new PetHotelBookingDAO();
        List<PetHotelBooking> booking; // Lấy danh sách đặt phòng
        switch (status) {
            case "dd":
                booking = bookingDAO.getStatusBookingsByCustomerId(id, "Đã duyệt");
                status = "dd";
                break;
            case "cxn":
                booking = bookingDAO.getStatusBookingsByCustomerId(id, "Chờ xác nhận");
                status = "cxn";
                break;
            case "dh":
                booking = bookingDAO.getStatusBookingsByCustomerId(id, "Đã hủy");
                status = "dh";
                break;
            case "dnp":
                booking = bookingDAO.getStatusBookingsByCustomerId(id, "Đã nhận phòng");
                status = "dnp";
                break;
            case "dtp":
                booking = bookingDAO.getStatusBookingsByCustomerId(id, "Đã trả phòng");
                status = "dtp";
                break;
            default:
                booking = bookingDAO.getBookingsByCustomerId(id);
                status = "tc";
        }
        int totalQuantity = 0;
        // Lay tong so san pham trong gio hang
        List<CartItem> cartItems = CartDAO.getCartByCustomerId(id);
        if (!cartItems.isEmpty()) {
            for (CartItem cartItem : cartItems) {
                totalQuantity += cartItem.getQuantity();
            }
        }
        request.setAttribute("totalQuantity", totalQuantity);

        // Lấy thông tin khách hàng
        Customers customer = CustomersDAO.getCustomerById(id);
        //Lấy thông tin booking
        request.setAttribute("status", status);
        request.setAttribute("customer", customer);
        request.setAttribute("booking", booking);
        request.getRequestDispatcher("bookinghistory.jsp").forward(request, response); // Chuyển dữ liệu sang JSP
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
