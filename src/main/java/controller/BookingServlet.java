/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CustomersDAO;
import dao.PetDAO;
import dao.PetHotelBookingDAO;
import dao.PetHotelDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import model.Customers;
import model.Pet;
import model.PetHotel;

/**
 *
 * @author Nguyen Tien Thanh
 */
public class BookingServlet extends HttpServlet {

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
            out.println("<title>Servlet BookingServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BookingServlet at " + request.getContextPath() + "</h1>");
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
        System.out.println("=== BookingServlet: doGet START ===");

        // Lấy customerId từ cookie
        Integer customerId = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("customerId".equals(cookie.getName())) {
                    try {
                        customerId = Integer.parseInt(cookie.getValue());
                        System.out.println("Customer ID from cookie: " + customerId);
                    } catch (NumberFormatException e) {
                        System.out.println("ERROR: Invalid customerId in cookie!");
                    }
                    break;
                }
            }
        }

        // Nếu chưa đăng nhập, chuyển hướng về login
        if (customerId == null) {
            System.out.println("ERROR: customerId is null, redirecting to login.");
            response.sendRedirect("login");
            return;
        }

        try {
            // Lấy thông tin khách hàng
            Customers customer = CustomersDAO.getCustomerById(customerId);
            if (customer == null) {
                System.out.println("ERROR: Customer not found for ID: " + customerId);
                response.sendRedirect("error.jsp?message=Customer not found");
                return;
            }
            System.out.println("Customer found: " + customer.getFullName());

            // Lấy roomId từ request
            String roomIdParam = request.getParameter("id");
            System.out.println("Room ID from request: " + roomIdParam);
            if (roomIdParam == null || roomIdParam.isEmpty()) {
                System.out.println("ERROR: roomId is null or empty, redirecting to homepage.");
                response.sendRedirect("homepage.jsp");
                return;
            }

            int roomId;
            try {
                roomId = Integer.parseInt(roomIdParam);
            } catch (NumberFormatException e) {
                System.out.println("ERROR: Invalid room ID format: " + roomIdParam);
                response.sendRedirect("error.jsp?message=Invalid room ID");
                return;
            }

            // Lấy thông tin phòng
            PetHotel room = PetHotelDAO.getPetRoomById(roomId);
            if (room == null) {
                System.out.println("ERROR: Room not found for ID: " + roomId);
                response.sendRedirect("error.jsp?message=Room not found");
                return;
            }
            System.out.println("Room found: " + room.getRoomName());

            // Lấy danh sách thú cưng của khách hàng
            PetDAO petDAO = new PetDAO();
            List<Pet> petList = petDAO.getPetsByCustomerId(customerId);
            if (petList == null || petList.isEmpty()) {
                System.out.println("WARNING: No pets found for customer ID: " + customerId);
            }

            // Truyền dữ liệu sang JSP
            request.setAttribute("customer", customer);
            request.setAttribute("room", room);
            request.setAttribute("petList", petList);
            request.getRequestDispatcher("bookingforcustomer.jsp").forward(request, response);

            System.out.println("=== BookingServlet: doGet END ===");

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("ERROR: Exception occurred: " + e.getClass().getName() + " - " + e.getMessage());
            response.sendRedirect("error.jsp?message=Unexpected error: " + e.getClass().getSimpleName());
        }

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

        try {
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            int roomId = Integer.parseInt(request.getParameter("roomId"));
            int petId = Integer.parseInt(request.getParameter("petId"));

            // Chuyển đổi datetime-local thành Timestamp
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
            LocalDateTime checkInDateTime = LocalDateTime.parse(request.getParameter("checkIn"), formatter);
            LocalDateTime checkOutDateTime = LocalDateTime.parse(request.getParameter("checkOut"), formatter);

            Timestamp checkIn = Timestamp.valueOf(checkInDateTime);
            Timestamp checkOut = Timestamp.valueOf(checkOutDateTime);

            BigDecimal totalPrice = new BigDecimal(request.getParameter("totalPriceHidden"));
            String note = request.getParameter("note");

            // Gọi DAO để tạo booking
            boolean success = PetHotelBookingDAO.createBooking(roomId, customerId, petId, checkIn, checkOut, totalPrice, note);

            if (success) {
                response.sendRedirect("bookinghistory"); // Chuyển hướng sang trang thông báo thành công
            } else {
                response.sendRedirect("pethotel"); // Chuyển hướng sang trang thông báo thất bại
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("booking-error.jsp");
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
